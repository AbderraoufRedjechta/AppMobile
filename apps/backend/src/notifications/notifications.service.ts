import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Notification } from './notification.entity';
import { User } from '../users/user.entity';

@Injectable()
export class NotificationsService {
  constructor(
    @InjectRepository(Notification)
    private notificationsRepository: Repository<Notification>,
  ) {}

  findByUser(userId: number): Promise<Notification[]> {
    return this.notificationsRepository.find({
      where: { user: { id: userId } },
      order: { createdAt: 'DESC' },
    });
  }

  create(user: User, title: string, body: string): Promise<Notification> {
    const notification = this.notificationsRepository.create({
      user,
      title,
      body,
    });
    return this.notificationsRepository.save(notification);
  }

  async markAsRead(id: number): Promise<Notification | null> {
    const notification = await this.notificationsRepository.findOne({
      where: { id },
    });
    if (notification) {
      notification.isRead = true;
      return this.notificationsRepository.save(notification);
    }
    return null;
  }
}
