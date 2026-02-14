import { DishesService } from './dishes.service';
import { CreateDishDto } from './dto/create-dish.dto';
export declare class DishesController {
    private readonly dishesService;
    constructor(dishesService: DishesService);
    create(createDishDto: CreateDishDto): import("./dishes.service").Dish;
    findAll(): import("./dishes.service").Dish[];
    findOne(id: string): import("./dishes.service").Dish | undefined;
}
