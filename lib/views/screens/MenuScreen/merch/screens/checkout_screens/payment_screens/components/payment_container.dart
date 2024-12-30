import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentContainer extends StatelessWidget {
  final String method;
  final String selectedPaymentMethod;
  final ValueChanged<String> onPaymentMethodSelected;

  const PaymentContainer({
    Key? key,
    required this.method,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: selectedPaymentMethod == method ? 1.0 : 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Row(
            children: [
              Radio<String>(
                activeColor: Colors.black,
                value: method,
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  onPaymentMethodSelected(value!);
                },
              ),
              Text(
                method,
                style: GoogleFonts.getFont('Poppins', color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
