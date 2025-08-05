import { config } from 'dotenv';

const envFile = process.env.NODE_ENV === 'production' ? '.env.production' : '.env';
config({ path: envFile });

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';

async function bootstrap() {
  console.log("DATABASE_URL:", process.env.DATABASE_URL);  // cek apakah env sudah terbaca

  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe({
    whitelist: true,
    forbidNonWhitelisted: true,
    transform: true,
  }));

  app.enableCors({
    origin: 'http://localhost:5173', // URL frontend-mu
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS',
    credentials: true,
  });

  const config = new DocumentBuilder()
    .setTitle('IAG Camp API')
    .setDescription('API Documentation for IAG Camp Form')
    .setVersion('1.0')
    .addTag('questions')
    .addTag('answers')
    .addTag('users')
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  await app.listen(process.env.PORT ?? 3000);
}
bootstrap();
