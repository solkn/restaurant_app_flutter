import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/models/model.dart';
import 'package:flutter_app_restaurant/util/util.dart';
import 'package:http/http.dart'as http;
class OrderDataProvider{
  final http.Client httpClient;
  final String _baseUrl = "http://192.168.56.1:8080";

  OrderDataProvider({@required this.httpClient}):assert(httpClient != null);


  Future<List<Order>>getOrders()async{

    List<Order>orders = [];

    try{
      final response = await httpClient.get("$_baseUrl/api/order");

      if(response.statusCode == 200){
        final extractedData = json.decode(response.body)as List<dynamic>;

        if(extractedData == null){
          return null;
        }
        else{

          orders = extractedData.map<Order>((order) => Order.fromJson(order)).toList();

          return orders;

        }

      }else{
        throw HttpException("error occurred");
      }

    }catch(e){
      throw e;
    }

  }

  Future<Order>getOrder(String id)async{
    Order order;

    try{
      final response = await httpClient.get("$_baseUrl/api/order/$id");

      if(response.statusCode == 200){
        final extractedData = json.decode(response.body)as Map<String,dynamic>;

        if(extractedData == null){
          return null;
        }
        else{

          order = Order.fromJson(extractedData);
          return order;

        }

      }else{
        throw HttpException("error occurred");
      }

    }catch(e){
      throw e;
    }
  }

  Future<Order> postOrder(Order order) async {
    Order ordr;
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await http.post(
        "$_baseUrl/api/order",
        body: json.encode({
          "id":order.id,
          "user_id":order.userID,
          "item_id":ordr.itemID,
          "quantity":order.quantity,
          "placedAt":order.placedAt
        }),

        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      if (response.statusCode == 201) {
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        ordr = Order.fromJson(extractedData);
        return ordr;
      }
      else {
        throw HttpException("error occurred");
      }
    }
    catch (e) {
      throw e;
    }
  }

  Future<Order> updateOrder(Order order) async {
    Order ordr;
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await http.put(
        "$_baseUrl/api/order/${order.id}",
        body: json.encode({
          "id":order.id,
          "user_id":order.userID,
          "item_id":ordr.itemID,
          "quantity":order.quantity,
          "placedAt":order.placedAt
        }),
        headers: {

          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        ordr = Order.fromJson(extractedData);
        return ordr;
      }
      else {
        throw HttpException("error occurred");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteOrder(String id) async {
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await httpClient.delete(
        "$_baseUrl/api/order/$id",
        headers:{
          HttpHeaders.contentTypeHeader:"application/json",
          HttpHeaders.authorizationHeader:"Bearer $token"
        },
      );

      if (response.statusCode != 200) {
        throw HttpException("error occurred");
      }
    } catch (e) {
      throw e;
    }


  }

}