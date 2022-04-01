import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modles/shopApp/searchModel.dart';
import 'package:untitled/modules/shop_App/searchScreen/SearchCubit/states.dart';
import 'package:untitled/modules/shop_App/shopCubit/shop_cubit.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/style/colors.dart';

import 'SearchCubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchState>(
        listener: (context,state){

        },
        builder: (context,state){
          var cubit=SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  defaultFormField(
                      color: defaultColor,
                      inputType: TextInputType.text,
                      controller: searchController,
                      label: 'search',
                      prefix: Icon(Icons.search),
                      onsubmit: (value){
                        cubit.search(value);
                      },
                      ontap: (){
                      },
                      onchanged: (value){
                      }
                  ),
                  SizedBox(height: 10,),
                    if(state is LoadingSearch) LinearProgressIndicator(),
                    if(state is SuccessSearch)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder:(context,index){
                            return buildFavItem(cubit.searchResult!.generalData!.list[index], context,ShopCubit.get(context));
                          },
                          separatorBuilder:(context,index)=> Container(
                            height: 1,
                            color: Colors.grey,
                          )
                          , itemCount: cubit.searchResult!.generalData!.list.length
                      ),
                    )

                ],

              ),
            ),
          );

        },

      ),
    );
   
  }
  Widget buildFavItem(SearchedData model,BuildContext context,ShopCubit cubit){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Container(
              width: 120,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    // fit: BoxFit.cover,
                    height: 120,
                    width: 120,
                    image: NetworkImage(
                        '${model.imagePath}'
                    ),

                  ),

                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                            color: defaultColor
                        ),
                      ),
                      SizedBox(width: 8,),
                      Spacer(),
                      CircleAvatar(

                       // backgroundColor:cubit.map[model.id]!? defaultColor:Colors.grey,
                        child: IconButton(
                            color: Colors.white,
                            onPressed: (){
                            },
                            icon:Icon(Icons.favorite_border)
                        ),
                      )

                    ],
                  )

                ],
              ),
            )
          ],

        ),
      ),
    );

  }
}
