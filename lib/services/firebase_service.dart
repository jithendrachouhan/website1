import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/banner_model.dart';
import '../models/data_model.dart';
import '../models/project_model.dart';

class FirebaseService {
  CollectionReference categoryReference = FirebaseFirestore.instance.collection("CATEGORY");
  CollectionReference projectReference = FirebaseFirestore.instance.collection("PROJECTS");
  CollectionReference bannerReference = FirebaseFirestore.instance.collection("BANNERS");

  Future<List<DataModel>> getCatList() async {
    final QuerySnapshot data = await categoryReference.get();
    List<DataModel> catData = [];
    for (var element in data.docs){
      List<ProjectModel> projectModel = [];
      for (var element in List.from(element.get("projects"))) {
        final projectSnapshot = await projectReference.doc(element.toString()).get();
        if(projectSnapshot.exists){
          Map<String, dynamic>? projectData = projectSnapshot.data() as Map<String, dynamic>?;
          String projectID = projectSnapshot.reference.id;
          projectModel.add(
              ProjectModel(
                  projectName: projectData?["project_name"],
                  images: List.from(projectData?["images"]),
                  tags: List.from(projectData?["tags"]),
                  projectID: projectID
              )
          );
        }
      }
      catData.add(
          DataModel(
              catName: element.get("cat_name"),
              catID: element.id,
              projects: projectModel
          )
      );
    }
    return catData;
  }
  
  Future<BannerModel> getBannerData() async{
    final QuerySnapshot data = await bannerReference.get();
    return BannerModel(images: List.from(data.docs[0].get("banners")));
  }
  
  
  Future<List<ProjectModel>> getProjectData() async {
    List<ProjectModel> projectData = [];
    final QuerySnapshot data = await projectReference.get();
    for (var element in data.docs) {
      projectData.add(
          ProjectModel(
              projectName: element.get("project_name"),
              images: List.from(element.get("images")),
              tags: List.from(element.get("tags")),
              projectID: element.id)
      );
    }
    return projectData;
  }

  
}