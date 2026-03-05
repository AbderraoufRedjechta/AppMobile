import { User } from '../users/user.entity';
import { Dish } from '../dishes/dish.entity';
export declare enum OrderStatus {
    PENDING = "PENDING",
    CONFIRMED = "CONFIRMED",
    PREPARING = "PREPARING",
    READY_FOR_PICKUP = "READY_FOR_PICKUP",
    ASSIGNED = "ASSIGNED",
    DELIVERING = "DELIVERING",
    DELIVERED = "DELIVERED",
    CANCELLED = "CANCELLED"
}
export declare class Order {
    id: number;
    client: User;
    cook: User;
    courier: User;
    dish: Dish;
    quantity: number;
    totalAmount: number;
    status: OrderStatus;
    deliveryAddress: string;
    createdAt: Date;
    updatedAt: Date;
}
