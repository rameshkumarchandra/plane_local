import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plane_startup/screens/integrations.dart';
import 'package:plane_startup/utils/custom_text.dart';

class BillingPlans extends StatefulWidget {
  const BillingPlans({super.key});

  @override
  State<BillingPlans> createState() => _BillingPlansState();
}

class _BillingPlansState extends State<BillingPlans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              'Billings & Plans',
              type: FontStyle.appbarTitle,
            ),
            Container(
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: Color.fromRGBO(63, 118, 255, 1),
                  ),
                  CustomText('Add',
                      type: FontStyle.title,
                      color: const Color.fromRGBO(63, 118, 255, 1)),
                ],
              ),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            height: 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            padding: const EdgeInsets.only(
              left: 16,
            ),
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(69, 69, 69, 1),
                  Color.fromRGBO(143, 143, 147, 1),
                ])),
            child: Row(
              children: [
                SvgPicture.asset("assets/svg/stars.svg"),
                const SizedBox(
                  width: 15,
                ),
                CustomText(
                  'Free launch Pro Plan',
                  type: FontStyle.buttonText,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            padding: const EdgeInsets.only(left: 16, top: 16),
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: const Color.fromRGBO(250, 250, 250, 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Payment Due',
                  type: FontStyle.title,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  '__',
                  type: FontStyle.title,
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: CustomText(
              'Current Plan',
              textAlign: TextAlign.left,
              type: FontStyle.heading,
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300)),
            child: Column(
              children: [
                CustomText(
                  'You are currently using free plan. ',
                  textAlign: TextAlign.center,
                  type: FontStyle.title,
                ),
                GestureDetector(
                     onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Integrations()));
              },
                  child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(63, 118, 255, 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                          child: CustomText(
                        'View plans & Upgrade',
                        color: Colors.white,
                        type: FontStyle.buttonText,
                      ))),
                ),
              ],
            ),
          ),

           Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 16, right: 16, top: 25),
            child: CustomText(
              'Billing History',
              textAlign: TextAlign.left,
              type: FontStyle.heading,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 40, bottom: 40),
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.receipt_long,
                  size: 50,
                  color: Color.fromRGBO(133, 142, 150, 1),
                ),
                const SizedBox(height: 30,),
                CustomText(
                  'There are no invoices to display',
                  textAlign: TextAlign.center,
                  type: FontStyle.title,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
