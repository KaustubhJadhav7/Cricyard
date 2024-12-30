import 'package:cricyard/views/screens/MenuScreen/merch/provider/checkout_provider/address_provider/address_details_provider.dart';
import 'package:cricyard/views/screens/MenuScreen/merch/screens/checkout_screens/shipping_screens/shipping_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/my_address_overview_card.dart';

class ShippingOverviewScreen extends StatefulWidget {
  final VoidCallback onNext;

  const ShippingOverviewScreen({Key? key, required this.onNext}) : super(key: key);

  @override
  _ShippingOverviewScreenState createState() => _ShippingOverviewScreenState();
}

class _ShippingOverviewScreenState extends State<ShippingOverviewScreen> {
  AddressDetailsProvider addressDetailsProvider = AddressDetailsProvider();

  int _selectedAddressIndex = -1;

  List<Map<String, dynamic>> _addresses = [
    {
      "addressLabel": "My Home",
      "address": "Time Square Mall Alephata,",
      "townCity": "Pune",
      "pinCode": "673389"
    },
    {
      "addressLabel": "Office",
      "address": "Tech Park, Whitefield,",
      "townCity": "Bangalore",
      "pinCode": "673389"
    },
  ];

  void getAllSavedAddressList() async {
    final data = await addressDetailsProvider.getAddress();
    setState(() {
      _addresses = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ADDRESS",
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShippingDetailsScreen()),
                    );
                  },
                  child: Text(
                    "+ Add New",
                    style: GoogleFonts.getFont('Poppins', color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _addresses.isEmpty
                  ? Center(
                  child: Text(
                    "No saved address yet !!",
                    style: GoogleFonts.getFont('Poppins',
                        fontSize: 20, color: Colors.grey),
                  ))
                  : ListView.builder(
                itemCount: _addresses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAddressIndex = index;
                      });
                    },
                    child: MyAddressOverviewCard(
                      title: _addresses[index]["addressLabel"]!,
                      address: _addresses[index]["address"]!,
                      city: _addresses[index]["townCity"]!,
                      pinCode: int.parse(_addresses[index]["pinCode"]!),
                      isSelected: _selectedAddressIndex == index,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder()),
              backgroundColor: MaterialStatePropertyAll(Color(0xFF219ebc)),
            ),
            onPressed: _onNext,
            child: Text(
              "Next",
              style: GoogleFonts.getFont('Poppins',
                  color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  void _onNext() {
    if (_selectedAddressIndex != -1) {
      final selectedAddress = _addresses[_selectedAddressIndex];
      // Send selectedAddress to your backend
      print("Selected Address: $selectedAddress");
      widget.onNext();

      // // Assuming you have a method in your provider to send the address to the backend
      // addressDetailsProvider.sendSelectedAddress(selectedAddress).then((response) {
      //   if (response.success) {
      //     // Proceed to next step
      //     widget.onNext();
      //   } else {
      //     // Handle error
      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to send address: ${response.error}')));
      //   }
      // });
    } else {
      // No address selected
      showSnackBar(context, "Please select an address", Colors.red);
    }
  }
  void showSnackBar(BuildContext context, String msg, Color color) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.viewPadding.bottom;
    const snackBarHeight = 50.0; // Approximate height of SnackBar

    final topMargin = topPadding + snackBarHeight + 700; // Add some padding

    SnackBar snackBar = SnackBar(
      margin: EdgeInsets.only(bottom: topMargin, left: 16.0, right: 16.0),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent, // Make background transparent to show custom design
      elevation: 0, // Remove default elevation to apply custom shadow
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.8), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 10.0,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                  size: 28.0, // Slightly larger icon
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    msg,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0, // Slightly larger text
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: -15,
            top: -15,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
