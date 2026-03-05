import { DishesService } from './dishes.service';
import { CreateDishDto } from './dto/create-dish.dto';
export declare class DishesController {
    private readonly dishesService;
    constructor(dishesService: DishesService);
    create(createDishDto: CreateDishDto, cookId: number): Promise<import("./dish.entity").Dish>;
    findAll(): Promise<import("./dish.entity").Dish[]>;
    findByCook(cookId: string): Promise<import("./dish.entity").Dish[]>;
    findOne(id: string): Promise<import("./dish.entity").Dish>;
}
