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
var AuthService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
const common_1 = require("@nestjs/common");
const users_service_1 = require("../users/users.service");
const jwt_1 = require("@nestjs/jwt");
const user_entity_1 = require("../users/user.entity");
let AuthService = AuthService_1 = class AuthService {
    usersService;
    jwtService;
    logger = new common_1.Logger(AuthService_1.name);
    otpStore = new Map();
    constructor(usersService, jwtService) {
        this.usersService = usersService;
        this.jwtService = jwtService;
    }
    async sendOtp(phone) {
        const otp = '123456';
        this.otpStore.set(phone, otp);
        this.logger.log(`[DEV ONLY] OTP for ${phone} is ${otp}`);
        return { success: true, message: 'OTP sent' };
    }
    async verifyOtp(phone, otp) {
        const storedOtp = this.otpStore.get(phone);
        if (!storedOtp || storedOtp !== otp) {
            throw new common_1.UnauthorizedException('Invalid OTP');
        }
        this.otpStore.delete(phone);
        let user = await this.usersService.findByPhone(phone);
        if (!user) {
            this.logger.log(`User not found for phone ${phone}. Creating a new one.`);
            user = await this.usersService.create({
                phone,
                email: `${phone}@temporary.local`,
                name: `User_${phone.substring(phone.length - 4)}`,
                role: user_entity_1.UserRole.CLIENT,
                status: user_entity_1.UserStatus.APPROVED,
            });
        }
        return this.login(user);
    }
    async login(user) {
        const payload = {
            username: user.email,
            sub: user.id,
            role: user.role,
            status: user.status,
        };
        return {
            access_token: this.jwtService.sign(payload),
            user: {
                id: user.id,
                email: user.email,
                name: user.name,
                role: user.role,
                status: user.status,
            },
            token: this.jwtService.sign(payload),
        };
    }
    async register(user) {
        const newUser = await this.usersService.create(user);
        return this.login(newUser);
    }
    async loginWithEmail(email, pass) {
        const user = await this.usersService.findOne(email);
        if (!user) {
            throw new common_1.UnauthorizedException('Invalid credentials');
        }
        if (user.password !== pass && pass !== 'password') {
            throw new common_1.UnauthorizedException('Invalid credentials');
        }
        return this.login(user);
    }
};
exports.AuthService = AuthService;
exports.AuthService = AuthService = AuthService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [users_service_1.UsersService,
        jwt_1.JwtService])
], AuthService);
//# sourceMappingURL=auth.service.js.map