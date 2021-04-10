import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Comment extends Equatable{

  final int id;
  final String fullName;
  final String message;
  final String phone;
  final String email;
  final DateTime placedAt;

  Comment({this.id,
          @required this.fullName,
          @required this.message,
          @required this.phone,
          @required this.email,
          @required this.placedAt
  });
    factory Comment.fromJson(Map<String,dynamic>json){
         return Comment(
              id: json["id"],
              fullName: json["fullName"],
              message: json["message"],
              phone: json["phone"],
              email: json["email"],
              placedAt: json["placedAt"]
         );
    }
  @override
  List<Object> get props => [id,fullName,message,phone,email,placedAt];


    String toString(){
        return "Comment{id:$id,fullName:$fullName,message:$message,phone:$phone,email:$email,placedAt:$placedAt}";
    }

}