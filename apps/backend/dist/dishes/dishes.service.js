"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.DishesService = void 0;
const common_1 = require("@nestjs/common");
let DishesService = class DishesService {
    dishes = [];
    idCounter = 1;
    create(createDishDto) {
        const dish = {
            id: this.idCounter++,
            ...createDishDto,
        };
        this.dishes.push(dish);
        return dish;
    }
    findAll() {
        return this.dishes;
    }
    findOne(id) {
        return this.dishes.find(dish => dish.id === id);
    }
};
exports.DishesService = DishesService;
exports.DishesService = DishesService = __decorate([
    (0, common_1.Injectable)()
], DishesService);
//# sourceMappingURL=dishes.service.js.map