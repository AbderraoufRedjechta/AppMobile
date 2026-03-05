import { UsersService } from './users/users.service';
import { OrdersService } from './orders/orders.service';
import { FinanceService } from './finance/finance.service';
export declare class AdminController {
    private readonly usersService;
    private readonly ordersService;
    private readonly financeService;
    constructor(usersService: UsersService, ordersService: OrdersService, financeService: FinanceService);
    getStats(): Promise<{
        totalOrders: number;
        totalRevenue: number;
        activeCooks: number;
        activeCouriers: number;
        pendingApprovals: number;
    }>;
}
