import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/data_provider/data.dart';
import 'package:flutter_app_restaurant/models/model.dart';

class OrderRepository{
   OrderDataProvider orderDataProvider;

   OrderRepository({@required this.orderDataProvider});


   Future<List<Order>>getOrders()async{

     return await orderDataProvider.getOrders();
   }

   Future<Order>getOrder(String id)async{

      return await orderDataProvider.getOrder(id);
   }

   Future<Order>postOrder(Order order)async{

      return await orderDataProvider.postOrder(order);
   }

   Future<Order>updateOrder(Order order)async{

      return await orderDataProvider.updateOrder(order);
   }

   Future<void>deleteOrder(String id)async{

      return await orderDataProvider.deleteOrder(id);
   }


}