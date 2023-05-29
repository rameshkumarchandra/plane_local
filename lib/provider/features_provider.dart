import 'package:flutter/material.dart';

class FeaturesProvider extends ChangeNotifier {
  List features = [
    {'title': 'Issues', 'width': 60, 'show' : true},
    {'title': 'Cycles', 'width': 60, 'show' : true},
    {'title': 'Modules', 'width': 75, 'show' : true},
    {'title': 'Views', 'width': 60, 'show' : true},
    {'title': 'Pages', 'width': 50, 'show' : true},
  ];

  setState() {
    notifyListeners();
  }
}
