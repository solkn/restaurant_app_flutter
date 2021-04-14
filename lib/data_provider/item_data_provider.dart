import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/models/model.dart';
import 'package:flutter_app_restaurant/util/util.dart';
import 'package:http/http.dart'as http;
class ItemDataProvider{
  final http.Client httpClient;
  final String _baseUrl = "http://192.168.56.1:8080";

  ItemDataProvider({@required this.httpClient}):assert(httpClient != null);

  Future<List<Item>>getItems()async{
    List<Item>items = [];

    try{

      final response = await httpClient.get("$_baseUrl/api/item");
      if(response.statusCode == 200){
        final extractedData = json.decode(response.body)as List<dynamic>;
        if(extractedData == null){
          return null;
        }
        else{
          items = extractedData.map<Item>((json) => Item.fromJson(json)).toList();

          return items;
        }

      }else{
        throw HttpException("error occurred");
      }

    }catch(e){
      throw e;
    }
  }

  Future<Item>getItem(String id)async{

    Item item;


    try{
      final response = await httpClient.get("$_baseUrl/api/category/$id");

      if(response.statusCode == 200){
        final extractedData = json.decode(response.body)as Map<String,dynamic>;

        if(extractedData == null){
          return null;
        }
        else{

          item = Item.fromJson(extractedData);

          return item;

        }

      }else{
        throw HttpException("error occurred");
      }

    }catch(e){
      throw e;
    }

  }

  Future<Item> postItem(Item item) async {
    Item itm;
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      List<Map> categories = item.categories != null
          ? item.categories.map((category) => item.toJson(category)).toList() : null;

      List<Map> ingredients = item.ingredients != null
          ? item.ingredients.map((ingredient) => item.toJson(ingredient)).toList() : null;

      final response = await http.post(
        "$_baseUrl/api/item",
        body: json.encode({

          "id":item.id,
          "name":item.name,
          "price":item.price,
          "description":item.description,
          "categories":categories,
          "image":item.image,
          "ingredient_id":item.ingredientID,
          "ingredients":ingredients


        }),

        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      if (response.statusCode == 201) {
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        itm = Item.fromJson(extractedData);
        return itm;
      }
      else {
        throw HttpException("error occurred");
      }
    }
    catch (e) {
      throw e;
    }
  }

  Future<Item> updateItem(Item item) async {
    Item itm;
    Util util = new Util();
    String token = await util.getUserToken();

    try {

      List<Map> categories = item.categories != null
          ? item.categories.map((category) => item.toJson(category)).toList() : null;

      List<Map> ingredients = item.ingredients != null
          ? item.ingredients.map((ingredient) => item.toJson(ingredient)).toList() : null;

      final response = await http.put(
        "$_baseUrl/api/item/${item.id}",
        body: json.encode({
          "id":item.id,
          "name":item.name,
          "price":item.price,
          "description":item.description,
          "categories":categories,
          "image":item.image,
          "ingredient_id":item.ingredientID,
          "ingredients":ingredients

        }),
        headers: {

          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        itm = Item.fromJson(extractedData);
        return itm;
      }
      else {
        throw HttpException("error occurred");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteItem(String id) async {
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await httpClient.delete(
        "$_baseUrl/api/item/$id",
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