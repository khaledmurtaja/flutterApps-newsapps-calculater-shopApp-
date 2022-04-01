
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled/modules/toDo_app/archivedTasksScreen.dart';
import 'package:untitled/modules/toDo_app/doneTasksScreen.dart';
import 'package:untitled/modules/toDo_app/newTasksScreen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  var titleController=TextEditingController();
  var timeController=TextEditingController();
  var dateController=TextEditingController();
  var scaffoledKey=GlobalKey<ScaffoldState>();
  List<Widget> screens=[
    newTasksScreen(),
    doneTasksScreen(),
    archivedTasksScreen()
  ];

  List<Map> data=[];
  var formKey=GlobalKey<FormState>();
  List<BottomNavigationBarItem> items=[
    BottomNavigationBarItem(
      icon: Icon(Icons.view_headline),
      label: 'Tasks'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.arrow_circle_up),
        label: 'done Tasks'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.archive),
        label: 'archived'
    )
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>myCubit()..createDatebase(),
      child: BlocConsumer<myCubit,MenuState>(
        listener:(BuildContext context,MenuState state){
          if(state is insertToDataBase){
            Navigator.pop(context);
          }
        },
        builder:(BuildContext context,MenuState state){
          myCubit cubit=myCubit.get(context);
          return Scaffold(
              key: scaffoledKey,
              appBar: AppBar(
                title: Text(
                    cubit.titles[cubit.currentIndex]
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: items,
                currentIndex:cubit.currentIndex,
                onTap: (index){
                  cubit.changeIndex(index);
                },
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    if(cubit.bottomSheetShown) {
                      if (formKey.currentState!.validate()){
                       // Navigator.pop(context);
                        cubit.insertToDatabase(
                            title: titleController.text,
                            time: timeController.text,
                            date: dateController.text,
                        );
                      }
                    }else{
                      scaffoledKey.currentState!.showBottomSheet((context) =>
                          Form(
                            key: formKey,
                            child: Container(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFormField(
                                        controller: titleController,
                                        inputType: TextInputType.text,
                                        label: 'title',
                                        onchanged: (newTitle){
                                          print(newTitle);
                                        },
                                        onsubmit: (text){
                                          print(text);
                                        },
                                        ontap: (){
                                          print('tapped');
                                        },
                                        prefix: Icon(Icons.title), color: null
                                    ),
                                    SizedBox(height: 15,),
                                    defaultFormField(
                                        controller: timeController,
                                        inputType: TextInputType.datetime,
                                        label: 'time',
                                        readOnly: true,
                                        onchanged: (newTitle){
                                          print(newTitle);
                                        },
                                        onsubmit: (text){
                                          print(text);
                                        },
                                        ontap: (){
                                          showTimePicker(context: context, initialTime:TimeOfDay.now())
                                              .then((value) {
                                            timeController.text=value!.format(context);
                                          });
                                        },
                                        prefix: Icon(Icons.watch_later_outlined), color: null
                                    ),
                                    SizedBox(height: 15,),
                                    defaultFormField(
                                        controller: dateController,
                                        inputType: TextInputType.datetime,
                                        label: 'date',
                                        readOnly: true,
                                        onchanged: (newTitle){
                                          print(newTitle);
                                        },
                                        onsubmit: (text){
                                          print(text);
                                        },
                                        ontap: (){
                                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate:DateTime.now(), lastDate: DateTime.parse("2021-11-03"))
                                              .then((value) {
                                            dateController.text=DateFormat.yMMMd().format(value!);
                                          });
                                        },
                                        prefix: Icon(Icons.calendar_today_outlined), color: null
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                      ).closed.then((value) {
                        cubit.changeBottomSheet(isBottomsheetShown: false, iconData: Icons.edit);
                      });
                      cubit.changeBottomSheet(isBottomsheetShown: true, iconData: Icons.add);

                    }
                  },
                  child: Icon(cubit.fab)
              ),
              body:
              screens[myCubit.get(context).currentIndex]
          );
        },
      ),
    );
  }


}
