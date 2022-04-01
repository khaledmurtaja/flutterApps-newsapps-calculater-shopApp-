import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/modules/shop_App/register_screen/register_screen.dart';
import 'package:untitled/modules/shop_App/shop_login_screen/loginCubit/cubit.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/local/cash_helper.dart';

import '../ShopHomeScreen.dart';
import 'loginCubit/states.dart';

class ShopLogin extends StatelessWidget {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context,state){},
        builder: (context,state){
          if(state is SuccessLogin){
            if(state.data!.status!){
              CashHelper.saveData(key: 'token', value:state.data!.data!.token)
             .then((value){
                token=CashHelper.Getdata('token');

                navigateAndReplace(context, ShopeHomeScreen());
              });

            }else{
              ToastMaker(message: state.data!.message!, color: Colors.red);

            }
          }
          LoginCubit myCubit=LoginCubit.get(context);
          return Scaffold(
            appBar:  AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 40
                          ),

                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            controller: emailController,
                            inputType:  TextInputType.emailAddress,
                            onsubmit: (text){

                            },
                            ontap: (){

                            },
                            onchanged:(text){

                            },
                            label: 'email',
                            color: Colors.black,
                            prefix:Icon(Icons.email)
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          inputType:  TextInputType.text,
                          isPassword:myCubit.isPasswordVisible? true:false,
                          onsubmit: (text){
                            bool formFilled=formKey.currentState!.validate();
                            if(formFilled) {
                              myCubit.logInToShop(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }

                          },
                          ontap: (){

                          },
                          onchanged:(text){

                          },
                          label:'passowrd',
                          color: Colors.black,
                          prefix:Icon(Icons.lock),
                          suffix: IconButton(
                            icon:myCubit.isPasswordVisible? Icon(Icons.remove_red_eye):Icon(Icons.visibility_off),
                            onPressed: (){
                              myCubit.onClickRedEye();

                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        isLoading(
                          state: state,
                          widget:
                          Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: defTextButton(
                                text: Text(
                                  'Login',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                function:(){
                                  bool formFilled=formKey.currentState!.validate();
                                  if(formFilled) {
                                    myCubit.logInToShop(
                                        email: emailController.text,
                                        password: passwordController.text
                                    );
                                  }
                                }
                            ),
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('don\'t have an account?'),
                            defTextButton(
                                function:(){
                                  navigateTo(context,RegisterScreen());

                                },
                                text: Text(
                                  'Register now',
                                  style:TextStyle(
                                      color: Colors.blue
                                  ),
                                )
                            )
                          ],
                        )

                      ],

                    ),
                  ),
                ),
              ),
            ),

          );
        }
      )

    );
  }
}
