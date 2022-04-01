import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/news_cubit/cubit.dart';
import 'package:untitled/layout/news_app/news_cubit/states.dart';
import 'package:untitled/shared/components/components.dart';
class sportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit=newsCubit.get(context);
    return  BlocConsumer<newsCubit,newsStates>(
    listener: (context,state){},
    builder: (context,state){
    return buildArticleScreen(context,cubit.sports);
    },
    );

  }
}
