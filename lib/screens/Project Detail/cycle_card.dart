import 'package:flutter/material.dart';

import '../../utils/custom_text.dart';
import 'cycle_detail.dart';

class CycleCard extends StatefulWidget {
  const CycleCard({super.key});

  @override
  State<CycleCard> createState() => _CycleCardState();
}

class _CycleCardState extends State<CycleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const CycleDetail()));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, bottom: 15),
              child: CustomText(
                'Cycle Name',
                type: FontStyle.subheading,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: Row(
                children:  [
                  const Icon(
                    Icons.calendar_month,
                    size: 18,
                  ),
                  CustomText(
                    ' Jan 16, 2022',
                      type: FontStyle.subtitle,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(
                    Icons.calendar_month,
                    size: 18,
                  ),
                  CustomText(
                    ' Jan 16, 2022',
                    type: FontStyle.subtitle,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 5, bottom: 15),
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   CustomText(
                    'Vamsi Kurama',
                      type: FontStyle.subtitle,
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 15),
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: Colors.grey.shade100,
              child: CustomText(
                'Progress -10%',
              type: FontStyle.subtitle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
