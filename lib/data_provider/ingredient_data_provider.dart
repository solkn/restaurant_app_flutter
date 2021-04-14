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


  Future<List<Ingredient>>getIngredients()async{

    List<Ingredient>ingredients = [];

    try{
      final response = await httpClient.get("$_baseUrl/api/ingredient");

      if(response.statusCode == 200){
        final extractedData = json.decode(response.body)as List<dynamic>;

        if(extractedData == null){
          return null;
        }
        else{

          ingredients = extractedData.map<Ingredient>((order) => Ingredient.fromJson(order)).toList();

          return ingredients;

        }

      }else{
        throw HttpException("error occurred");
      }

    }catch(e){
      throw e;
    }

  }

  Future<Ingredient>getIngredient(String id)async{
    Ingredient ingredient;

    try{
      final response = await httpClient.get("$_baseUrl/api/ingredient/$id");

      if(response.statusCode == 200){
        final extractedData = json.decode(response.body)as Map<String,dynamic>;

        if(extractedData == null){
          return null;
        }
        else{

          ingredient = Ingredient.fromJson(extractedData);
           return ingredient;

        }

      }else{
        throw HttpException("error occurred");
      }

    }catch(e){
      throw e;
    }
  }

  Future<Ingredient> postIngredient(Ingredient ingredient) async {
    Ingredient ingrdt;
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await http.post(
        "$_baseUrl/api/ingredient",
        body: json.encode({
          "id":ingredient.id,
          "name":ingredient.name,
          "ingredient":ingredient.description
        }),

        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      if (response.statusCode == 201) {
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        ingrdt = Ingredient.fromJson(extractedData);
        return ingrdt;
      }
      else {
        throw HttpException("error occurred");
      }
    }
    catch (e) {
      throw e;
    }
  }

  Future<Ingredient> updateIngredient(Ingredient ingredient) async {
    Ingredient ingrdt;
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await http.put(
        "$_baseUrl/api/ingredient/${ingredient.id}",
        body: json.encode({
          "id":ingredient.id,
          "name":ingredient.name,
          "ingredient":ingredient.description
        }),
        headers: {

          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        ingrdt = Ingredient.fromJson(extractedData);
        return ingrdt;
      }
      else {
        throw HttpException("error occurred");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteIngredient(String id) async {
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await httpClient.delete(
        "$_baseUrl/api/ingredient/$id",
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