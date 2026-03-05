"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AppModule = void 0;
const common_1 = require("@nestjs/common");
const platform_express_1 = require("@nestjs/platform-express");
const config_1 = require("@nestjs/config");
const database_module_1 = require("./database.module");
const app_controller_1 = require("./app.controller");
const app_service_1 = require("./app.service");
const auth_module_1 = require("./auth/auth.module");
const users_module_1 = require("./users/users.module");
const kyc_module_1 = require("./kyc/kyc.module");
const dishes_module_1 = require("./dishes/dishes.module");
const orders_module_1 = require("./orders/orders.module");
const disputes_module_1 = require("./disputes/disputes.module");
const finance_module_1 = require("./finance/finance.module");
const notifications_module_1 = require("./notifications/notifications.module");
const reviews_module_1 = require("./reviews/reviews.module");
const admin_controller_1 = require("./admin.controller");
let AppModule = class AppModule {
};
exports.AppModule = AppModule;
exports.AppModule = AppModule = __decorate([
    (0, common_1.Module)({
        imports: [
            config_1.ConfigModule.forRoot({ isGlobal: true }),
            database_module_1.DatabaseModule,
            users_module_1.UsersModule,
            auth_module_1.AuthModule,
            dishes_module_1.DishesModule,
            orders_module_1.OrdersModule,
            disputes_module_1.DisputesModule,
            finance_module_1.FinanceModule,
            platform_express_1.MulterModule.register({
                dest: './uploads',
            }),
            kyc_module_1.KycModule,
            notifications_module_1.NotificationsModule,
            reviews_module_1.ReviewsModule,
        ],
        controllers: [app_controller_1.AppController, admin_controller_1.AdminController],
        providers: [app_service_1.AppService],
    })
], AppModule);
//# sourceMappingURL=app.module.js.map