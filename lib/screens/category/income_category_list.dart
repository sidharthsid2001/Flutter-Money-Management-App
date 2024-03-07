import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: ((context, index) {
                final category = newList[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                        onPressed: () {
                          print(category.id);
                          CategoryDB.instance.deleteCategory(category.id);
                        },
                        icon: Icon(Icons.delete)),
                  ),
                );
              }),
              separatorBuilder: ((context, index) {
                return const SizedBox(
                  height: 10,
                );
              }),
              itemCount: newList.length);
        });
  }
}
