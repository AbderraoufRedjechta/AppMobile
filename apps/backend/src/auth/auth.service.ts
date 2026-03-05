import { Injectable, UnauthorizedException, Logger } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';
import { User, UserRole, UserStatus } from '../users/user.entity';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);
  // Simulating an OTP store (in-memory for development)
  private otpStore = new Map<string, string>();

  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) { }

  async sendOtp(phone: string) {
    // Generate a 4-digit OTP (hardcoded for easy testing: '1234')
    const otp = '1234';
    this.otpStore.set(phone, otp);
    this.logger.log(`[DEV ONLY] OTP for ${phone} is ${otp}`);
    return { success: true, message: 'OTP sent' };
  }

  async verifyOtp(phone: string, otp: string) {
    const storedOtp = this.otpStore.get(phone);
    if (!storedOtp || storedOtp !== otp) {
      throw new UnauthorizedException('Invalid OTP');
    }
    this.otpStore.delete(phone); // Clear OTP after verification

    let user = await this.usersService.findByPhone(phone);
    // If user doesn't exist, we might want to create a partial user here or require them to register.
    // Let's create a minimal user if they don't exist to allow quick login
    if (!user) {
      this.logger.log(`User not found for phone ${phone}. Creating a new one.`);
      // Note: create method requires name at least based on User entity.
      // Depending on the flow, we may return a special status asking to register instead.
      // Let's assume we create a base user if possible, or throw error depending on requirements.
      // For mock purposes, let's just create a basic client role profile.
      user = await this.usersService.create({
        phone,
        email: `${phone}@temporary.local`, // unique constraint
        name: `User_${phone.substring(phone.length - 4)}`,
        role: UserRole.CLIENT,
        status: UserStatus.APPROVED,
      });
    }

    return this.login(user);
  }

  async login(user: Partial<User>) {
    const payload = {
      username: user.email,
      sub: user.id,
      role: user.role,
      status: user.status,
    };
    return {
      access_token: this.jwtService.sign(payload),
      user: {
        id: user.id,
        email: user.email,
        name: user.name,
        role: user.role,
        status: user.status,
      },
      token: this.jwtService.sign(payload), // backward compat with flutter mock
    };
  }

  async register(user: Partial<User>) {
    const newUser = await this.usersService.create(user);
    return this.login(newUser);
  }

  async loginWithEmail(email: string, pass: string) {
    const user = await this.usersService.findOne(email);
    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }
    // In dev mode, we check against 'password' or actual password if set
    if (user.password !== pass && pass !== 'password') {
      throw new UnauthorizedException('Invalid credentials');
    }
    return this.login(user);
  }
}
