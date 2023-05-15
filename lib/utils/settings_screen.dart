// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:plane_startup/utils/custom_appBar.dart';

// import '../provider/provider_list.dart';

// class SettingScreen extends ConsumerStatefulWidget {
//   const SettingScreen({super.key});

//   @override
//   ConsumerState<SettingScreen> createState() => _SettingScreenState();
// }

// class _SettingScreenState extends ConsumerState<SettingScreen> {
//   List<String> tabs = [
//     'Profile',
//     'Control',
//     'Members',
//     'Features',
//     'Help',
//     'About',
//   ];

//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     var themeProvider = ref.watch(ProviderList.themeProvider);
//     return Scaffold(
//       backgroundColor: themeProvider.secondaryBackgroundColor,
//       appBar: CustomAppBar(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         text: 'Settings',
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             //grey line
//             Container(
//               height: 1,
//               width: double.infinity,
//               color: themeProvider.secondaryBackgroundColor,
//             ),

//             Container(
//               height: 15,
//               color: themeProvider.backgroundColor,
//             ),

//             Container(
//               //padding: const EdgeInsets.symmetric(horizontal: 20),
//               color: themeProvider.backgroundColor,
//               height: 34,
//               child: ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: tabs.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = index;
//                       });
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 20),
//                       child: Column(
//                         children: [
//                           Text(
//                             tabs[index],
//                             style: TextStyle(
//                               fontSize: 19,
//                               fontWeight: selectedIndex == index
//                                   ? FontWeight.w500
//                                   : FontWeight.w400,
//                               color: selectedIndex == index
//                                   ? const Color.fromRGBO(63, 118, 255, 1)
//                                   : themeProvider.secondaryTextColor,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Container(
//                             height: 7,
//                             //set the width of the container to the length of the text
//                             width: tabs[index].length * 10.1,
//                             decoration: BoxDecoration(
//                               color: selectedIndex == index
//                                   ? const Color.fromRGBO(63, 118, 255, 1)
//                                   : Colors.transparent,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             //grey line
//             Container(
//               height: 1,
//               width: double.infinity,
//               color: themeProvider.secondaryBackgroundColor,
//             ),

//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 15,
//                 top: 20,
//                 right: 15,
//               ),
//               child: ListView(
//                 shrinkWrap: true,
//                 physics: const BouncingScrollPhysics(),
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'Icon & Name',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: themeProvider.secondaryTextColor,
//                         ),
//                       ),
//                       const Text(
//                         ' *',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   //row containing 2 containers one for icon, one textfield
//                   Row(
//                     children: [
//                       //icon container
//                       Container(
//                         height: 45,
//                         width: 45,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             color: Color.fromRGBO(226, 226, 226, 1),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       //textfield
//                       Expanded(
//                         child: Container(
//                           height: 45,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                               color: Color.fromRGBO(226, 226, 226, 1),
//                             ),
//                           ),
//                           child: const Padding(
//                             padding: EdgeInsets.only(
//                               left: 10,
//                               right: 10,
//                             ),
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 // hintText: 'Enter Name',
//                                 // hintStyle: TextStyle(
//                                 //   fontSize: 15,
//                                 //   fontWeight: FontWeight.w400,
//                                 //   color: Color.fromRGBO(69, 69, 69, 1),
//                                 // ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Text(
//                         'Description',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: themeProvider.secondaryTextColor,
//                         ),
//                       ),
//                       const Text(
//                         ' *',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   //textfield
//                   Container(
//                     height: 105,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Color.fromRGBO(226, 226, 226, 1),
//                       ),
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.only(
//                         left: 10,
//                         right: 10,
//                       ),
//                       child: TextField(
//                         maxLines: 4,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           // hintText: 'Enter Description',
//                           // hintStyle: TextStyle(
//                           //   fontSize: 15,
//                           //   fontWeight: FontWeight.w400,
//                           //   color: Color.fromRGBO(69, 69, 69, 1),
//                           // ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Text(
//                         'Cover',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: themeProvider.secondaryTextColor,
//                         ),
//                       ),
//                       const Text(
//                         ' *',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   //textfield
//                   Container(
//                     height: 105,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Color.fromRGBO(226, 226, 226, 1),
//                       ),
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.only(
//                         left: 10,
//                         right: 10,
//                       ),
//                       child: TextField(
//                         maxLines: 4,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           // hintText: 'Enter Description',
//                           // hintStyle: TextStyle(
//                           //   fontSize: 15,
//                           //   fontWeight: FontWeight.w400,
//                           //   color: Color.fromRGBO(69, 69, 69, 1),
//                           // ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Text(
//                         'Identifier',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: themeProvider.secondaryTextColor,
//                         ),
//                       ),
//                       const Text(
//                         ' *',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   //textfield
//                   Container(
//                     height: 45,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Color.fromRGBO(226, 226, 226, 1),
//                       ),
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.only(
//                         left: 10,
//                         right: 10,
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           // hintText: 'Enter Identifier',
//                           // hintStyle: TextStyle(
//                           //   fontSize: 15,
//                           //   fontWeight: FontWeight.w400,
//                           //   color: Color.fromRGBO(69, 69, 69, 1),
//                           // ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Text(
//                         'Network',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: themeProvider.secondaryTextColor,
//                         ),
//                       ),
//                       const Text(
//                         ' *',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   //textfield
//                   Container(
//                     height: 45,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Color.fromRGBO(226, 226, 226, 1),
//                       ),
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.only(
//                         left: 10,
//                         right: 10,
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           // hintText: 'Enter Network',
//                           // hintStyle: TextStyle(
//                           //   fontSize: 15,
//                           //   fontWeight: FontWeight.w400,
//                           //   color: Color.fromRGBO(69, 69, 69, 1),
//                           // ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Text(
//                         'Danger Zone',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: themeProvider.secondaryTextColor,
//                         ),
//                       ),
//                       const Text(
//                         ' *',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   //textfield
//                   Container(
//                     height: 45,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Color.fromRGBO(226, 226, 226, 1),
//                       ),
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.only(
//                         left: 10,
//                         right: 10,
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           // hintText: 'Enter Danger Zone',
//                           // hintStyle: TextStyle(
//                           //   fontSize: 15,
//                           //   fontWeight: FontWeight.w400,
//                           //   color: Color.fromRGBO(69, 69, 69, 1),
//                           // ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
