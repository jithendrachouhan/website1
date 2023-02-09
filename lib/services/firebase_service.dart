import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/data_model.dart';
import '../models/project_model.dart';

class FirebaseService {
  CollectionReference categoryReference = FirebaseFirestore.instance.collection("CATEGORY");
  CollectionReference projectReference = FirebaseFirestore.instance.collection("PROJECTS");

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
}