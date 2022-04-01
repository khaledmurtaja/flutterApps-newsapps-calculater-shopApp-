import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modles/shopApp/homeData.dart';
import 'package:untitled/modules/shop_App/shopCubit/shop_cubit.dart';
import 'package:untitled/modules/shop_App/shopCubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/style/colors.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder:(context,states){
          var myCubit = ShopCubit.get(context);
          if(myCubit.homeModelData==null){
            return CircleProgressIndicator();
          }else {
            print("aniother comememe");

            List<ProductModel>? list = myCubit.homeModelData!.data!.products;
            List<ProductModel>? favOnly = [];
            list!.forEach((element) {
              if (element.inFavorite == true) favOnly.add(element);
            });
            //if(myCubit.categories==null) return CircleProgressIndicator();
            // else
            if (favOnly.length == 0)
              return Center(child: Text("There is no favourite items",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),));
            else
              return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildFavItem(
                        favOnly.elementAt(index), context, myCubit);
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      child: SizedBox(height: 10,),
                      color: Colors.grey[300],
                      height: 1,
                    );
                  },
                  itemCount: favOnly.length
              );
          }

        }
        , listener:(context,states){
      print(6776);

    }
    );

  }
  Widget buildFavItem(ProductModel model,BuildContext context,ShopCubit cubit){
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
                      '${model.image}'
                    ),

                  ),
                  if(model.discount!=0)Container(
                    width: 120,
                    color: Colors.red,
                    child:
                    Text(
                      'DISCOUNT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  )

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
                      if(model.oldPrice!=model.price)
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                            color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(

                        backgroundColor:cubit.map[model.id]!? defaultColor:Colors.grey,
                        child: IconButton(
                          color: Colors.white,
                            onPressed: (){
                            ShopCubit.get(context).setFavourite(model);
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
