class SearchModel{
  String? status;
  String? message;
  GeneralData? generalData;
  SearchModel.fromJson(Map<String,dynamic> json){
    json['status']=status;
    json['message']=message;
    generalData=GeneralData.fromJson(json['data']);
  }
}
class GeneralData{
  int? currentPage;
  List<SearchedData> list=[];
  GeneralData.fromJson(Map<String,dynamic> json){
    currentPage=json['current_page'];
    json['data'].forEach((element){
      list.add(SearchedData.fromJson(element));
    });

  }

}
class SearchedData{
  String? imagePath;
  String? name;
  dynamic price;
  bool? inFavorite;
  int? id;
  SearchedData.fromJson(Map<String,dynamic> json){
    imagePath=json['image'];
    name=json['name'];
    price=json['price'];
    inFavorite=json['in_favorites'];
    id=json['id'];
  }
}