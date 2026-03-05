"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AdminController = void 0;
const common_1 = require("@nestjs/common");
const users_service_1 = require("./users/users.service");
const orders_service_1 = require("./orders/orders.service");
const finance_service_1 = require("./finance/finance.service");
const jwt_auth_guard_1 = require("./auth/jwt-auth.guard");
const roles_guard_1 = require("./auth/roles.guard");
const roles_decorator_1 = require("./auth/roles.decorator");
const user_entity_1 = require("./users/user.entity");
let AdminController = class AdminController {
    usersService;
    ordersService;
    financeService;
    constructor(usersService, ordersService, financeService) {
        this.usersService = usersService;
        this.ordersService = ordersService;
        this.financeService = financeService;
    }
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
};
exports.AdminController = AdminController;
__decorate([
    (0, common_1.Get)('stats'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], AdminController.prototype, "getStats", null);
exports.AdminController = AdminController = __decorate([
    (0, common_1.Controller)('admin'),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard, roles_guard_1.RolesGuard),
    (0, roles_decorator_1.Roles)(user_entity_1.UserRole.ADMIN),
    __metadata("design:paramtypes", [users_service_1.UsersService,
        orders_service_1.OrdersService,
        finance_service_1.FinanceService])
], AdminController);
//# sourceMappingURL=admin.controller.js.map