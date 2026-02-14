import { Controller, Request, Post, UseGuards, Body } from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) { }

  @Post('login')
  login(@Body() req) {
    return this.authService.login(req);
  }

  @Post('register')
  register(@Body() req) {
    return this.authService.register(req);
  }
}
