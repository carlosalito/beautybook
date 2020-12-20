import { Body, Controller, Get, HttpCode, Param, Post, Put, Req, UseGuards } from '@nestjs/common';
import { Request } from 'express';
import { RolesAuthGuard } from '../guards/rolesauth.guard';
import { UserModel } from '../models/user/user.model';
import { UserService } from '../services/user.service';

@Controller('user')
@UseGuards(RolesAuthGuard)
export class UserController {

	constructor(
		private readonly userService: UserService,
	) {
		// do nothing;
	}

	@Post('/')
	@HttpCode(200)
	async Create(@Body() body: UserModel) {
		return await this.userService.createUser(body);
	}

	@Put('/')
	@HttpCode(200)
	async Update(@Body() body: any) {
		return await this.userService.updateUser(body);
	}

	@Get('/:uid')
	@HttpCode(200)
	async Get(
		@Param('uid') uid: string,
	) {
		return await this.userService.me(uid);
	}

	@Get('updateUserPicture/:action')
	@HttpCode(200)
	async updateUserPicture(
		@Req() request: Request,
		@Param('action') action: string,
	) {
		const userUid = request.headers.useruid as string;
		return await this.userService.updateUserPicture(userUid, action);
	}

	@Get('me/:provider')
	@HttpCode(200)
	async Me(
		@Req() request: Request
	) {
		const userUid = request.headers.useruid as string;
		return await this.userService.me(userUid);
	}


}
