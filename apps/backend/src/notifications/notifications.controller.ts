import { Controller, Get, Post, Body, Param, Put } from '@nestjs/common';
import { NotificationsService } from './notifications.service';
import { User } from '../users/user.entity';

@Controller('notifications')
export class NotificationsController {
  constructor(private readonly notificationsService: NotificationsService) {}

  @Get(':userId')
  findByUser(@Param('userId') userId: string) {
    return this.notificationsService.findByUser(+userId);
  }

  @Post()
  create(
    @Body() notificationData: { user: User; title: string; body: string },
  ) {
    // Expecting { user: User, title: string, body: string }
    return this.notificationsService.create(
      notificationData.user,
      notificationData.title,
      notificationData.body,
    );
  }

  @Put(':id/read')
  markAsRead(@Param('id') id: string) {
    return this.notificationsService.markAsRead(+id);
  }
}
