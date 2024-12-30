import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtotalExpandableContainer extends StatefulWidget {
  const SubtotalExpandableContainer({super.key});

  @override
  _SubtotalExpandableContainerState createState() => _SubtotalExpandableContainerState();
}

class _SubtotalExpandableContainerState extends State<SubtotalExpandableContainer> {
  bool _isExpanded = true;

  final double _price = 500.0;
  final double _tax = 50.0;
  final double _shipping = 20.0;
  final double _discount = -40;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal",
                style: GoogleFonts.getFont('Poppins', color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                icon: Icon(
                  _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        if (_isExpanded) _subtotalDetails(),
        const SizedBox(height: 10),
        const Divider(color: Colors.grey),
      ],
    );
  }

  Widget _subtotalDetails() {
    return Column(
      children: [
        _detailRow("6x Items Products", "\$$_price"),
        _detailRow("Shipping", "\$$_shipping"),
        _detailRow("Discount", "\$$_discount"),
        _detailRow("Tax", "\$$_tax"),
      ],
    );
  }

  Widget _detailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.getFont('Poppins', fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,color: Colors.grey,fontSize: 15),
          ),
          Text(
            value,
            style: GoogleFonts.getFont('Poppins', fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,color: Colors.grey,fontSize: 15),
          ),
        ],
      ),
    );
  }
}
