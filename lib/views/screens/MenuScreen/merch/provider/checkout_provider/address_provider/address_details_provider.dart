import 'dart:convert';

import 'package:http/http.dart' as http;
class AddressDetailsProvider{

  Future<void> addAddress(String title,String fullName,String addressLine1,String addressLine2,String landmark,String state,String city, int mobNo,int pinCode, )async{
    try{
     await http.post(Uri.parse(''));
    }catch(e){
      print("Error adding Address to DB");
    }
  }
  Future<void> sendSelectedAddress(String title,String fullName,String addressLine1,String addressLine2,String landmark,String state,String city, int mobNo,int pinCode, )async{
    try{
     await http.post(Uri.parse(''));
    }catch(e){
      print("Error adding Address to DB");
    }
  }
  Future<List<Map<String, dynamic>>> getAddress()async{
    try{
     final res = await http.get(Uri.parse(''));
     if(res.statusCode == 200){
       print("Successfully get address");
       final data = jsonDecode(res.body);
       List<Map<String,dynamic>> addressList = data;
       return addressList;
     }
    }catch(e){
      print("Error getting Address form DB");
    }
    List<Map<String,dynamic>> addressList = [];
    return addressList;
  }

  Future<void> editAddress(String fullName,String addressLine1,String addressLine2,String landmark,String state,String city, int mobNo,int pinCode,)async{
    try{
     await http.post(Uri.parse(''));
    }catch(e){
      print("Error editing Address to DB");
    }
  }


}