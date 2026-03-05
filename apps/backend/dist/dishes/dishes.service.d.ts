import { Repository } from 'typeorm';
import { Dish } from './dish.entity';
import { CreateDishDto } from './dto/create-dish.dto';
import { User } from '../users/user.entity';
export declare class DishesService {
    private dishesRepository;
    constructor(dishesRepository: Repository<Dish>);
    create(createDishDto: CreateDishDto, cook: User): Promise<Dish>;
    findAll(): Promise<Dish[]>;
    findByCook(cookId: number): Promise<Dish[]>;
    findOne(id: number): Promise<Dish>;
}
