import '../model/catgory_Model.dart';
import '../shared/appString.dart';

List<CatgoryModel> getCatgory(){
  List<CatgoryModel> catgory = [];
  //catgory one
  CatgoryModel catgoryModel = CatgoryModel();
  catgoryModel.title = AppString.businessText;
  catgoryModel.imageUrl = AppString.imageBusiness;
  catgory.add(catgoryModel);
  //catgory two
  catgoryModel = CatgoryModel();
  catgoryModel.title = AppString.entertainmentText;
  catgoryModel.imageUrl = AppString.imageEntertainment;
  catgory.add(catgoryModel);
  //catgory three
  catgoryModel = CatgoryModel();
  catgoryModel.title = AppString.healthText;
  catgoryModel.imageUrl = AppString.imageHealth;
  catgory.add(catgoryModel);
  //catgory four
  catgoryModel = CatgoryModel();
  catgoryModel.title = AppString.scienceText;
  catgoryModel.imageUrl = AppString.imageScience;
  catgory.add(catgoryModel);
  //catgory five
  catgoryModel = CatgoryModel();
  catgoryModel.title = AppString.sportsText;
  catgoryModel.imageUrl = AppString.imageSports;
  catgory.add(catgoryModel);
  //catgory six
  catgoryModel = CatgoryModel();
  catgoryModel.title = AppString.technologyText;
  catgoryModel.imageUrl = AppString.imageTechnology;
  catgory.add(catgoryModel);

  return catgory;


}