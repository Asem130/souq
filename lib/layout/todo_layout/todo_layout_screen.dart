import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revation/shared/network/remote/cubit.dart';

import '../../shared/network/remote/states.dart';

class ToDoLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return Scaffold(
                            appBar: AppBar(
                title: Text('${cubit.titles[cubit.currentIndex]}'),
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex:cubit.currentIndex,
                selectedIconTheme: IconThemeData(size: 30),
                type:BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_outlined), label: 'New Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check), label: 'New Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: 'New Tasks'),
                ],
                onTap: (index)
                {
                   cubit.changeBottomNavBar(index);
                },
              ),
            );
          }),
    );
  }
}
