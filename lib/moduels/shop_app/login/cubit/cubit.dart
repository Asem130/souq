import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revation/models/login_model.dart';
import 'package:revation/moduels/shop_app/login/cubit/states.dart';
import 'package:revation/shared/network/remote/DioHelper/dio_Helper.dart';

import '../../../../shared/network/remote/end_points.dart';


class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(InitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);
      late LoginModel  loginModel;
  void userLogin({required String email,required String passward})
  {
    emit(LodingState());
    DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':passward,

    }).then((value) {
      loginModel= LoginModel.fromJson(value.data);
      emit(SuccsessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ErrorState(error));
    });
  }
  bool isPassward = true;
  IconData suffix =Icons.visibility_off_outlined;

  void changeSuffix()
{
isPassward = !isPassward;
suffix= isPassward?Icons.visibility_off_outlined:Icons.visibility;
emit(SuffixChange());
}









}

