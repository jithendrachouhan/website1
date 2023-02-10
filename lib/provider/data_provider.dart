import 'package:flutter/cupertino.dart';
import 'package:website/models/banner_model.dart';
import 'package:website/services/firebase_service.dart';

import '../models/data_model.dart';
import '../models/project_model.dart';

class DataProvider with ChangeNotifier{

  FirebaseService firebaseService = FirebaseService();

  List<DataModel> _dataList = [];
  List<ProjectModel> _projectList = [];
  BannerModel _bannerModel = BannerModel(images: []);

  List<DataModel> get getData{
    return _dataList;
  }

  List<ProjectModel> get getProjectList{
    return _projectList;
  }

  BannerModel get getBannerData{
    return _bannerModel;
  }

  Future<void> fetchData() async {
    _dataList = await firebaseService.getCatList();
    notifyListeners();
  }

  Future<void> fetchBanners() async{
    _bannerModel = await firebaseService.getBannerData();
    notifyListeners();
  }


  Future<void> fetchProjects() async {
    _projectList = await firebaseService.getProjectData();
    notifyListeners();
  }

}