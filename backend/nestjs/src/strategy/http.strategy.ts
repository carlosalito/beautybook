import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { Strategy } from 'passport-http-bearer';
import { AuthService } from '../services/auth.service';

@Injectable()
export class HttpStrategy extends PassportStrategy(Strategy) {
  constructor(private readonly authService: AuthService) {
    super();
  }

  async validate(token: string) {
    try {
      const user = await this.authService.validateUser(token);
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
