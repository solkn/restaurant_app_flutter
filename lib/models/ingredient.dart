import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Ingredient extends Equatable{

  final int id;
  final String name;
  final String description;
  Ingredient({this.id,
       @required this.name,
       @required this.description

  });
  @override
  List<Object> get props =>[id,name,description];

  factory Ingredient.fromJson(Map<String,dynamic>json){
       return Ingredient(

                id: json["id"],
                name: json["name"],
                description: json["description"]

      );
  }

  Map toJson(json)=>{
    "id":id,
    "name":name,
    "description":description,

  };

  String toString(){
    return "Ingredient{id:$id,name:$name,description:$description}";
  }

}