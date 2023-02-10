import 'package:flutter/cupertino.dart';

class BannerModel with ChangeNotifier{
  late List<String> images;
  BannerModel({required this.images});
}