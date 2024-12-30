import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingDetailsScreen extends StatefulWidget {
  const ShippingDetailsScreen({super.key});

  @override
  State<ShippingDetailsScreen> createState() => _ShippingDetailsScreenState();
}

class _ShippingDetailsScreenState extends State<ShippingDetailsScreen> {
  final List<String> _states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  String? _selectedState;

  // Define TextEditingController for each TextField
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _addressLabelController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _townCityController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF219ebc),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[700],
        title: const Text(
          "Shipping Details",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              _buildTextField(
                controller: _fullNameController,
                label: 'Full Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                  controller: _mobileNoController,
                  label: 'Mobile No.',
                  icon: Icons.phone,
                  keyboardType: const TextInputType.numberWithOptions(),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              const SizedBox(height: 16),
              _buildTextField(
                  controller: _addressLabelController,
                  icon: Icons.home_work_sharp,
                  label: 'Save this address as',
                  hint: 'E.g: Home/Office'),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _addressController,
                label: 'Flat, House no., Building, Company, Apartment',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _areaController,
                label: 'Area, Street, Sector, Village',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _landmarkController,
                label: 'Landmark',
                hint: 'E.g. near city hospital',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _townCityController,
                label: 'Town/City',
                icon: Icons.location_city,
              ),
              const SizedBox(height: 16),
              _buildStateDropdown(),
              const SizedBox(height: 16),
              _buildTextField(
                  controller: _pinCodeController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  label: 'Pin Code',
                  hint: '6-digit Pincode',
                  icon: Icons.local_post_office,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder()),
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF219ebc))),
              onPressed: _saveShippingDetails,
              child: Text(
                "Save",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.white, fontSize: 16),
              )),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      String? hint,
      IconData? icon,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters}) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      // cursorErrorColor: Colors.red,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: GoogleFonts.getFont('Poppins',
            color: Colors.grey[800], fontSize: 14, fontWeight: FontWeight.w200),
        prefixIcon: Icon(icon, color: Color(0xFF219ebc)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        fillColor: Colors.grey[100],
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        labelStyle: GoogleFonts.getFont('Poppins',
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildStateDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'State',
        prefixIcon: Icon(Icons.map, color: Color(0xFF219ebc)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.black, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        fillColor: Colors.grey[100],
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        labelStyle: GoogleFonts.getFont('Poppins',
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
      ),
      value: _selectedState,
      items: _states.map((state) {
        return DropdownMenuItem<String>(
          value: state,
          child: Text(
            state,
            style: GoogleFonts.getFont('Poppins',
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedState = value;
        });
      },
    );
  }

  void _saveShippingDetails() {
    final shippingDetails = {
      'fullName': _fullNameController.text,
      'mobileNo': _mobileNoController.text,
      'addressLabel': _addressLabelController.text,
      'address': _addressController.text,
      'area': _areaController.text,
      'landmark': _landmarkController.text,
      'townCity': _townCityController.text,
      'state': _selectedState,
      'pinCode': _pinCodeController.text,
    };

    // Send shippingDetails to your backend
    print(shippingDetails); // Replace with your backend call
  }
}
