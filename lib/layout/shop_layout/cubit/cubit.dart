import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revation/layout/shop_layout/cubit/states.dart';
import 'package:revation/models/catedories_model.dart';
import 'package:revation/models/favorites_model.dart';
import 'package:revation/models/login_model.dart';
import 'package:revation/moduels/shop_app/categories/categories_screen.dart';
import 'package:revation/moduels/shop_app/favorite/favorite_screen.dart';
import 'package:revation/moduels/shop_app/products/products_screen.dart';
import 'package:revation/moduels/shop_app/settings/settings_screen.dart';
import 'package:revation/shared/constants/constants.dart';
import 'package:revation/shared/network/remote/DioHelper/dio_Helper.dart';

import '../../../models/home_model.dart';
import '../../../shared/network/remote/end_points.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  int cuurentIndex = 0;
  HomeModel? homeModel;
  CategoriesModel? categoryModel;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.app_registration),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  List<Widget> screens = [
    ProductsScreen(),
    FavoriteScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    cuurentIndex = index;
    emit(ChangeBottomNavBar());
  }

  Map<int?, bool?> favorites = {};
  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.toString());
      print(homeModel?.status);
      homeModel?.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorite,
        });
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState());
    });
  }

  void getCategoryData() {
    DioHelper.getData(url: Categories, token: token).then((value) {
      categoryModel = CategoriesModel.fromJson(value.data);
      print(categoryModel.toString());
      print(categoryModel?.status);
      emit(CategorySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoryErrorState());
    });
  }
   late FavoritesModel favoritesModel;
  void getFavotites(int productId) {
    DioHelper.postData(
      url: Favorite,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(FavoritesSuccessState());
    }).catchError((error) {
      emit(FavoritesErrorState());
    });
  }

  late  LoginModel userModel;
  void getUserModel() {
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel=LoginModel.fromJson(value.data);
      emit(FavoritesSuccessState());
    }).catchError((error) {
      emit(FavoritesErrorState());
    });
  }
}
