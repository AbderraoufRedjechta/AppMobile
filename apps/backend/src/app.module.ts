import { Module } from '@nestjs/common';
import { MulterModule } from '@nestjs/platform-express';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { KycModule } from './kyc/kyc.module';
import { DishesModule } from './dishes/dishes.module';
import { OrdersModule } from './orders/orders.module';
import { DisputesModule } from './disputes/disputes.module';
import { FinanceModule } from './finance/finance.module';

@Module({
  imports: [
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
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
