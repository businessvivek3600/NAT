import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

import '../constants/asset_constants.dart';
import '../utils/picture_utils.dart';
import 'bouncing_rotating_widget.dart';

class MyLoadMoreDelegate extends LoadMoreDelegate {
  const MyLoadMoreDelegate();

  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.english}) {
    String text = builder(status);
    if (status == LoadMoreStatus.fail) {
      return Text(text.capitalize!);
    } else if (status == LoadMoreStatus.idle) {
      return const Text('');
    } else if (status == LoadMoreStatus.loading) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BouncingRotatingWidget(
                height: 20,
                bounceSpeed: 700,
                rotationSpeed: 2000,
                child: assetImages(PNGAssets.appLogo, width: 30)),
            /* const SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                  backgroundColor: Colors.blue, strokeWidth: 1.5),
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text.capitalize!),
            ),
          ],
        ),
      );
    } else if (status == LoadMoreStatus.nomore) {
      return Text(text.capitalize!);
    } else {
      return Text(text.capitalize!);
    }
  }
}
