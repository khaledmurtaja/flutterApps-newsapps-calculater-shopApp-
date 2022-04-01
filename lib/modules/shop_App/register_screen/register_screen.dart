import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_App/register_screen/registerCubit/cubit.dart';
import 'package:untitled/modules/shop_App/register_screen/registerCubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/local/cash_helper.dart';
import 'package:untitled/shared/style/colors.dart';

import '../ShopHomeScreen.dart';

class RegisterScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=>RegisterCubit(),
        child: BlocConsumer<RegisterCubit,RegisterState>(
          listener: (context,states){
            if(states is SuccessRegister){
              if(states.data!.status!){
                CashHelper.saveData(key: 'token', value:states.data!.data!.token)
                    .then((value){
                  token=CashHelper.Getdata('token');
                  navigateAndReplace(context, ShopeHomeScreen());
                });

              }else{
                ToastMaker(message: states.data!.message!, color: Colors.red);

              }
            }

          },
          builder: (context,states){
            var myCubit=RegisterCubit.get(context);
            return Scaffold(
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
                            'REGISTER',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 40
                            ),

                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Signup now & start shopping',
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                              controller: nameController,
                              inputType:  TextInputType.text,
                              onsubmit: (text){

                              },
                              ontap: (){

                              },
                              onchanged:(text){

                              },
                              label: 'name',
                              color: Colors.black,
                              prefix:Icon(Icons.person)
                          ),
                          SizedBox(
                            height: 15,
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
                          defaultFormField(
                              controller: phoneController,
                              inputType:  TextInputType.phone,
                              onsubmit: (text){
                                bool formFilled=formKey.currentState!.validate();
                                if(formFilled) {
                                  myCubit.registerToShop(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name:nameController.text,
                                      phone: phoneController.text
                                  );
                                }

                              },
                              ontap: (){

                              },
                              onchanged:(text){

                              },
                              label: 'phone',
                              color: Colors.black,
                              prefix:Icon(Icons.phone_android)
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            color: defaultColor,
                            width: double.infinity,
                            child: defTextButton(
                                function:(){
                                  bool formFilled=formKey.currentState!.validate();
                                  if(formFilled) {
                                    myCubit.registerToShop(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name:nameController.text,
                                        phone: phoneController.text
                                    );
                                  }


                                },
                                text: Text(
                                  'Register',
                                  style:TextStyle(
                                      color: Colors.white
                                  ),
                                )
                            ),
                          ),
                          SizedBox(height: 10,),
                          if(states is LoadingRegister)
                            LinearProgressIndicator()
                        ],

                      ),
                    ),
                  ),
                ),
              ),
            );

          },

        ),

    );
  }
}
