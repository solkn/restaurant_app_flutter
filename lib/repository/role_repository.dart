import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/data_provider/data.dart';
import 'package:flutter_app_restaurant/models/model.dart';

class RoleRepository{
  RoleDataProvider roleDataProvider;

  RoleRepository({@required this.roleDataProvider});


  Future<List<Role>>getRoles()async{

    return await roleDataProvider.getRoles();
  }

  Future<Role>getRole(String id)async{

    return await roleDataProvider.getRole(id);
  }

  Future<Role>postRole(Role role)async{

    return await roleDataProvider.postRole(role);
  }

  Future<Role>updateOrder(Role role)async{

    return await roleDataProvider.updateRole(role);
  }

  Future<void>deleteOrder(String id)async{

    return await roleDataProvider.deleteRole(id);
  }



}