//import 'package:untitled/modles/shopApp/logInData.dart';

import 'package:untitled/modles/shopApp/logInData.dart';

abstract class RegisterState{}
class InitialState extends RegisterState{}
class LoadingRegister extends RegisterState{}
class SuccessRegister extends RegisterState{
  final LoginData? data;
   SuccessRegister(this.data);
}
class ErrorRegister extends RegisterState{}
class PasswordIconClickedRegister extends RegisterState{}

