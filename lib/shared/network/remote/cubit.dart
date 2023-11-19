import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revation/shared/network/remote/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../../moduels/todo_app/archieved_task/archieved_tasks_screen.dart';
import '../../../moduels/todo_app/done_task/done_tasks_screen.dart';
import '../../../moduels/todo_app/new_task/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitioalState());

  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archieved Tasks',
  ];
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchievedTasks(),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(BottomNavBarState());
  }

  void CreatDataBase() {
    openDatabase('db.0', version: 1, onCreate: (database, version) {
      database
          .execute(
          'CREATE TABLE tasks("id INTEGER PRIMARY KEY","title TEXT","date TEXT,"time TEXT","status TEXT")')
          .then((value) {
        emit(CreateDatabaseState());
        print('Table Created Successfully');
      }).catchError((error) {
        print(error.toString());
      });
    },
        onOpen: (database) {
          print('The Database has been opened');
        }

    );
  }

  InsertIntoDatabase(String title, String time, String date) async
  {
    await database.transaction((txn) {
      return txn.rawInsert("INSERT INTO tasks('title','date','time',status)VALUES ('$title',$date,$time,'new'))").then((value){

        print(' Inserting Into Database ..............');
        emit(InserteIntoDatabaseState());
      }).catchError((error){
        print(error.toString());
      });

    });
  }
}