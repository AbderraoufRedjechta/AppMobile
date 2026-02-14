import { OrdersService } from './orders.service';
import { CreateOrderDto } from './dto/create-order.dto';
export declare class OrdersController {
    private readonly ordersService;
    constructor(ordersService: OrdersService);
    create(createOrderDto: CreateOrderDto): import("./orders.service").Order;
    findAll(): import("./orders.service").Order[];
    findOne(id: string): import("./orders.service").Order | undefined;
}
