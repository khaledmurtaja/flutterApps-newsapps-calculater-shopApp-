import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modles/shopApp/categoryData.dart';
import 'package:untitled/modules/shop_App/shopCubit/shop_cubit.dart';
import 'package:untitled/modules/shop_App/shopCubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder:(context,states){
          var myCubit=ShopCubit.get(context);
          if(myCubit.categories==null) return CircleProgressIndicator();
          else
          return ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder:(context,index){
                return buildCategoryItem(myCubit.categories!.generalData!.data[index]);
              },
              separatorBuilder:(context,index){
                return Container(
                  child: SizedBox(height: 10,),
                  color: Colors.grey[300],
                  height: 1,
                );
              },
              itemCount: myCubit.categories!.generalData!.data.length
          );

        }
        , listener:(context,states){
          print(6776);

    }
    );
  }
  Widget buildCategoryItem(CategoriesSpecificData data){
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          Image(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            image: NetworkImage(
                '${data.image}'
            ),
          ),
          SizedBox(width: 15,),
          Text(
            '${data.name}',
            style: TextStyle(
                fontSize: 15,
              fontWeight: FontWeight.w600

            ),
          ),
          Spacer(),
          IconButton(
              onPressed:(){

              } ,
              icon:Icon(Icons.arrow_forward_ios)
          )
        ],
      ),
    );
  }
}
