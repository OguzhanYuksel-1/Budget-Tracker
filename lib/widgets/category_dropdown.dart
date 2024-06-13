
import 'package:budget_tracker/utils/icons_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryDropDown extends StatelessWidget {
  CategoryDropDown({super.key, this.cattype, required this.onChanged});

  final String? cattype;
  final ValueChanged<String?> onChanged;
  var appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    const defaultCategory = 'Diğerleri';
    
    
    final selectedCategory = cattype ?? defaultCategory;

    return DropdownButton<String>(
      value: selectedCategory,
      isExpanded: true,
      hint: const Text("Kategori Seçimi Yapın"),
      items: [
        ...appIcons.homeExpensesCategories.map((e) => e['name'] as String),
        defaultCategory
      ].map((category) => DropdownMenuItem<String>(
        value: category,
        child: Row(
          children: [
            Icon(
              appIcons.getExpenseCategoryIcons(category),
              color: Colors.black54,
            ),
            const SizedBox(width: 10),
            Text(
              category,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      )).toList(),
      onChanged: onChanged,
    );
  }
}





