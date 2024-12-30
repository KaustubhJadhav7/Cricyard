import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPaymentMethodSelectionContainer extends StatefulWidget {
  final List<String> paymentMethods;
  final ValueChanged<String> onPaymentMethodSelected;

  const MyPaymentMethodSelectionContainer(
      {super.key,
      required this.paymentMethods,
      required this.onPaymentMethodSelected});

  @override
  _MyPaymentMethodSelectionContainerState createState() =>
      _MyPaymentMethodSelectionContainerState();
}

class _MyPaymentMethodSelectionContainerState
    extends State<MyPaymentMethodSelectionContainer> {
  String _selectedPaymentMethod = '';

  @override
  void initState() {
    super.initState();
    if (widget.paymentMethods.isNotEmpty) {
      _selectedPaymentMethod = widget.paymentMethods[0];
      widget.onPaymentMethodSelected(_selectedPaymentMethod);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.paymentMethods.map((method) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: _selectedPaymentMethod == method ? 1.0 : 0.5),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                child: Row(
                  children: [
                    Radio<String>(
                      activeColor: Colors.black,
                      value: method,
                      groupValue: _selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                          widget.onPaymentMethodSelected(value);
                        });
                      },
                    ),
                    Text(
                      method,
                      style: GoogleFonts.getFont('Poppins',
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
        if (_selectedPaymentMethod == 'Card') ...[
          Text(
            "Please ensure your card is enabled for online transactions.",
            style: GoogleFonts.getFont('Poppins', color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: _buildTextField(
              label: 'Card Number',
              keyboardType: const TextInputType.numberWithOptions(),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildTextField(label: 'Expiry Date'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildTextField(label: 'CVV / CVC'),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTextField(
      {required String label,
      String? hint,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters}) {
    return TextField(
      cursorColor: Colors.black,
      // cursorErrorColor: Colors.red,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: GoogleFonts.getFont('Poppins',
            color: Colors.grey[800], fontSize: 14, fontWeight: FontWeight.w200),
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
}
