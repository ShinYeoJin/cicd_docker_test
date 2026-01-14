FROM node:22-alpine

# APP 폴더를 만들어서 들어감.
WORKDIR /app

# 패키지 파일을 복사해서 설치
COPY package.json ./

# 패키지 설치
RUN npm install

# 파일을 복사해서 빌드
COPY . .

# 빌드 명령어
RUN npm run build

# 3000 포트를 사용
EXPOSE 3000 

# 실행 명령어
CMD [ "npm", "start" ]