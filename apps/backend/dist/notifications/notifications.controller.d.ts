import { NotificationsService } from './notifications.service';
import { User } from '../users/user.entity';
export declare class NotificationsController {
    private readonly notificationsService;
    constructor(notificationsService: NotificationsService);
    findByUser(userId: string): Promise<import("./notification.entity").Notification[]>;
    create(notificationData: {
        user: User;
        title: string;
        body: string;
    }): Promise<import("./notification.entity").Notification>;
    markAsRead(id: string): Promise<import("./notification.entity").Notification | null>;
}
