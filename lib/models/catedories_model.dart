class CategoriesModel
{
  bool ? status;
  CategoriesDataModel ?data;
  CategoriesModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data= CategoriesDataModel.fomJson(json['data']);

  }

}

class CategoriesDataModel
{

  int ? currentPage;
 List<DataModel> data =[];

 CategoriesDataModel.fomJson(Map<String,dynamic>json)
 {
   currentPage=json['current_page'];
   json['data'].forEach((element)
       {
         data.add(DataModel.fromJson(element));
       });
 }
}

class DataModel
{
  int ?id;
  String ?name ;
  String ? image;

  DataModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name = json['name'];
    image = json['image'];
  }
}