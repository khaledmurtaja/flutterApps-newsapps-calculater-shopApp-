import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/shared/cubit/states.dart';
import 'package:untitled/shared/network/local/cash_helper.dart';
class myCubit extends Cubit<MenuState> {
  myCubit() : super(firstState());
  bool isDark=false;
  int currentIndex = 0;
  Database? db;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool bottomSheetShown = false;
  IconData fab = Icons.edit;
  List<String> titles = [
    "new tasks",
    "done tasks",
    "archived tasks"
  ];

  static myCubit get(BuildContext context) => BlocProvider.of(context);

  void changeIndex(int value) {
    currentIndex = value;
    emit(changeNavBarState());
  }

  Future<void> createDatebase() async {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          print("database created");
          database.execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)')
              .then((value) {
            print("table created");
          }).catchError((error) {
            print("error creating table ${error.toString()}");
          });
        },
        onOpen: (database) {
           getData(status: 'archived', database: database).then((value) {
             archivedTasks = value;
           });
           getData(status: 'done', database: database).then((value) {
             doneTasks = value;
           });

          getData(database: database, status: 'new')
              .then((value) {
            newTasks = value;
            emit(getDataBase());
          });
        }
    ).then((value) {
      db = value;
      emit(createDataBase());
    });
  }

  Future insertToDatabase(
      {required String title, required String date, required String time}) async
  {
    return await db!.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO Tasks(title, date, time,status) VALUES("$title", "$date","$time","new")')
          .then((value) {
        print("insert successfully");
        getData(database: db!, status: 'new').then((value) {
          newTasks = value;
          emit(insertToDataBase());
        }
        );
      }).catchError((error) {
        print("error in inserting to the table ${error.toString()}");
      });
    });
  }

  Future<List<Map>> getData(
      {required Database database, required String status}) async {
    return await database.rawQuery(
        'select * from Tasks where status=?', [status]);
  }

  void updateDatabase({required String status, required int id}) {
    db!.rawUpdate(
        'UPDATE Tasks SET status = ?  Where id = ?',
        [status, id]).
    then((value) {
      getData(status: 'new', database: db!).then((value) {
        newTasks = value;
      });
        getData(status: 'done', database: db!).then((value) {
          doneTasks = value;
          emit(updateDataBase());
        });
        getData(status: 'archived', database: db!).then((value) {
          archivedTasks = value;
          emit(updateDataBase());
        });

    });
  }
  void deleteRecordFromDatabase(int id,Map rowToDelete){
    String status=rowToDelete['status'];
    db!.rawDelete('DELETE FROM Tasks WHERE id = ?', [id])
        .then((value){
      getData(status: status, database: db!).then((value) {
        if(status=='new'){
          newTasks=value;
        }else if(status=='archived'){
          archivedTasks = value;
        }else{
          doneTasks=value;
        }
        emit(deleteDataBase ());
      });
    });
  }
  void changeBottomSheet(
      {required bool isBottomsheetShown, required IconData iconData}) {
    bottomSheetShown = isBottomsheetShown;
    fab = iconData;
    emit(changeBottomsheet());
  }
  void handleSharedData({ bool? isdark}){
    if(isdark!=null) {
      isDark=isdark;
      print("not null");
    }else{
      print("null");
    }
  }
  void changeTheme(){
      isDark=!isDark;
      CashHelper.PutData(key: 'theme', value: isDark)
          .then((value){
        emit(ChangeTheme());
      });

  }
}
