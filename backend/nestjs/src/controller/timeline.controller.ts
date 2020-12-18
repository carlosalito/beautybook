import { Body, Controller, Delete, Get, HttpCode, Param, Post, Put, Req, UseGuards } from '@nestjs/common';
import { Request } from 'express';
import { RolesAuthGuard } from '../guards/rolesauth.guard';
import { PostModel } from '../models/timeline/post.model';
import { TimelineService } from '../services/timeline.service';

@Controller('timeline')
@UseGuards(RolesAuthGuard)
export class TimelineController {

  constructor(
    private readonly timelineService: TimelineService,
  ) { }

  @Post('/')
  @HttpCode(200)
  async post(
    @Body() body: PostModel,
    @Req() request: Request
  ) {
    const userUid = request.headers.useruid as string;
    return await this.timelineService.post(body, userUid);
  }

  @Get('list/:page')
  @HttpCode(200)
  async list(
    @Param('page') page: string,
  ) {
    return await this.timelineService.list(parseFloat(page));
  }

  @Put('updateGalery/:uid')
  @HttpCode(200)
  async updateGalery(
    @Param('uid') uid: string,
    @Body() body: any) {
    return await this.timelineService.updateGalery(uid, body);
  }

  @Delete('/:uid')
  @HttpCode(200)
  async delete(
    @Param('uid') uid: string
  ) {
    return await this.timelineService.delete(uid);
  }


}
