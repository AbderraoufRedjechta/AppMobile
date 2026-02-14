import { Injectable } from '@nestjs/common';
import { CreateDisputeDto } from './dto/create-dispute.dto';

export interface Dispute {
  id: number;
  orderId: number;
  reason: string;
  status: 'OPEN' | 'RESOLVED';
  createdAt: Date;
}

@Injectable()
export class DisputesService {
  private disputes: Dispute[] = [];
  private idCounter = 1;

  create(createDisputeDto: CreateDisputeDto) {
    const dispute: Dispute = {
      id: this.idCounter++,
      ...createDisputeDto,
      status: 'OPEN',
      createdAt: new Date(),
    };
    this.disputes.push(dispute);
    return dispute;
  }

  findAll() {
    return this.disputes;
  }

  resolve(id: number) {
    const dispute = this.disputes.find((d) => d.id === id);
    if (dispute) {
      dispute.status = 'RESOLVED';
      return dispute;
    }
    return null;
  }
}
