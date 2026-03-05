import { Dish } from '../dishes/dish.entity';
import { Order } from '../orders/order.entity';
export declare enum UserRole {
    CLIENT = "CLIENT",
    COOK = "COOK",
    COURIER = "COURIER",
    ADMIN = "ADMIN"
}
export declare enum UserStatus {
    PENDING = "PENDING",
    APPROVED = "APPROVED",
    REJECTED = "REJECTED"
}
export declare class User {
    id: number;
    email: string;
    password?: string;
    name: string;
    phone?: string;
    avatar?: string;
    role: UserRole;
    status: UserStatus;
    dishes: Dish[];
    clientOrders: Order[];
    cniFront?: string;
    cniBack?: string;
    kitchenPhotos?: string[];
    kycStatus: UserStatus;
    cookOrders: Order[];
    courierMissions: Order[];
    createdAt: Date;
    updatedAt: Date;
}
