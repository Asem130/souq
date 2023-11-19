import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revation/layout/shop_layout/cubit/cubit.dart';
import 'package:revation/layout/shop_layout/cubit/states.dart';
import 'package:revation/layout/shop_layout/shop_layout.dart';
import 'package:revation/models/home_model.dart';
import 'package:revation/moduels/shop_app/login/login_screen.dart';
import 'package:revation/shared/constants/constants.dart';
import 'package:revation/shared/network/remote/DioHelper/dio_Helper.dart';
import 'package:revation/shared/network/remote/shared_preference/cache_helper.dart';

import 'layout/todo_layout/todo_layout_screen.dart';
import 'models/home_model.dart';
import 'models/home_model.dart';
import 'models/home_model.dart';
import 'models/home_model.dart';
import 'moduels/shop_app/onBoarding/onboardin_screnn.dart';
import 'shared/network/remote/bloc observe/bloc_observe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLogin();
  } else {
    widget = OnBoarding();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeCubit()..getHomeData()..getCategoryData()..getUserModel()
        )
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home:startWidget ,
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                iconTheme: IconThemeData(color: Colors.deepOrange),
                scaffoldBackgroundColor: Colors.white,

              ),
            );
          }),
    );
  }
}
