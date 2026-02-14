import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { DisputesService } from './disputes.service';
import { CreateDisputeDto } from './dto/create-dispute.dto';

@Controller('disputes')
export class DisputesController {
  constructor(private readonly disputesService: DisputesService) {}

  @Post()
  create(@Body() createDisputeDto: CreateDisputeDto) {
    return this.disputesService.create(createDisputeDto);
  }

  @Get()
  findAll() {
    return this.disputesService.findAll();
  }

  @Post(':id/resolve')
  resolve(@Param('id') id: string) {
    return this.disputesService.resolve(+id);
  }
}
