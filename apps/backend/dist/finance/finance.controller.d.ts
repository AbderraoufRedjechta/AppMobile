import { FinanceService } from './finance.service';
export declare class FinanceController {
    private readonly financeService;
    constructor(financeService: FinanceService);
    getStats(): Promise<{
        totalOrders: number;
        deliveredOrders: number;
        totalVolume: number;
        platformCommission: number;
        courierEarnings: number;
        cookEarnings: number;
    }>;
}
