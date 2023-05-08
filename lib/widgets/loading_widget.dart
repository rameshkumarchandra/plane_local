import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:plane_startup/utils/constants.dart';
import 'package:plane_startup/utils/text_styles.dart';

class LoadingWidget extends StatefulWidget {
  Widget widgetClass;
  bool loading;
  LoadingWidget({required this.widgetClass, required this.loading, super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.widgetClass,
        widget.loading
            ? Container(
                color: Colors.white.withOpacity(0.7),
                height: height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineSpinFadeLoader,
                          colors: [Colors.black],
                          strokeWidth: 1.0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'processing...',
                        style: TextStylingWidget.smallText,
                      )
                    ],
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
