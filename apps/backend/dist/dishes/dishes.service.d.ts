import { CreateDishDto } from './dto/create-dish.dto';
export interface Dish {
    id: number;
    name: string;
    description: string;
    price: number;
    stock: number;
}
export declare class DishesService {
    private dishes;
    private idCounter;
    create(createDishDto: CreateDishDto): Dish;
    findAll(): Dish[];
    findOne(id: number): Dish | undefined;
}
