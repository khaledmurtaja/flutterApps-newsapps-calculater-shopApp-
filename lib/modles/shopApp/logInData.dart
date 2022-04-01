class LoginData{
  bool? status;
  String? message;
  UserLoginData? data;
 LoginData.fromJson(Map map){
   status=map['status'];
   message=map['message'];
   data= map['data']!=null? UserLoginData(map['data']) :null;


 }

}
class UserLoginData{
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;
  String? token;
  int? points;
  int? credits;
  UserLoginData(Map data){
    id=data['id'];
    email=data['email'];
    name=data['name'];
    phone=data['phone'];
    image=data['image'];
    token=data['token'];
    points=data['points'];
   credits=data['credit'];

  }
}