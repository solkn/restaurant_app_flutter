import 'dart:convert';
import 'dart:async';
import 'dart:io';
import '../models/http_exception.dart';
import '../models/user.dart';
import '../util/util.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class UserDataProvider {
  final http.Client httpClient;
  final String _baseUrl = "http://192.168.56.1:8080";

  UserDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Util util = new Util();
  Future<List<User>> getUsers() async {
    List<User> users;
    try {
      String token = await util.getUserToken();
      String expiry = await util.getExpiryTime();
      final response = await httpClient.get(
        "$_baseUrl/api/user",
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
          'expiry': expiry,
        },
      );

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        if (extractedData == null) {
          return null;
        }
        users = extractedData.map<User>((json) => User.fromJson(json)).toList();


      } else {
        throw Exception("Error has occurred");
      }
    } catch (e) {
      throw e;
    }
    return users;
  }

  Future<User> login(User user) async {
    User usr;
    try {

      List<Map> orders = user.orders != null
          ? user.orders.map((order) => order.toJson()).toList() : null;

      List<Map> roles = user.roles!= null
          ? user.roles.map((role) => role.toJson()).toList() : null;

      final response = await http.post(
        "$_baseUrl/api/user/login",
        body: jsonEncode(<String,dynamic>{
          'id': user.id,
          "username":user.username,
          'full_name': user.fullName,
          'email': user.email,
          'phone': user.phone,
          'password': user.password,
          'role_id': user.roleID,
          'roles':roles,
          'order_id':user.orderID,
          'orders':orders
        }),
      );
      print("the status code of logging state is:");
      print(response.statusCode);
      if (response.statusCode == 422) {
        throw HttpException('Invalid Input');
      } else if (response.statusCode == 404) {
        throw HttpException('Incorrect username or password');
      } else {
        usr = User.fromJson(jsonDecode(response.body));
        //print('$user1.fullName');
        String token = response.headers['token'].toString();
        String expiry = response.headers['expiry_date'].toString();

        await util.storeUserInformation(usr);
        await util.storeTokenAndExpiration(expiry, token);
      }
    } catch (e) {
      throw e;
    }
    return usr;
  }

  Future<User> signUp(User user) async {
    final urlEmailCheck = "$_baseUrl/api/user/email/${user.email}";
    final urlPhoneCheck = "$_baseUrl/api/user/phone/${user.phone}";
    final urlPostUser = "$_baseUrl/api/user/signup";
    User usr;
    try {

      List<Map> orders = user.orders != null
          ? user.orders.map((order) => order.toJson()).toList() : null;

      List<Map> roles = user.roles!= null
          ? user.roles.map((role) => role.toJson()).toList() : null;

      var response = await httpClient.get(
        urlEmailCheck,
      );
      if (response.statusCode == 200) {
        final isEmailExist = json.decode(response.body) as bool;
        if (isEmailExist) {
          throw HttpException('Email already exists!');
        } else {
          response = await httpClient.get(urlPhoneCheck);

          if (response.statusCode == 500) {
            throw HttpException('Error occurred !');
          } else {
            final isPhoneExist = json.decode(response.body) as bool;
            if (isPhoneExist) {
              throw HttpException('Phone No already exists!');
            } else {
              response = await httpClient.post(
                urlPostUser,
                body: json.encode({
                  'id': user.id,
                  "username":user.username,
                  'full_name': user.fullName,
                  'email': user.email,
                  'phone': user.phone,
                  'password': user.password,
                  'role_id': user.roleID,
                  'roles':roles,
                  'order_id':user.orderID,
                  'orders':orders
                }),
                headers: {
                  HttpHeaders.contentTypeHeader: "application/json",
                },
              );
              print("status code is:");
              print(response.statusCode);
              if (response.statusCode == 200) {
                final extractedData =
                json.decode(response.body) as Map<String, dynamic>;
                usr = User.fromJson(extractedData);
                print(usr.fullName);
                String token = response.headers['Token'].toString();
                String expiry = response.headers['Expiry_date'].toString();
                await util.storeUserInformation(usr);
                await util.storeTokenAndExpiration(expiry, token);
              } else {
                throw HttpException('Error occurred');
              }
            }
          }
        }
      } else {
        throw HttpException('Error occurred !');
      }
    } catch (e) {
      throw e;
    }
    return usr;
  }

  Future<User> updateUser(User user) async {
    User updated;
    final url = '$_baseUrl/api/user/${user.id}';
    try {


      List<Map> orders = user.orders != null
          ? user.orders.map((order) => order.toJson()).toList() : null;

      List<Map> roles = user.roles!= null
          ? user.roles.map((role) => role.toJson()).toList() : null;

      String token = await util.getUserToken();
      String expiry = await util.getExpiryTime();
      final response = await httpClient.put(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
          'expiry': expiry
        },
        body: json.encode({
          'id': user.id,
          "username":user.username,
          'full_name': user.fullName,
          'email': user.email,
          'phone': user.phone,
          'password': user.password,
          'role_id': user.roleID,
          'roles':roles,
          'order_id':user.orderID,
          'orders':orders
        }),
      );
      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        updated = User.fromJson(extractedData);
      } else {
        throw HttpException('Error Occurred');
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
    return updated;
  }

  Future<User> updateUserPassword(User user, String oldPassword) async {
    User updated;
    final url = '$_baseUrl/api/user/${user.id}';
    final urlCheckPassword = '$_baseUrl/api/user//user/password/${user.id}';
    try {

      List<Map> orders = user.orders != null
          ? user.orders.map((order) => order.toJson()).toList() : null;

      List<Map> roles = user.roles!= null
          ? user.roles.map((role) => role.toJson()).toList() : null;

      String token = await util.getUserToken();
      String expiry = await util.getExpiryTime();
      final response = await httpClient.post(
        urlCheckPassword,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
          'expiry': expiry
        },
        body: json.encode({
          'id': user.id,
          "username":user.username,
          'full_name': user.fullName,
          'email': user.email,
          'phone': user.phone,
          'password': user.password,
          'role_id': user.roleID,
          'roles':roles,
          'order_id':user.orderID,
          'orders':orders
        }),
      );
      if (response.statusCode == 200) {
        final response2 = await httpClient.put(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token",
            'expiry': expiry
          },
          body: json.encode({
            'id': user.id,
            "username":user.username,
            'full_name': user.fullName,
            'email': user.email,
            'phone': user.phone,
            'password': user.password,
            'role_id': user.roleID,
            'roles':roles,
            'order_id':user.orderID,
            'orders':orders
          }),
        );
        if (response2.statusCode == 200) {
          final extractedData =
          json.decode(response2.body) as Map<String, dynamic>;
          updated = User.fromJson(extractedData);
        } else {
          throw HttpException('Error Occurred');
        }
      } else if (response.statusCode == 404) {
        throw HttpException('Incorrect Old Password');
      } else {
        throw HttpException('Error Occurred');
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
    return updated;
  }
}
