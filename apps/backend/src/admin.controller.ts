import { Controller, Get, UseGuards } from '@nestjs/common';
import { UsersService } from './users/users.service';
import { OrdersService } from './orders/orders.service';
import { FinanceService } from './finance/finance.service';
import { JwtAuthGuard } from './auth/jwt-auth.guard';
import { RolesGuard } from './auth/roles.guard';
import { Roles } from './auth/roles.decorator';
import { UserRole } from './users/user.entity';

@Controller('admin')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(UserRole.ADMIN)
export class AdminController {
    constructor(
        private readonly usersService: UsersService,
        private readonly ordersService: OrdersService,
        private readonly financeService: FinanceService,
    ) { }

    @Get('stats')
    async getStats() {
        const [orders, cooks, couriers, pending, financeStats] = await Promise.all([
            this.ordersService.findAll(),
            this.usersService.findCooks(),
            this.usersService.findCouriers(),
            this.usersService.findPending(),
            this.financeService.getStats(),
        ]);

        return {
            totalOrders: orders.length,
            totalRevenue: financeStats.totalVolume,
            activeCooks: cooks.length,
            activeCouriers: couriers.length,
            pendingApprovals: pending.length,
        };
    }
}
