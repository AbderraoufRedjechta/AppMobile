import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { DisputesService } from './disputes.service';
import { CreateDisputeDto } from './dto/create-dispute.dto';
import { User, UserRole } from '../users/user.entity';

@Controller('disputes')
export class DisputesController {
  constructor(private readonly disputesService: DisputesService) {}

  @Post()
  create(@Body() createDisputeDto: CreateDisputeDto) {
    // TODO: Get actual user from request (req.user) using JwtAuthGuard
    // Mocking user for now to satisfy service signature
    const mockUser = { id: 1, role: UserRole.CLIENT } as User;
    return this.disputesService.create(createDisputeDto, mockUser);
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
