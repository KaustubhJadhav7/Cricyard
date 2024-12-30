import 'package:cricyard/views/screens/MenuScreen/merch/screens/checkout_screens/order_placed_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/merch/screens/checkout_screens/review_screen/components/items_expandable_container.dart';
import 'package:cricyard/views/screens/MenuScreen/merch/screens/checkout_screens/review_screen/components/overview_container.dart';
import 'package:cricyard/views/screens/MenuScreen/merch/screens/checkout_screens/review_screen/components/subtotal_expandable_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewPage extends StatelessWidget {
  final VoidCallback onPrevious;

  ReviewPage({Key? key, required this.onPrevious}) : super(key: key);

  final Map<String, dynamic> selectedAddress = {
    "addressLabel": "My Home",
    "address": "Time Square Mall Alephata,",
    "townCity": "Pune",
    "pinCode": "673389"
  };
  final Map<String, dynamic> selectedPaymentMethod = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              OverviewContainer(
                title: 'SHIP TO',
                contentTitle: '${selectedAddress['addressLabel']}',
                contentDesc1: '${selectedAddress['address']}',
                contentDesc2:
                    '${selectedAddress['townCity']}, ${selectedAddress['pinCode']}',
              ),
              OverviewContainer(
                title: 'PAYMENT',
                contentTitle: 'Credit Card',
                contentDesc1: '08/2024',
                contentDesc2: '',
              ),
              SizedBox(
                height: 10,
              ),
              ItemsExpandableContainer(),
              SizedBox(
                height: 10,
              ),
              SubtotalExpandableContainer(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",
                        style: GoogleFonts.getFont('Poppins',
                            color: Colors.grey, fontSize: 15)),
                    Text(
                      "\$ 6889,09",
                      style: GoogleFonts.getFont('Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                ),
              )
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
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF219ebc))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPlacedScreen(),
                      ));
                },
                child: Text(
                  "Place Order",
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.white, fontSize: 16),
                )),
          ),
        ));
  }
}
