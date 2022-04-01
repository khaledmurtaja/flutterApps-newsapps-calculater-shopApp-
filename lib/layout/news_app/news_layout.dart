import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/news_app/search_screen/searchScreen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubit/cubit.dart';

import 'news_cubit/cubit.dart';
import 'news_cubit/states.dart';
class newsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<newsCubit,newsStates>(
      listener: (context,state){},
      builder: (context,state){
        print("anoter rebuld");
        var cubit=newsCubit.get(context);
     return Scaffold(
      appBar: AppBar(
        title: Text(
          'News App',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed:(){
                navigateTo(context, searchScreen());

              },
              icon:Icon(Icons.search)
          ),
          IconButton(
              onPressed:(){
                myCubit.get(context).
                changeTheme();
              },
              icon:Icon(Icons.brightness_4_outlined)
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: cubit.items,
        currentIndex: cubit.currentIndex,
        onTap:(index){
          cubit.changeIndex(index);
        },
      ),
     body: cubit.screens[cubit.currentIndex],
    );
      },
    );

  }
}
