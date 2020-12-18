import { Module } from '@nestjs/common';
import { UserController } from '../controller/user.controller';
import { UserService } from '../services/user.service';
import { UtilsService } from '../services/utils.service';

@Module({
    imports: [],
    providers: [UserService, UtilsService],
    controllers: [UserController]
})
export class UsersModule { }
