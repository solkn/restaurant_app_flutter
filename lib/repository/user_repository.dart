import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/data_provider/data.dart';
import 'package:flutter_app_restaurant/models/model.dart';
import 'package:flutter_app_restaurant/repository/repository.dart';

class UserRepository{

    UserDataProvider userDataProvider;

    UserRepository({@required this.userDataProvider}):assert(userDataProvider != null);


    Future<List<User>>getUser()async{

       return await userDataProvider.getUsers();
    }

    Future<User>updateUser(User user)async{

       return await userDataProvider.updateUser(user);
    }

    Future<User>updateUserPassword(User user,String oldPassword)async{

        return await userDataProvider.updateUserPassword(user, oldPassword);
    }

    Future<User>login(User user)async{

        return await userDataProvider.login(user);
    }

    Future<User>signUp(User user)async{

        return userDataProvider.signUp(user);
    }
}