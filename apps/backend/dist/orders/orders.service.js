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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.OrdersService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const order_entity_1 = require("./order.entity");
let OrdersService = class OrdersService {
    ordersRepository;
    constructor(ordersRepository) {
        this.ordersRepository = ordersRepository;
    }
    async create(createOrderDto, client, cook, dish) {
        const order = this.ordersRepository.create({
            ...createOrderDto,
            client,
            cook,
            dish,
            status: order_entity_1.OrderStatus.PENDING,
        });
        return this.ordersRepository.save(order);
    }
    async findAll() {
        return this.ordersRepository.find({
            relations: ['client', 'cook', 'courier', 'dish'],
        });
    }
    async findOne(id) {
        const order = await this.ordersRepository.findOne({
            where: { id },
            relations: ['client', 'cook', 'courier', 'dish'],
        });
        if (!order) {
            throw new common_1.NotFoundException(`Order with ID ${id} not found`);
        }
        return order;
    }
    async findByClient(clientId) {
        return this.ordersRepository.find({
            where: { client: { id: clientId } },
            relations: ['cook', 'courier', 'dish'],
        });
    }
    async findByCook(cookId) {
        return this.ordersRepository.find({
            where: { cook: { id: cookId } },
            relations: ['client', 'courier', 'dish'],
        });
    }
    async updateStatus(id, status) {
        const order = await this.findOne(id);
        order.status = status;
        return this.ordersRepository.save(order);
    }
    async assignCourier(id, courier) {
        const order = await this.findOne(id);
        order.courier = courier;
        order.status = order_entity_1.OrderStatus.ASSIGNED;
        return this.ordersRepository.save(order);
    }
};
exports.OrdersService = OrdersService;
exports.OrdersService = OrdersService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(order_entity_1.Order)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], OrdersService);
//# sourceMappingURL=orders.service.js.map