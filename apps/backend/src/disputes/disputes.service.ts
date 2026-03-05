import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateDisputeDto } from './dto/create-dispute.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Dispute, DisputeStatus } from './dispute.entity';
import { OrdersService } from '../orders/orders.service';
import { User } from '../users/user.entity';

@Injectable()
export class DisputesService {
  constructor(
    @InjectRepository(Dispute)
    private disputesRepository: Repository<Dispute>,
    private ordersService: OrdersService,
  ) {}

  async create(
    createDisputeDto: CreateDisputeDto,
    user: User,
  ): Promise<Dispute> {
    const order = await this.ordersService.findOne(createDisputeDto.orderId);
    if (!order) {
      throw new NotFoundException(
        `Order with ID ${createDisputeDto.orderId} not found`,
      );
    }

    const dispute = this.disputesRepository.create({
      order,
      user,
      reason: createDisputeDto.reason,
      status: DisputeStatus.OPEN,
    });

    return this.disputesRepository.save(dispute);
  }

  async findAll(): Promise<Dispute[]> {
    return this.disputesRepository.find({ relations: ['order', 'user'] });
  }

  async resolve(id: number): Promise<Dispute> {
    const dispute = await this.disputesRepository.findOne({ where: { id } });
    if (!dispute) {
      throw new NotFoundException(`Dispute with ID ${id} not found`);
    }

    dispute.status = DisputeStatus.RESOLVED;
    return this.disputesRepository.save(dispute);
  }
}
