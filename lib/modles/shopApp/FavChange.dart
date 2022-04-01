class FavChange{
  bool? status;
  String? message;
  FavChange.fromJson(dynamic map){
    status=map['status'];
    message=map['message'];

  }
}