import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/inputs.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    BoardListsData(items: []);

    return Scaffold(
        body: Container(
            color: Colors.black,
            //  margin: const EdgeInsets.only(top: 24),
            child: Container()));
  }
}
