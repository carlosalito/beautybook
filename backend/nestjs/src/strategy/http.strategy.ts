import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { FirebaseAdmin, InjectFirebaseAdmin } from 'nestjs-firebase';
import { Strategy } from 'passport-http-bearer';

@Injectable()
export class HttpStrategy extends PassportStrategy(Strategy) {
  constructor(
    @InjectFirebaseAdmin() private readonly firebase: FirebaseAdmin) {
    super();
  }

  async validate(token: string) {
    try {
      const user = await this.firebase.auth.verifyIdToken(token);
      if (!user) {
        throw new UnauthorizedException();
      }
      return user;
    } catch (err) {
      console.log(err);
      throw new UnauthorizedException();
    }
  }
}
