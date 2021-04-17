import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/data_provider/data.dart';
import 'package:flutter_app_restaurant/models/model.dart';

class CommentRepository{

    CommentDataProvider commentDataProvider;

    CommentRepository({@required this.commentDataProvider});


    Future<List<Comment>>getComments()async{

       return await commentDataProvider.getComments();
    }

    Future<Comment>getComment(String id)async{

       return await commentDataProvider.getComment(id);
    }

    Future<Comment>postComment(Comment comment)async{

      return await commentDataProvider.postComment(comment);
    }

    Future<Comment>updateComment(Comment comment)async{

      return await commentDataProvider.updateComment(comment);
    }

    Future<void>deleteComment(String id)async{

      return await commentDataProvider.deleteComment(id);
    }


}