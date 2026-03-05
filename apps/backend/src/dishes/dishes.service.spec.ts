import { Test, TestingModule } from '@nestjs/testing';
import { DishesService } from './dishes.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Dish } from './dish.entity';

describe('DishesService', () => {
  let service: DishesService;

  const mockDishesRepository = {
    find: jest.fn(),
    findOne: jest.fn(),
    create: jest.fn(),
    save: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        DishesService,
        {
          provide: getRepositoryToken(Dish),
          useValue: mockDishesRepository,
        },
      ],
    }).compile();

    service = module.get<DishesService>(DishesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
