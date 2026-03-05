import { Repository } from 'typeorm';
import { Notification } from './notification.entity';
import { User } from '../users/user.entity';
export declare class NotificationsService {
    private notificationsRepository;
    constructor(notificationsRepository: Repository<Notification>);
    findByUser(userId: number): Promise<Notification[]>;
    create(user: User, title: string, body: string): Promise<Notification>;
    markAsRead(id: number): Promise<Notification | null>;
}
