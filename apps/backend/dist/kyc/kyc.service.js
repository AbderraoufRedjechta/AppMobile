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
exports.KycService = void 0;
const common_1 = require("@nestjs/common");
const users_service_1 = require("../users/users.service");
const user_entity_1 = require("../users/user.entity");
let KycService = class KycService {
    usersService;
    constructor(usersService) {
        this.usersService = usersService;
    }
    async updateKycDocuments(userId, documents) {
        const user = await this.usersService.findById(userId);
        if (!user) {
            throw new common_1.NotFoundException(`User with ID ${userId} not found`);
        }
        if (documents.cni_front)
            user.cniFront = documents.cni_front[0].filename;
        if (documents.cni_back)
            user.cniBack = documents.cni_back[0].filename;
        if (documents.kitchen_photo) {
            user.kitchenPhotos = documents.kitchen_photo.map((file) => file.filename);
        }
        user.kycStatus = user_entity_1.UserStatus.PENDING;
        return this.usersService.create(user);
    }
};
exports.KycService = KycService;
exports.KycService = KycService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [users_service_1.UsersService])
], KycService);
//# sourceMappingURL=kyc.service.js.map