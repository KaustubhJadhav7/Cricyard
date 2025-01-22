import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../theme/custom_text_style.dart';
// import '../../core/app_export.dart';
// import '../../widgets/custom_icon_button.dart';
// import '../../widgets/custom_text_form_field.dart'; // ignore_for_file: must_be_immutable

class LoginThreePage extends StatefulWidget {
  const LoginThreePage({Key? key})
      : super(
          key: key,
        );

  @override
  LoginThreePageState createState() => LoginThreePageState();
}

// ignore_for_file: must_be_immutable
class LoginThreePageState extends State<LoginThreePage>
    with AutomaticKeepAliveClientMixin<LoginThreePage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> userData = {};

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userdatastr = prefs.getString('userData');
    if (userdatastr != null) {
      try {
        setState(() {
          userData = json.decode(userdatastr);
        });
        print(userData['token']);
      } catch (e) {
        print("error is ..................$e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.7,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12)
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
               children: [
                _myListTile(title: 'Name', subtitle: "${userData['fullName']}" ?? '', icon: const Icon(Icons.person,color: Colors.black,)),
                _myDivider(),
                 _myListTile(title: 'Email', subtitle: '${userData['email']}', icon: const Icon(Icons.email,color: Colors.black,)),
                 _myDivider(),
                 _myListTile(title: 'Phone', subtitle: '${userData['mob_no']}', icon: const Icon(Icons.phone,color: Colors.black,)),
                 _myDivider(),
                 _myListTile(title: 'Unique-Id', subtitle: '${userData['unique_player_id']}', icon: const Icon(Icons.text_snippet,color: Colors.black,)),
                 _myDivider(),
                 _myListTile(title: 'Address', subtitle: '${userData['city']}, ${userData['state']}', icon: const Icon(Icons.location_on_outlined,color: Colors.black,)),
                 _myDivider(),
                 _myListTile(title: 'Father name', subtitle: '${userData['father_name']}', icon: const Icon(Icons.person,color: Colors.black,)),
                 _myDivider(),
                 _myListTile(title: 'Mother name', subtitle: '${userData['mother_name']}', icon: const Icon(Icons.person,color: Colors.black,)),

               ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _myListTile({required String title,required subtitle,required Widget icon}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: icon),
        title: Text(title,style: CustomTextStyles.titleMediumMediumWhit,),
        subtitle: Text(subtitle,style: CustomTextStyles.titleSmallGray600,),
        trailing: const Icon(Icons.arrow_forward_ios,color: Colors.white,),
      ),
    );
  }
  Widget _myDivider(){
    return  const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Divider(color: Colors.grey,thickness: 0.5,),
    );
  }
}