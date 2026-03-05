import { Controller, Post, Body, UnauthorizedException } from '@nestjs/common';
import { AuthService } from './auth.service';
import { User } from '../users/user.entity';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) { }

  @Post('send-otp')
  async sendOtp(@Body() req: { phone: string }) {
    if (!req.phone) {
      throw new UnauthorizedException('Phone number is required');
    }
    return this.authService.sendOtp(req.phone);
  }

  @Post('verify-otp')
  async verifyOtp(@Body() req: { phone: string; otp: string }) {
    if (!req.phone || !req.otp) {
      throw new UnauthorizedException('Phone number and OTP are required');
    }
    return this.authService.verifyOtp(req.phone, req.otp);
  }

  @Post('register')
  async register(@Body() req: Partial<User>) {
    return this.authService.register(req);
  }

  @Post('login')
  async login(@Body() req: { email: string; pass: string }) {
    return this.authService.loginWithEmail(req.email, req.pass || (req as any).password);
  }
}
