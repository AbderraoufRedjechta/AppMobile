import { OrdersService } from '../orders/orders.service';
export declare class FinanceService {
    private readonly ordersService;
    constructor(ordersService: OrdersService);
    getStats(): Promise<{
        totalOrders: number;
        deliveredOrders: number;
        totalVolume: number;
        platformCommission: number;
        courierEarnings: number;
        cookEarnings: number;
    }>;
}
