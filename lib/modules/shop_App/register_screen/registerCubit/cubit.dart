import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modles/shopApp/logInData.dart';
import 'package:untitled/modules/shop_App/register_screen/registerCubit/states.dart';
import 'package:untitled/shared/network/EndPoints.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
class RegisterCubit extends Cubit<RegisterState>{
  var isPasswordVisible=false;
  LoginData? data;
  RegisterCubit() : super(InitialState());
  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);
  void registerToShop({
    required String email,
    required String password,
    required String name,
    required String phone

 })
{
  emit(LoadingRegister());
    dioHelper.postData(
        url: REGISTER,
        map:{
          'email':email,
          'password':password,
          'name':name,
          'phone':phone
        },
      authorization: ""
    ).then((value) {
      data=LoginData.fromJson(value.data);
      emit(SuccessRegister(data));
    }).catchError((onError){
      print(onError.toString());
      emit(ErrorRegister());

    });

  }
  void onClickRedEye(){
    isPasswordVisible=!isPasswordVisible;
    emit(PasswordIconClickedRegister());
  }

}