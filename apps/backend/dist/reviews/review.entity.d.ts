import { User } from '../users/user.entity';
import { Dish } from '../dishes/dish.entity';
import { Order } from '../orders/order.entity';
export declare class Review {
    id: number;
    order: Order;
    dish: Dish;
    author: User;
    rating: number;
    comment: string;
    createdAt: Date;
}
