import { HttpModule, Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { PassportModule } from '@nestjs/passport';
import { FirebaseModule } from 'nestjs-firebase';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import config from './config/config';
import { TimelineModule } from './modules/timeline.module';
import { UsersModule } from './modules/user.module';
import { HttpStrategy } from './strategy/http.strategy';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    HttpModule.register({
      timeout: 5000,
      maxRedirects: 5,
    }),
    FirebaseModule.forRoot({
      googleApplicationCredential: config.adminSDKFile,
    }),
    PassportModule.register({ defaultStrategy: 'bearer' }),
    UsersModule,
    TimelineModule,
  ],
  controllers: [AppController],
  providers: [AppService, HttpStrategy],
})
export class AppModule { }
