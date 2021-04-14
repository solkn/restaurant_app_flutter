import 'dart:convert';
import 'dart:io';

import 'package:flutter_app_restaurant/models/model.dart';
import 'package:flutter_app_restaurant/util/util.dart';
import 'package:http/http.dart'as http;

class CategoryDataProvider{
  final http.Client httpClient;
  final String _baseUrl = "http://192.168.56.1:8080";

  CategoryDataProvider(this.httpClient):assert(httpClient != null);

  Future<List<Category>>getCategories()async{
    List<Category>categories = [];

    try{

      final response = await httpClient.get("$_baseUrl/api/category");
      if(response.statusCode == 200){
        final extractedData = json.decode(response.body)as List<dynamic>;
        if(extractedData == null){
            return null;
        }
        else{
            categories = extractedData.map<Category>((json) => Category.fromJson(json)).toList();

            return categories;
        }

      }else{
        throw HttpException("error occurred");
      }

    }catch(e){
      throw e;
    }
  }

  Future<Category>getCategory(String id)async{

    Category category;


    try{
      final response = await httpClient.get("$_baseUrl/api/category/$id");

      if(response.statusCode == 200){
        final extractedData = json.decode(response.body)as Map<String,dynamic>;

        if(extractedData == null){
          return null;
        }
        else{

          category = Category.fromJson(extractedData);

          return category;

        }

      }else{
        throw HttpException("error occurred");
      }

    }catch(e){
      throw e;
    }

  }

  Future<Category> postCategory(Category category) async {
    Category ctg;
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      List<Map> items = category.items != null
          ? category.items.map((item) => item.toJson(json)).toList() : null;

      final response = await http.post(
        "$_baseUrl/api/category",
        body: json.encode({

          "id":category.id,
          "name":category.name,
          "description":category.description,
          "items":items,
          "image":category.image


        }),

        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      if (response.statusCode == 201) {
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        ctg = Category.fromJson(extractedData);
        return ctg;
      }
      else {
        throw HttpException("error occurred");
      }
    }
    catch (e) {
      throw e;
    }
  }

  Future<Category> updateCategory(Category category) async {
    Category ctg;
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      List<Map> items = category.items != null
          ? category.items.map((item) => item.toJson(json)).toList() : null;
      final response = await http.put(
        "$_baseUrl/api/category/${category.id}",
        body: json.encode({
          "id":category.id,
          "name":category.name,
          "description":category.description,
          "items":items,
          "image":category.image

        }),
        headers: {

          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        ctg = Category.fromJson(extractedData);
        return ctg;
      }
      else {
        throw HttpException("error occurred");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteCategory(String id) async {
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await httpClient.delete(
        "$_baseUrl/api/category/$id",
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