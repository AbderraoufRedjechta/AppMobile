import { Module } from '@nestjs/common';
import { MulterModule } from '@nestjs/platform-express';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './database.module';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { KycModule } from './kyc/kyc.module';
import { DishesModule } from './dishes/dishes.module';
import { OrdersModule } from './orders/orders.module';
import { DisputesModule } from './disputes/disputes.module';
import { FinanceModule } from './finance/finance.module';
import { NotificationsModule } from './notifications/notifications.module';
import { ReviewsModule } from './reviews/reviews.module';
import { AdminController } from './admin.controller';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    DatabaseModule,
    UsersModule,
    AuthModule,
    DishesModule,
    OrdersModule,
    DisputesModule,
    FinanceModule,
    MulterModule.register({
      dest: './uploads',
    }),
    KycModule,
    NotificationsModule,
    ReviewsModule,
  ],
  controllers: [AppController, AdminController],
  providers: [AppService],
})
export class AppModule { }
