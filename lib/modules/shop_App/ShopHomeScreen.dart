import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_App/searchScreen/search_screen.dart';
import 'package:untitled/modules/shop_App/shopCubit/shop_cubit.dart';
import 'package:untitled/modules/shop_App/shopCubit/states.dart';
import 'package:untitled/shared/components/components.dart';
class ShopeHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
          listener: (context,state){

          },
          builder: (context,state){
            ShopCubit myCubit=ShopCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    'salla',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed:(){
                        navigateTo(context, SearchScreen());
                      },
                      icon:Icon(Icons.search)
                  )
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: myCubit.navBarItems,
                onTap: (indexOfClickedItem){
                  myCubit.changeNavItemIndex(indexOfClickedItem);
                },
                currentIndex: myCubit.navItemIndex,
              ),
              body: myCubit.navScreens[myCubit.navItemIndex],
            );
          },

        );

  }
}
