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
exports.UsersService = void 0;
const common_1 = require("@nestjs/common");
const typeorm_1 = require("@nestjs/typeorm");
const typeorm_2 = require("typeorm");
const user_entity_1 = require("./user.entity");
let UsersService = class UsersService {
    usersRepository;
    constructor(usersRepository) {
        this.usersRepository = usersRepository;
    }
    async findOne(email) {
        return this.usersRepository.findOne({ where: { email } });
    }
    async findByPhone(phone) {
        return this.usersRepository.findOne({ where: { phone } });
    }
    async findById(id) {
        const user = await this.usersRepository.findOne({ where: { id } });
        if (!user) {
            throw new common_1.NotFoundException(`User with ID ${id} not found`);
        }
        return user;
    }
    async create(userData) {
        const user = this.usersRepository.create({
            ...userData,
            status: userData.role === user_entity_1.UserRole.CLIENT
                ? user_entity_1.UserStatus.APPROVED
                : user_entity_1.UserStatus.PENDING,
        });
        return this.usersRepository.save(user);
    }
    async findAll() {
        return this.usersRepository.find();
    }
    async findCooks() {
        return this.usersRepository.find({
            where: {
                role: user_entity_1.UserRole.COOK,
                status: user_entity_1.UserStatus.APPROVED,
            },
        });
    }
    async findCouriers() {
        return this.usersRepository.find({
            where: {
                role: user_entity_1.UserRole.COURIER,
                status: user_entity_1.UserStatus.APPROVED,
            },
        });
    }
    async findPending() {
        return this.usersRepository.find({
            where: {
                status: user_entity_1.UserStatus.PENDING,
            },
        });
    }
    async updateStatus(id, status) {
        const user = await this.findById(id);
        user.status = status;
        return this.usersRepository.save(user);
    }
};
exports.UsersService = UsersService;
exports.UsersService = UsersService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, typeorm_1.InjectRepository)(user_entity_1.User)),
    __metadata("design:paramtypes", [typeorm_2.Repository])
], UsersService);
//# sourceMappingURL=users.service.js.map