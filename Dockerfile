FROM node:22-alpine AS builder

WORKDIR /app

# 의존성 설치를 캐시하기 위해 package-lock 포함
COPY package.json package-lock.json ./
RUN npm ci

# 전체 소스 복사 후 빌드
COPY . .
RUN npm run build

# 실행 전용 경량 이미지
FROM node:22-alpine AS runner
WORKDIR /app

# 실행에 필요한 파일만 복사
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/main.js"]