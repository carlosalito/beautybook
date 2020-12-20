import { ExecutionContext, ForbiddenException, Injectable, UnauthorizedException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AuthGuard } from '@nestjs/passport';

@Injectable()
export class RolesAuthGuard extends AuthGuard('bearer') {
  myContext: ExecutionContext;
  constructor(private readonly reflector: Reflector) {
    super();
  }

  canActivate(context: ExecutionContext) {
    this.myContext = context;
    const request = context.switchToHttp().getRequest();
    const url = request.url;
    const auth = request.headers.authorization;
    const publicToken = `Bearer ${process.env.PUBLIC_TOKEN}`;
    console.log('URL', url);
    if (auth === publicToken) {
      console.log('liberando master');
      return true;
    }

    if (
      (
        url.indexOf('/user/create') >= 0 ||
        url.indexOf('/timeline/list') >= 0 ||
        url.indexOf('/user/check') >= 0
      ) &&
      auth === publicToken
    ) {
      console.log('Liberando rota aberta');
      return true;
    } else {
      if (auth.split('-').length !== 3) {
        throw new UnauthorizedException({ error: 'noValidToken' });
      }

      return super.canActivate(this.myContext);
    }
  }

  handleRequest(err, user, info) {

    if (err || !user) {
      console.log('AUTH', err, user);
      throw err || new UnauthorizedException();
    }

    const rolesFromController = this.reflector.get<string[]>('roles', this.myContext.getClass());
    const rolesFromAction = this.reflector.get<string[]>('roles', this.myContext.getHandler());

    let hasRole;
    if (rolesFromController) {
      hasRole = () => user.roles.some((role) => (rolesFromController as any).includes(role));
    } else if (rolesFromAction) {
      hasRole = () => user.roles.some((role) => (rolesFromAction as any).includes(role));
    } else { return true; }

    if (!hasRole()) {
      throw err || new ForbiddenException();
    }

    return user;

  }

}
