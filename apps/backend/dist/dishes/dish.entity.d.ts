import { User } from '../users/user.entity';
export declare class Dish {
    id: number;
    name: string;
    description: string;
    price: number;
    stock: number;
    image: string;
    cook: User;
    createdAt: Date;
    updatedAt: Date;
}
