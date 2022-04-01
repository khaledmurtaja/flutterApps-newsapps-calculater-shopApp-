
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_App/shopCubit/shop_cubit.dart';
import 'package:untitled/modules/shop_App/shopCubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cash_helper.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        print(6776);
      },
      builder:(context,state){
        var cubit=ShopCubit.get(context);
        if(CashHelper.firstRun==false) {
          cubit.GetHomeData();
          cubit.getUserProfile();
        }
          return isHomeLoading(
              data: cubit.homeModelData,
            categories: cubit.categories,
            cubit: cubit
          );

      },

    );

  }

}
