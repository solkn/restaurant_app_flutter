import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/models/model.dart';
import 'package:flutter_app_restaurant/util/util.dart';
import 'package:http/http.dart'as http;

class CommentDataProvider{
    final http.Client httpClient;
    final String _baseUrl = "http://192.168.56.1:8080";

    CommentDataProvider({@required this.httpClient}):assert(httpClient != null);


    Future<List<Comment>>getComments()async{

        List<Comment>comments = [];

        try{
            final response = await httpClient.get("$_baseUrl/api/comment");

            if(response.statusCode == 200){
                final extractedData = json.decode(response.body)as List<dynamic>;

                if(extractedData == null){
                    return null;
                }
                else{

                    comments = extractedData.map<Comment>((json) => Comment.fromJson(json)).toList();

                    return comments;

                }

            }else{
                throw HttpException("error occurred");
            }

        }catch(e){
            throw e;
        }

    }

     Future<Comment>getComment(String id)async{
        Comment comment;

        try{
            final response = await httpClient.get("$_baseUrl/api/comment/$id");

            if(response.statusCode == 200){
                final extractedData = json.decode(response.body)as Map<String,dynamic>;

                if(extractedData == null){
                    return null;
                }
                else{

                    comment = Comment.fromJson(extractedData);
                    return comment;

                }

            }else{
                throw HttpException("error occurred");
            }

        }catch(e){
            throw e;
        }
     }

    Future<Comment> postComment(Comment comment) async {
        Comment cmt;
        Util util = new Util();
        String token = await util.getUserToken();

        try {
            final response = await http.post(
                "$_baseUrl/api/comment",
                body: json.encode({
                    "id":comment.id,
                    "fullName":comment.fullName,
                    "email":comment.email,
                    "phone":comment.phone,
                    "placedAt":comment.placedAt,
                    "message":comment.message

                }),

                headers: {
                    HttpHeaders.contentTypeHeader: "application/json",
                    HttpHeaders.authorizationHeader: "Bearer $token",
                },
            );

            if (response.statusCode == 201) {
                final extractedData = json.decode(response.body) as Map<String,dynamic>;
                cmt = Comment.fromJson(extractedData);
                return cmt;
            }
            else {
                throw HttpException("error occurred");
            }
        }
        catch (e) {
            throw e;
        }
    }

    Future<Comment> updateComment(Comment comment) async {
        Comment cmt;
        Util util = new Util();
        String token = await util.getUserToken();

        try {
            final response = await http.put(
                "$_baseUrl/api/comment/${comment.id}",
                body: json.encode({
                    "id":comment.id,
                    "fullName":comment.fullName,
                    "email":comment.email,
                    "phone":comment.phone,
                    "placedAt":comment.placedAt,
                    "message":comment.message
                }),
                headers: {

                    HttpHeaders.contentTypeHeader: "application/json",
                    HttpHeaders.authorizationHeader: "Bearer $token"
                },
            );
            String status = response.statusCode.toString();
            print("status code for updating comment is: $status");
            if (response.statusCode == 200) {
                final extractedData = json.decode(response.body) as Map<String,dynamic>;
                cmt = Comment.fromJson(extractedData);
                return cmt;
            }
            else {
                throw HttpException("error occurred");
            }
        } catch (e) {
            throw e;
        }
    }

    Future<void> deleteComment(String id) async {
        Util util = new Util();
        String token = await util.getUserToken();

        try {
            final response = await httpClient.delete(
                "$_baseUrl/api/comment/$id",
                headers:{
                    HttpHeaders.contentTypeHeader:"application/json",
                    HttpHeaders.authorizationHeader:"Bearer $token"
                },
            );
            String status = response.statusCode.toString();
            print("comment deleting status code: $status");
            if (response.statusCode != 200) {
                throw HttpException("error occurred");
            }
        } catch (e) {
            throw e;
        }


    }

}