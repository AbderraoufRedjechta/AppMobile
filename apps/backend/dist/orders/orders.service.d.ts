import { CreateOrderDto } from './dto/create-order.dto';
export interface Order {
    id: number;
    items: number[];
    total: number;
    status: 'PENDING' | 'PREPARING' | 'DELIVERING' | 'DELIVERED';
    createdAt: Date;
}
export declare class OrdersService {
    private orders;
    private idCounter;
    create(createOrderDto: CreateOrderDto): Order;
    findAll(): Order[];
    findOne(id: number): Order | undefined;
}
