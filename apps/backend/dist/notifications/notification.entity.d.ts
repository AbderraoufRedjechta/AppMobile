import { User } from '../users/user.entity';
export declare class Notification {
    id: number;
    user: User;
    title: string;
    body: string;
    isRead: boolean;
    createdAt: Date;
}
