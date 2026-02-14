import { Injectable } from '@nestjs/common';
import { OrdersService } from '../orders/orders.service';

@Injectable()
export class FinanceService {
  constructor(private readonly ordersService: OrdersService) {}

  getStats() {
    const orders = this.ordersService.findAll();
    const deliveredOrders = orders.filter((o) => o.status === 'DELIVERED');

    const totalVolume = deliveredOrders.reduce((sum, o) => sum + o.total, 0);
    const platformCommission = totalVolume * 0.1; // 10% commission
    const courierEarnings = deliveredOrders.length * 200; // 200 DA per delivery
    const cookEarnings = totalVolume - platformCommission; // Simplified

    return {
      totalOrders: orders.length,
      deliveredOrders: deliveredOrders.length,
      totalVolume,
      platformCommission,
      courierEarnings,
      cookEarnings,
    };
  }
}
