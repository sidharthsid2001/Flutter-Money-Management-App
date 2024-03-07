import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier =
    ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Add category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: InputDecoration(
                    hintText: 'Category name', border: OutlineInputBorder()),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    RadioButton(title: 'Income', type: CategoryType.income),
                    RadioButton(title: 'Expense', type: CategoryType.expense)
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameEditingController.text;
                    if (_name.isEmpty) {
                      return;
                    }
                    final _type = selectedCategoryNotifier.value;
                    final _category = CategoryModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);
                    CategoryDB().insertCategory(_category);
                    Navigator.pop(ctx);
                  },
                  child: Text('Add')),
            ),
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategoryNotifier.value = value;
                  selectedCategoryNotifier.notifyListeners();
                  // print(value);
                  // setState(() {
                  //   _type = value;
                  // });
                });
          },
        ),
        Text(title),
      ],
    );
  }
}
