import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/news_cubit/cubit.dart';
import 'package:untitled/layout/news_app/news_cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class searchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchBar=TextEditingController();
    return BlocConsumer<newsCubit,newsStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=newsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              defaultFormField(
                  controller: searchBar,
                  inputType: TextInputType.text,
                  onsubmit: (String value){

                  },
                  ontap: (){

                  },
                  onchanged:(String value){
                    cubit.getSearchedData(value);

                  },
                  label: "search",
                  prefix: Icon(Icons.search),
                  color: Theme.of(context).textTheme.headline1!.color
              ),
              Expanded(child: buildArticleScreen(context,cubit.searchedData,isSearch: true))
            ],

          ),

        );
      },
       //
    );
  }
}
