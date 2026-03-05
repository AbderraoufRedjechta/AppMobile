import { DisputesService } from './disputes.service';
import { CreateDisputeDto } from './dto/create-dispute.dto';
export declare class DisputesController {
    private readonly disputesService;
    constructor(disputesService: DisputesService);
    create(createDisputeDto: CreateDisputeDto): Promise<import("./dispute.entity").Dispute>;
    findAll(): Promise<import("./dispute.entity").Dispute[]>;
    resolve(id: string): Promise<import("./dispute.entity").Dispute>;
}
