import { CreateDisputeDto } from './dto/create-dispute.dto';
import { Repository } from 'typeorm';
import { Dispute } from './dispute.entity';
import { OrdersService } from '../orders/orders.service';
import { User } from '../users/user.entity';
export declare class DisputesService {
    private disputesRepository;
    private ordersService;
    constructor(disputesRepository: Repository<Dispute>, ordersService: OrdersService);
    create(createDisputeDto: CreateDisputeDto, user: User): Promise<Dispute>;
    findAll(): Promise<Dispute[]>;
    resolve(id: number): Promise<Dispute>;
}
