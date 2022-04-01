class HomeModel{
  bool? status;
  DataModel? data;
  HomeModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=DataModel(json['data']);

  }
}
class DataModel {
  List<BannerModel>? banners = [
  ];
  List<ProductModel>? products=[];

  DataModel(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners!.add(BannerModel(element));
    });
    json['products'].forEach((element) {
      products!.add(ProductModel(element));
    });
  }

}
class BannerModel{
  int? id;
  String? image;
  BannerModel(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];


  }

}
class ProductModel{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorite;
  bool? inCart;
  ProductModel(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    inFavorite=json['in_favorites'];
    inCart=json['in_cart'];
    name=json['name'];

  }

}