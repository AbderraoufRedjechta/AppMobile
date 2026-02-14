import { Injectable } from '@nestjs/common';
import { CreateDishDto } from './dto/create-dish.dto';

export interface Dish {
  id: number;
  name: string;
  description: string;
  price: number;
  stock: number;
  image: string;
}

@Injectable()
export class DishesService {
  private dishes: Dish[] = [
    {
      id: 1,
      name: 'Couscous Royal',
      description: 'Couscous traditionnel avec viande d\'agneau, poulet et merguez, légumes de saison',
      price: 800,
      stock: 15,
      image: 'couscous_royal.png',
    },
    {
      id: 2,
      name: 'Tajine Zitoune',
      description: 'Tajine d\'agneau aux olives et citron confit, accompagné de pain maison',
      price: 650,
      stock: 10,
      image: 'tajine_zitoune.png',
    },
    {
      id: 3,
      name: 'Rechta',
      description: 'Pâtes fraîches maison avec sauce blanche et poulet fermier',
      price: 550,
      stock: 12,
      image: 'rechta.png',
    },
    {
      id: 4,
      name: 'Chakhchoukha',
      description: 'Galettes de pain émiettées avec sauce rouge épicée et viande',
      price: 600,
      stock: 8,
      image: 'chakhchoukha.png',
    },
    {
      id: 5,
      name: 'Dolma',
      description: 'Légumes farcis (courgettes, poivrons, tomates) à la viande hachée',
      price: 500,
      stock: 20,
      image: 'dolma.png',
    },
    {
      id: 6,
      name: 'Berkoukes',
      description: 'Grosses perles de couscous avec légumes et viande d\'agneau',
      price: 700,
      stock: 6,
      image: 'berkoukes.png',
    },
  ];
  private idCounter = 7;

  create(createDishDto: CreateDishDto) {
    const dish: Dish = {
      id: this.idCounter++,
      ...createDishDto,
    };
    this.dishes.push(dish);
    return dish;
  }

  findAll() {
    return this.dishes;
  }

  findOne(id: number) {
    return this.dishes.find((dish) => dish.id === id);
  }
}
