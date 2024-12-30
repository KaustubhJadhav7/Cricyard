import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shipping_details_screen.dart';

class MyAddressOverviewCard extends StatelessWidget {
  final String title;
  final String address;
  final String city;
  final int pinCode;
  final bool isSelected;

  const MyAddressOverviewCard({
    super.key,
    required this.title,
    required this.address,
    required this.city,
    required this.isSelected,
    required this.pinCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: isSelected ? 1.5 : 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    address,
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.grey[700],
                        fontSize: 13,
                        fontWeight: FontWeight.w300),
                  ),
                  Row(
                    children: [
                      Text(
                        city,
                        style: GoogleFonts.getFont('Poppins',
                            color: Colors.grey[700],
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        ', $pinCode',
                        style: GoogleFonts.getFont('Poppins',
                            color: Colors.grey[700],
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.grey[200]),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6))),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ShippingDetailsScreen()),
                );
              },
              child: Text(
                "Edit",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.black, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
