import 'package:flutter/cupertino.dart';
import 'package:website/services/firebase_service.dart';

import '../models/data_model.dart';
import '../models/project_model.dart';

class DataProvider with ChangeNotifier{

  FirebaseService firebaseService = FirebaseService();

  List<DataModel> _dataList = [];
  List<ProjectModel> _projectList = [];

  List<DataModel> get getData{
    return _dataList;
  }

  Future<void> fetchData() async {
    _dataList = await firebaseService.getCatList();
    notifyListeners();
  }

}