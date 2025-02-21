import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String CategoryID);
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();

  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await CategoryDB.put(value.id,value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final CategoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return CategoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    await Future.forEach(
      allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryList.value.add(category);
        } else {
          expenseCategoryList.value.add(category);
        }
      },
    );

    incomeCategoryList.value = List.from(incomeCategoryList.value);
    expenseCategoryList.value = List.from(expenseCategoryList.value);
  }

  @override
  Future<void> deleteCategory(String CategoryID) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDB.delete(CategoryID);
    refreshUI();
  }
}
