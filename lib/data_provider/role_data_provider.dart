import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/models/model.dart';
import 'package:flutter_app_restaurant/util/util.dart';
import 'package:http/http.dart'as http;
class RoleDataProvider{
  final http.Client httpClient;
  final String _baseUrl = "http://192.168.56.1:8080";

  RoleDataProvider({@required this.httpClient}):assert(httpClient != null);


  Future<List<Role>>getRoles()async{

    List<Role>roles = [];

    try{
      final response = await httpClient.get("$_baseUrl/api/role");

      if(response.statusCode == 200){
        final extractedData = json.decode(response.body)as List<dynamic>;

        if(extractedData == null){
          return null;
        }
        else{

          roles = extractedData.map<Role>((role) => Role.fromJson(role)).toList();

          return roles;

        }

      }else{
        throw HttpException("error occurred");
      }

    }catch(e){
      throw e;
    }

  }

  Future<Role>getRole(String id)async{
    Role role;

    try{
      final response = await httpClient.get("$_baseUrl/api/role/$id");

      if(response.statusCode == 200){
        final extractedData = json.decode(response.body)as Map<String,dynamic>;

        if(extractedData == null){
          return null;
        }
        else{

          role = Role.fromJson(extractedData);
          return role;

        }

      }else{
        throw HttpException("error occurred");
      }

    }catch(e){
      throw e;
    }
  }

  Future<Role> postRole(Role role) async {
    Role rol;
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await http.post(
        "$_baseUrl/api/role",
        body: json.encode({
          "id":role.id,
          "name":role.name
        }),

        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      if (response.statusCode == 201) {
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        rol = Role.fromJson(extractedData);
        return rol;
      }
      else {
        throw HttpException("error occurred");
      }
    }
    catch (e) {
      throw e;
    }
  }

  Future<Role> updateRole(Role role) async {
    Role rol;
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await http.put(
        "$_baseUrl/api/order/${role.id}",
        body: json.encode({
          "id":role.id,
          "name":role.name
        }),
        headers: {

          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        rol = Role.fromJson(extractedData);
        return rol;
      }
      else {
        throw HttpException("error occurred");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteRole(String id) async {
    Util util = new Util();
    String token = await util.getUserToken();

    try {
      final response = await httpClient.delete(
        "$_baseUrl/api/role/$id",
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