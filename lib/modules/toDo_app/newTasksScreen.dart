import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';
class newTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    myCubit cubit=myCubit.get(context);
    return BlocConsumer<myCubit,MenuState>(
    listener: (context,state){},
    builder: (context,state){
    return buildScreen(
      context: context,
      cubit: cubit,
      tasks: cubit.newTasks
    );
    },
    );


  }
}
