import { Repository } from 'typeorm';
import { Order, OrderStatus } from './order.entity';
import { CreateOrderDto } from './dto/create-order.dto';
import { User } from '../users/user.entity';
import { Dish } from '../dishes/dish.entity';
export declare class OrdersService {
    private ordersRepository;
    constructor(ordersRepository: Repository<Order>);
    create(createOrderDto: CreateOrderDto, client: User, cook: User, dish: Dish): Promise<Order>;
    findAll(): Promise<Order[]>;
    findOne(id: number): Promise<Order>;
    findByClient(clientId: number): Promise<Order[]>;
    findByCook(cookId: number): Promise<Order[]>;
    updateStatus(id: number, status: OrderStatus): Promise<Order>;
    assignCourier(id: number, courier: User): Promise<Order>;
}
