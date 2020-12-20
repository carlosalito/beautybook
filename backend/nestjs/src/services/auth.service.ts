import { Injectable } from '@nestjs/common';
import { UserService } from './user.service';

@Injectable()
export class AuthService {
  constructor(private readonly userService: UserService) { }

  async validateUser(token: string): Promise<any> {
    try {
      console.log('validateUser', token);

      const idToken = await this.userService.findOneByToken(token);
      if (!idToken) {
        return null;
      }
      return idToken;
    } catch (error) {
      return null;
    }
  }

}
