class MyCategories{
  bool? status;
  CategoriesGeneralData? generalData;
  MyCategories.fromJson(Map data){
    status=data['status'];
    generalData=CategoriesGeneralData.fromJson(data['data']);

  }

}
class CategoriesGeneralData{
  int? currentPage;
  List<CategoriesSpecificData> data=[];
  CategoriesGeneralData.fromJson(Map<String,dynamic> map){
    currentPage=map['current_page'];
    map['data'].forEach((element){
      data.add(CategoriesSpecificData.fromJson(element));

    });

  }

}
class CategoriesSpecificData{
  int? id;
  String? name;
  String? image;

  CategoriesSpecificData.fromJson(Map<String,dynamic> map){
    id=map['id'];
    name=map['name'];
    image=map['image'];

  }


}