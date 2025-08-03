import { Body, Controller, Get, Inject, Post } from '@nestjs/common';
import { AppService } from './app.service';
import { orderData } from './types/order';
import { ClientKafka } from '@nestjs/microservices';

@Controller()
export class AppController {
  constructor(
    private readonly appService: AppService,
    @Inject('KAFKA_SERVICE_api') private readonly kafkaClient: ClientKafka,
  ) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Post('order')
  createOrder(@Body() orderData: orderData): {
    message: string;
    data: orderData;
  } {
    this.kafkaClient.emit('order_created', orderData);
    return { message: `Order created successfully.`, data: orderData };
  }
}
