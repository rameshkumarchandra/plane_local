import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/provider_list.dart';
import '../custom_text.dart';

class SelectIssuePriority extends ConsumerStatefulWidget {
  const SelectIssuePriority({super.key});

  @override
  ConsumerState<SelectIssuePriority> createState() => _SelectIssuePriorityState();
}

class _SelectIssuePriorityState extends ConsumerState<SelectIssuePriority> {

  var selectedPriority = 4;
var priorities = [
{
      'name': 'Urgent',
      'icon': const Icon(Icons.error_outline_rounded),
    },
     {
      'name': 'High',
      'icon': const Icon(Icons.signal_cellular_alt_outlined),
    },
    {
      'name': 'Medium',
      'icon':  const Icon(Icons.signal_cellular_alt_2_bar_outlined),
    },
       {
      'name': 'Low',
      'icon': const Icon(Icons.signal_cellular_alt_1_bar_outlined),
    },
    {
      'name': 'None',
    
      'icon': const Icon(Icons.remove_circle_outline_rounded),
    }
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var prov = ref.read(ProviderList.issuesProvider);
        prov.createIssuedata['priority'] = priorities[selectedPriority];
        prov.setsState();
        return true;
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      'Select Priority',
                      type: FontStyle.heading,
                    ),
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close))
                  ],
                ),
                Container(
                  height: 15,
                ),
                ListView.builder(
                    itemCount: priorities.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPriority = index;
                          });
                          
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.only(
                            left: 5,
                          ),
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(248, 249, 250, 1),
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                               //   color: const Color.fromRGBO(55, 65, 81, 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                alignment: Alignment.center,
                                child: index==4?Transform.rotate(angle: 40,
                                
                                child:  priorities[index]['icon'] as Widget,
                                ) :
                                  priorities[index]['icon'] as Widget
                                      
                                  
                              ),
                              Container(
                                width: 10,
                              ),
                              CustomText(
                               priorities[index]['name']
                                      .toString(),
                                type: FontStyle.subheading,
                              ),
                              const Spacer(),
                              selectedPriority == index
                                  ? const Icon(
                                      Icons.done,
                                      color: Color.fromRGBO(8, 171, 34, 1),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
