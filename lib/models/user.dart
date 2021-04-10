import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/models/order.dart';
import 'package:flutter_app_restaurant/models/role.dart';

class User extends Equatable{
  final int id;
  final String username;
  final  String fullName;
  final String  email;
  final String phone;
  final String password;
  final int roleID;
  final List<Role> roles;
  final int orderID;
  final List<Order> orders;

  User({this.id,
       @required this.username,
       @required this.fullName,
       @required this.email,
       @required this.phone,
       @required this.password,
       @required this.roleID,
       @required this.roles,
       @required this.orderID,
       @required this.orders

});
  @override
  List<Object> get props => [id,username,fullName,email,phone,password,roleID,roles,orderID,orderID];

  factory User.fromJson(Map<String,dynamic>json){
         return User(
             id: json["id"],
             username: json["userName"],
             fullName: json["fullName"],
             email: json["email"],
             phone: json["phone"],
             password: json["password"],
             roleID: json["roleID"],
             roles: (json["roles"]as List).map<Role>(
                     (json) => Role.fromJson(json)).toList(),
             orderID: json["orderID"],
             orders: (json["orders"]as List).map<Order>(
                     (json) => Order.fromJson(json)).toList()
         );
  }

}