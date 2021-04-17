import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/data_provider/category_data_provider.dart';
import 'package:flutter_app_restaurant/models/model.dart';

class CategoryRepository{
     CategoryDataProvider categoryDataProvider;

     CategoryRepository({@required this.categoryDataProvider});


  Future<List<Category>>getCategories()async{
       return await categoryDataProvider.getCategories();
  }

  Future<Category>getCategory(String id)async{
       return await categoryDataProvider.getCategory(id);
  }

  Future<Category>postCategory(Category category)async{
      return await categoryDataProvider.postCategory(category);
  }
  Future<Category>updateCategory(Category category)async{
    return await categoryDataProvider.updateCategory(category);
  }
  Future<void>deleteCategory(String id)async{

     await categoryDataProvider.deleteCategory(id);
  }


}