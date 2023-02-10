import 'package:flutter/material.dart';
import 'package:website/models/project_model.dart';
import 'package:website/provider/data_provider.dart';
import 'package:website/services/firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../models/banner_model.dart';
import '../../models/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseService firebaseService = FirebaseService();

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadInitialData();
    });

  }

  _loadInitialData() async{
    final dataProvider = Provider.of<DataProvider>(context,listen: false);
    await dataProvider.fetchData();
    await dataProvider.fetchBanners();
    await dataProvider.fetchProjects();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    List<DataModel> dataList = dataProvider.getData;
    List<ProjectModel> projectsList = dataProvider.getProjectList;
    BannerModel bannerData = dataProvider.getBannerData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGO"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: _isLoading ? _loadingWidget():
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.black12,
                width: MediaQuery.of(context).size.width,
                child: AspectRatio(
                  aspectRatio: 1920/1080,
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: "https://firebasestorage.googleapis.com/v0/b/photos-2c435.appspot.com/o/banner%2Fimage-11.jpg?alt=media&token=bd30f85d-9e75-4661-9c9e-cf4b9dba2163",
                    placeholder: (context, url) => Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    useOldImageOnUrlChange: true,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget(){
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(child: CircularProgressIndicator()),
    );
  }

}
