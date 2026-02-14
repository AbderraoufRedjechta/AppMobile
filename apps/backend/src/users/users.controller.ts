import { Controller, Get, Body, Patch, Param, UseGuards } from '@nestjs/common';
import { UsersService, UserRole, UserStatus } from './users.service';
import { Roles } from '../auth/roles.decorator';
import { RolesGuard } from '../auth/roles.guard';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@Controller('users')
@UseGuards(JwtAuthGuard, RolesGuard)
export class UsersController {
    constructor(private readonly usersService: UsersService) { }

    @Get()
    @Roles(UserRole.ADMIN)
    findAll() {
        return this.usersService.findAll();
    }

    @Patch(':id/status')
    @Roles(UserRole.ADMIN)
    updateStatus(
        @Param('id') id: string,
        @Body('status') status: UserStatus,
    ) {
        return this.usersService.updateStatus(+id, status);
    }
}
