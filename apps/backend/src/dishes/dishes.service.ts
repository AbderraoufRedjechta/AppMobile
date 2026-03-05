import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Dish } from './dish.entity';
import { CreateDishDto } from './dto/create-dish.dto';
import { User } from '../users/user.entity';

@Injectable()
export class DishesService {
  constructor(
    @InjectRepository(Dish)
    private dishesRepository: Repository<Dish>,
  ) {}

  async create(createDishDto: CreateDishDto, cook: User): Promise<Dish> {
    const dish = this.dishesRepository.create({
      ...createDishDto,
      cook,
    });
    return this.dishesRepository.save(dish);
  }

  async findAll(): Promise<Dish[]> {
    return this.dishesRepository.find({ relations: ['cook'] });
  }

  async findByCook(cookId: number): Promise<Dish[]> {
    return this.dishesRepository.find({
      where: { cook: { id: cookId } },
      relations: ['cook'],
    });
  }

  async findOne(id: number): Promise<Dish> {
    const dish = await this.dishesRepository.findOne({
      where: { id },
      relations: ['cook'],
    });
    if (!dish) {
      throw new NotFoundException(`Dish with ID ${id} not found`);
    }
    return dish;
  }
}
