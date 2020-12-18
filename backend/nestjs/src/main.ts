import { NestFactory } from '@nestjs/core';
import { ExpressAdapter } from '@nestjs/platform-express';
import express from 'express';
import { AppModule } from './app.module';

const server: express.Express = express();

server.use(express.json());
server.use(express.urlencoded({ extended: false }));

async function bootstrap(expressInstance: express.Express) {
  const app = await NestFactory.create(
    AppModule,
    new ExpressAdapter(expressInstance),
  );

  app.setGlobalPrefix('api');

  app.enableCors();
  await app.init();
  await app.listen(process.env.PORT);
}

console.log('Server listen ', process.env.PORT)
bootstrap(server);
