import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_App/shopCubit/shop_cubit.dart';
import 'package:untitled/modules/shop_App/shopCubit/states.dart';
import 'package:untitled/modules/shop_App/shop_login_screen/shop_login.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cash_helper.dart';
import 'package:untitled/shared/style/colors.dart';

class SettingsScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>
      (
        listener: (context,states){
          var cubit=ShopCubit.get(context);
          if(states is UpdateProfileSuccess){
            if(cubit.userProfileData!.status==true){
              ToastMaker(message: "updated successfully", color: Colors.green);
            }else{
              ToastMaker(message: "something went wrong", color: Colors.yellow);
            }

          }
        },
        builder: (context,states){
          var cubit=ShopCubit.get(context);
            nameController.text = "${cubit.userProfileData!.data!.name}";
            emailController.text = "${cubit.userProfileData!.data!.email}";
            phoneController.text = "${cubit.userProfileData!.data!.phone}";
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                      color: defaultColor,
                      inputType: TextInputType.text,
                      controller: nameController,
                      prefix: Icon(Icons.person),
                      onsubmit: (value){

                      },
                      ontap: (){

                      },
                      onchanged: (value){
                      }
                  ),
                  SizedBox(height: 15,),
                  defaultFormField(
                      color: defaultColor,
                      inputType: TextInputType.text,
                      controller: emailController,
                      prefix: Icon(Icons.email),
                      onsubmit: (value){
                      },
                      ontap: (){
                      },
                      onchanged: (value){
                      }
                  ),
                  SizedBox(height: 15,),
                  defaultFormField(
                      color: defaultColor,
                      inputType: TextInputType.text,
                      controller: phoneController,
                      prefix: Icon(Icons.phone),
                      onsubmit: (value){
                      },
                      ontap: (){
                      },
                      onchanged: (value){
                      }
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    color: defaultColor,
                    child: TextButton(
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                      onPressed: ()async{
                       bool internetConnection= await checkInternetConnection();
                        if(internetConnection==true) {
                           cubit.updateUserProfile(
                              email: emailController.text,
                              phone: phoneController.text,
                              name: nameController.text
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    color: defaultColor,
                    child: TextButton(
                      child: Text(
                        'LOGOUT',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: (){
                        navigateAndReplace(context, ShopLogin());
                        CashHelper.ClearData(key:'token');
                        cubit.navItemIndex=0;
                        CashHelper.firstRun=false;
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                ],

              ),
            ),
          );

        },

    );

  }
}
