import { User } from '../users/user.entity';
import { Order } from '../orders/order.entity';
export declare enum DisputeStatus {
    OPEN = "OPEN",
    RESOLVED = "RESOLVED"
}
export declare class Dispute {
    id: number;
    order: Order;
    user: User;
    reason: string;
    status: DisputeStatus;
    createdAt: Date;
    updatedAt: Date;
}
