import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Order extends Equatable{
  final int id;
  final DateTime placedAt;
  final  int  userID;
  final int itemID;
  final int quantity;

  Order({this.id,
          @required this.placedAt,
          @required this.userID,
          @required this.itemID,
          @required this.quantity

});
  @override
  List<Object> get props => [id,placedAt,userID,itemID,quantity];

      factory Order.fromJson(Map<String,dynamic>json){
          return Order(
              id: json["id"],
              placedAt: json["placedAt"],
              userID: json["userID"],
              itemID: json["itemID"],
              quantity: json["quantity"],
          );
      }
  String toString(){
      return "Order{id:$id,placedAt:$placedAt,userID:$userID,itemID:$itemID,quantity:$quantity}";
  }

}