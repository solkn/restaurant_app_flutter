
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_restaurant/data_provider/data.dart';
import 'package:flutter_app_restaurant/models/model.dart';

class ItemRepository{

    ItemDataProvider itemDataProvider;

    ItemRepository({@required this.itemDataProvider});


    Future<List<Item>>getItems()async{

        return await itemDataProvider.getItems();
    }

    Future<Item>getItem(String id)async{

         return await itemDataProvider.getItem(id);
    }

    Future<Item>postItem(Item item)async{

        return await itemDataProvider.postItem(item);
    }

    Future<Item>updateItem(Item item)async{

        return await itemDataProvider.updateItem(item);
    }

    Future<void>deleteItem(String id)async{

        return await itemDataProvider.deleteItem(id);
    }
}