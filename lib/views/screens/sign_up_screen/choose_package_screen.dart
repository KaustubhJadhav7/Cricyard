import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/color_constants.dart';
import '../../../Utils/image_constant.dart';
import '../../../Utils/size_utils.dart';
import '../../../resources/api_constants.dart';
import '../../../theme/app_style.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

import '../Login Screen/view/CustomButton.dart';
import '../signupF/after_signup_welcome_pade_f.dart';

class PlanSelectionScreen extends StatefulWidget {
  const PlanSelectionScreen({super.key});

  @override
  _PlanSelectionScreenState createState() => _PlanSelectionScreenState();
}

class _PlanSelectionScreenState extends State<PlanSelectionScreen> {
  List<Map<String, dynamic>> packages = [];
  bool isMonthly = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        "${ApiConstants.baseUrl}/token/SubscriptionPackage/SubscriptionPackage"));

    if (response.statusCode <= 209) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        packages = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: getVerticalSize(49),
          leadingWidth: 40,
          leading: AppbarImage(
              height: getSize(24),
              width: getSize(24),
              svgPath: ImageConstant.imgArrowleftBlueGray900,
              margin: getMargin(left: 16, top: 12, bottom: 13),
              onTap: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: AppbarTitle(text: "Choose A Plan")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Text(!isMonthly ? 'Annual Plans' : 'Monthly Plans',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtGilroyBold18Bluegray900),
              Transform.scale(
                scale: 0.7, // Adjust the scale factor as needed
                child: Switch(
                  activeColor: ColorConstant.purple900,
                  value: isMonthly,
                  onChanged: (newValue) {
                    setState(() {
                      isMonthly = newValue;
                    });
                  },
                ),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];
                return PackageCart(
                    package: package, isMonthly: isMonthly, index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PackageCart extends StatefulWidget {
  final Map<String, dynamic> package;
  final bool isMonthly;
  final int index;

  PackageCart(
      {required this.package, required this.isMonthly, required this.index});

  @override
  State<PackageCart> createState() => _PackageCartState();
}

class _PackageCartState extends State<PackageCart> {
  @override
  void initState() {
    super.initState();
    fetchData(widget.package['id']);
  }

  List<Map<String, dynamic>> dataforlist = [];

  Future<void> fetchData(int id) async {
    final response = await http.get(Uri.parse(
        "${ApiConstants.baseUrl}/token/Billing/PackageService/bysubscriptionPkgId/$id"));

    if (response.statusCode <= 209) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        dataforlist = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.isMonthly
        ? widget.package['monthlyPrice']
        : widget.package['annuallyPrice'];

    return Card(
      color: widget.index % 2 == 0
          ? Color.fromARGB(255, 234, 217, 246)
          : Color.fromARGB(255, 235, 210, 239),
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.package['packageName'],
              style: GoogleFonts.poppins()
                  .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.package['description'],
              style: GoogleFonts.poppins().copyWith(
                color: ColorConstant.blueGray900,
                fontSize: getFontSize(
                  16,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Discount: ${widget.package['discountedComment']}',
              style: AppStyle.txtGilroyMedium14Bluegray400,
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.package['packageName'] == 'ENTERPRISE'
                  ? '$price'
                  : '₹ $price',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                height: getVerticalSize(50),
                text: "Get Started",
                onTap: () async {
                  print('Selected Package: ${widget.package['packageName']}');
                  print('Selected Price: $price');
                  // Navigate to a new screen on success
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessScreenF(
                          packageName: widget.package['packageName']),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                Text(
                  widget.package['packageName'] + " plan features :",
                  style: AppStyle.txtGilroyMedium16Black90001,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: forFeatures(dataforlist),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> forFeatures(List<Map<String, dynamic>> featureList) {
    return featureList.map((feature) {
      return buildRichText('✓${feature['name']}');
    }).toList();
  }

  Widget buildRichText(String text) {
    return Text(
      text,
      style: AppStyle.txtGilroyMedium12Bluegray400,
    );
  }
}
