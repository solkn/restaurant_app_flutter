import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/models/item.dart';

@immutable
class Category extends Equatable{
  final int id;
  final String name;
  final String description;
  final String image;
  final  List<Item> items;

   Category({this.id,
      @required this.name,
      @required this.description,
      @required this.image,
      @required this.items
   });

  @override
  List<Object> get props => [id,name,description,image,items];

  factory Category.fromJson(Map<String,dynamic>json){
     return Category(
        id:json["id"],
        name:json["name"],
        description: json["description"],
        image: json["image"],
        items: (json["items"]as List).map<Item>(
                (json) => Item.fromJson(json)).toList()
     );
  }


  Map toJson(json)=>{
    "id":id,
    "name":name,
    "description":description,
    "image":image,
    (json["items"]as List).map<Item>(
            (json) => Item.fromJson(json)).toList():items
  };

  String toString(){

       return "Category{id:$id,name:$name,description:$description,image:$image,items:$items}";
  }

}