import 'package:flutter/material.dart';
import 'package:website/provider/data_provider.dart';
import 'package:website/services/firebase_service.dart';
import 'package:provider/provider.dart';

import '../../models/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context,listen: false);
    dataProvider.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    List<DataModel> dataList = dataProvider.getData;
    return Scaffold(
      body: Container(
        child: Text(dataList[0].catName),
      ),
    );
  }
}
