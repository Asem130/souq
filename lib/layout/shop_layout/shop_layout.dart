import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revation/layout/shop_layout/cubit/cubit.dart';
import 'package:revation/layout/shop_layout/cubit/states.dart';
import 'package:revation/moduels/shop_app/login/login_screen.dart';
import 'package:revation/moduels/shop_app/search/search_screen.dart';
import 'package:revation/shared/componantes/componantes.dart';
import 'package:revation/shared/network/remote/shared_preference/cache_helper.dart';


class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(

            title: Center(
              child: Text(
                'I\'m Shooping',
                style: TextStyle(
                ),

              ),
            ),
            leading: IconButton(onPressed: (){

            },icon: Icon(Icons.menu),),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search),style:ButtonStyle(),),
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.notifications)),


            ],
          ),
          bottomNavigationBar: BottomNavigationBar(items:
            cubit.bottomItems,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.deepOrange,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.deepOrange[200],
          currentIndex: cubit.cuurentIndex,
            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
          ),
          body: cubit.screens[cubit.cuurentIndex],
        );
      },
    );
  }
}
