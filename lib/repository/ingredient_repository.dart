import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/data_provider/data.dart';
import 'package:flutter_app_restaurant/models/model.dart';

class IngredientRepository{

   IngredientDataProvider ingredientDataProvider;

   IngredientRepository({@required this.ingredientDataProvider});


   Future<List<Ingredient>>getIngredients()async{

      return await ingredientDataProvider.getIngredients();
   }

   Future<Ingredient>getIngredient(String id)async{

       return await ingredientDataProvider.getIngredient(id);
   }

   Future<Ingredient>postIngredient(Ingredient ingredient)async{

     return await ingredientDataProvider.postIngredient(ingredient);
   }

   Future<void>deleteIngredient(String id)async{

      return await ingredientDataProvider.deleteIngredient(id);
   }

}