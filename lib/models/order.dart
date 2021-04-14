import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Order extends Equatable{
  final int id;
  final  int  userID;
  final int itemID;
  final int quantity;
  final DateTime placedAt;


  Order({this.id,
          @required this.userID,
          @required this.itemID,
          @required this.quantity,
          @required this.placedAt


  });
  @override
  List<Object> get props => [id,userID,itemID,quantity,placedAt];

      factory Order.fromJson(Map<String,dynamic>json){
          return Order(
              id: json["id"],
              userID: json["userID"],
              itemID: json["itemID"],
              quantity: json["quantity"],
              placedAt: json["placedAt"]

          );
      }

  Map toJson()=>{
    "id":id,
    "user_id":userID,
    "item_id":itemID,
    "quantity":quantity,
    "placedAt":placedAt
  };

  String toString(){
      return "Order{id:$id,userID:$userID,itemID:$itemID,quantity:$quantity,placedAt:$placedAt}";
  }

}