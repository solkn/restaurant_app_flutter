import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/models/category.dart';
import 'package:flutter_app_restaurant/models/ingredient.dart';

class Item extends Equatable{
  final int id;
  final String name;
  final double price;
  final String description;
  final List<Category> categories;
  final String image;
  final int ingredientID;
  final List<Ingredient> ingredients;

  Item({this.id,
       @required this.name,
       @required this.price,
       @required this.description,
       @required this.categories,
       @required this.image,
       @required this.ingredientID,
       @required this.ingredients
  });

  factory Item.fromJson(Map<String,dynamic>json){
           return Item(
               id: json["id"],
               name: json["name"],
               price: json["price"],
               description: json["description"],
               categories: (json["categories"]as List).map<Category>(
                           (json) => Category.fromJson(json)).toList(),
               image: json["image"],
               ingredientID: json["ingredient_id"],
               ingredients: (json["ingredients"]as List).map<Ingredient>(
                            (json) => Ingredient.fromJson(json)).toList()
           );
  }
  @override
  List<Object> get props => [id,name,price,description,categories,image,ingredientID,ingredients];

}