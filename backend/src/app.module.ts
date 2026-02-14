import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { ConfigModule, ConfigService } from "@nestjs/config";
import { databaseConfig } from "./config/database.config";

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: ".env",
    }),
    TypeOrmModule.forRootAsync(databaseConfig),
  ],
})
export class AppModule {
  constructor(configService: ConfigService) {
    console.log("DB_USER =", configService.get("DB_USER"));
    console.log("DB_NAME =", configService.get("DB_NAME"));
  }
}
