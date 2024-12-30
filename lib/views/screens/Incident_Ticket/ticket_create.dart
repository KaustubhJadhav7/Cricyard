import 'dart:io';

import '/hadwin_components.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import '../../../Utils/image_constant.dart';
import '../../../Utils/size_utils.dart';
import '../../../providers/token_manager.dart';
import '../../../theme/app_style.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../LogoutService/Logoutservice.dart';

class RaisedTicketScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const RaisedTicketScreen({Key? key, required this.userData})
      : super(key: key);

  @override
  _RaisedTicketScreenState createState() => _RaisedTicketScreenState();
}

class _RaisedTicketScreenState extends State<RaisedTicketScreen> {
  List<Map<String, dynamic>> tickets = [];

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    int userid = widget.userData['userId'];
    String baseUrl = ApiConstants.baseUrl;
    final token = await TokenManager.getToken();
    String apiUrl = '$baseUrl/gettickets/$userid';
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 401) {
      LogoutService.logout();
    }
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        tickets = data.cast<Map<String, dynamic>>();
      });
    } else {
      print('Failed to fetch data');
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
          actions: [
            GestureDetector(
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 20,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                          builder: (context) => TicketFormScreen(
                                userData: widget.userData,
                              )),
                    )
                    .then((value) => {fetchTickets()});
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
          centerTitle: true,
          title: AppbarTitle(text: "Raised Tickets")),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return ListTile(
            title: Text(
              'Ticket ID: ${ticket['ticketid']}',
              style: const TextStyle(fontSize: 12),
            ),
            subtitle: Text('Ticket Name: ${ticket['ticketname']}',
                style: const TextStyle(fontSize: 10)),
            // Add more fields as needed
          );
        },
      ),
    );
  }
}

class TicketFormScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const TicketFormScreen({Key? key, required this.userData}) : super(key: key);
  @override
  _TicketFormScreenState createState() => _TicketFormScreenState();
}

class _TicketFormScreenState extends State<TicketFormScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  TextEditingController projectNameController = TextEditingController();
  var screenshot;

  Future<void> submitTicket(File file) async {
    print(widget.userData);
    String title = titleController.text;
    String description = descriptionController.text;
    String baseUrl = ApiConstants.baseUrl;
    final token = await TokenManager.getToken();
    String apiUrl = '$baseUrl/service_request/raise_ticket';

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['Authorization'] = 'Bearer $token';

    // Add text fields to the request
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['userid'] = widget.userData['userId'].toString();
    request.fields['username'] = widget.userData['fullname'];

    // Add file to the request
    if (file != null) {
      request.files.add(
        await http.MultipartFile.fromPath('file', file.path),
      );
    }

    try {
      // Send the request
      final response = await request.send();

      if (response.statusCode == 401) {
        LogoutService.logout();
      }

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Ticket submitted successfully',
          backgroundColor: Colors.green,
        );
        print('Ticket submitted successfully');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to submit ticket.',
          backgroundColor: Colors.red,
        );
        print('Failed to submit ticket. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        screenshot = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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
          title: AppbarTitle(text: "Raise a Ticket")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
                padding: getPadding(top: 19),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Title",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtGilroyMedium16Bluegray900),
                      CustomTextFormField(
                          focusNode: FocusNode(),
                          hintText: "Enter Title",
                          controller: titleController,
                          margin: getMargin(top: 6))
                    ])),
            Padding(
                padding: getPadding(top: 19),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Description",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtGilroyMedium16Bluegray900),
                      CustomTextFormField(
                          focusNode: FocusNode(),
                          hintText: "Enter Description",
                          controller: descriptionController,
                          margin: getMargin(top: 6))
                    ])),
            Padding(
                padding: getPadding(top: 19),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Project Name",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtGilroyMedium16Bluegray900),
                      CustomTextFormField(
                          focusNode: FocusNode(),
                          hintText: "Enter Project Name",
                          controller: projectNameController,
                          margin: getMargin(top: 6))
                    ])), // Adjusted the spacing
            Row(
              children: <Widget>[
                Text('Pick Screenshot of issue'),
                IconButton(
                  onPressed: () {
                    _pickImage(); // Call the function to pick an image
                  },
                  icon: Icon(Icons.file_copy),
                ),
                SizedBox(width: 8.0),
                // Display the selected screenshot file name
                Text(screenshot != null ? screenshot.path.split('/').last : ''),
              ],
            ),
            CustomButton(
              height: getVerticalSize(50),
              text: "Submit",
              margin: getMargin(top: 24, bottom: 5),
              onTap: () async {
                submitTicket(screenshot);
              },
            ),
          ],
        ),
      ),
    );
  }
}
