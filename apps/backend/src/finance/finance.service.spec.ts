import { Test, TestingModule } from '@nestjs/testing';
import { FinanceService } from './finance.service';
import { OrdersService } from '../orders/orders.service';

describe('FinanceService', () => {
  let service: FinanceService;
  let ordersService: OrdersService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        FinanceService,
        {
          provide: OrdersService,
          useValue: {
            findAll: jest.fn().mockReturnValue([
              { id: 1, total: 1000, status: 'DELIVERED' },
              { id: 2, total: 2000, status: 'PENDING' },
            ]),
          },
        },
      ],
    }).compile();

    service = module.get<FinanceService>(FinanceService);
    ordersService = module.get<OrdersService>(OrdersService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should calculate stats correctly', () => {
    const stats = service.getStats();
    expect(stats.totalOrders).toBe(2);
    expect(stats.deliveredOrders).toBe(1);
    expect(stats.totalVolume).toBe(1000);
    expect(stats.platformCommission).toBe(100); // 10% of 1000
    expect(stats.courierEarnings).toBe(200);
  });
});
