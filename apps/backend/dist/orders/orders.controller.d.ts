import { OrdersService } from './orders.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { OrderStatus } from './order.entity';
export declare class OrdersController {
    private readonly ordersService;
    constructor(ordersService: OrdersService);
    create(createOrderDto: CreateOrderDto, clientId: number, cookId: number, dishId: number): Promise<import("./order.entity").Order>;
    findAll(): Promise<import("./order.entity").Order[]>;
    findByClient(clientId: string): Promise<import("./order.entity").Order[]>;
    findByCook(cookId: string): Promise<import("./order.entity").Order[]>;
    findOne(id: string): Promise<import("./order.entity").Order>;
    updateStatus(id: string, status: OrderStatus): Promise<import("./order.entity").Order>;
}
