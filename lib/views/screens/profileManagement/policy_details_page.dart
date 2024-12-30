import 'package:flutter/material.dart';

import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class PolicyDetails extends StatelessWidget {
  final String data;
  final String title;
  const PolicyDetails({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 50,
        title: AppbarTitle(text: title),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(child: Text(data)),
      ),
    );
  }
}
