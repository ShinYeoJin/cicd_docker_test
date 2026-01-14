import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      // 기본값은 로컬 개발 환경(docker-compose 등)을 고려하고,
      // Railway 등 배포 환경에서는 환경변수로 덮어쓸 수 있게 합니다.
      host: process.env.DB_HOST ?? 'localhost',
      port: Number(process.env.DB_PORT ?? 3306),
      username: process.env.DB_USER ?? 'yj',
      password: process.env.DB_PASSWORD ?? '1234',
      database: process.env.DB_NAME ?? 'test',
      synchronize: true,
      entities: [__dirname + '/**/*.entity{.ts,.js}'],
    }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
