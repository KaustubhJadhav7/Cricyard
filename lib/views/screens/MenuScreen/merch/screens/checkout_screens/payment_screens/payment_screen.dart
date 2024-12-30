import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/payment_container.dart';

class PaymentOverviewScreen extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const PaymentOverviewScreen({Key? key, required this.onNext, required this.onPrevious}) : super(key: key);

  @override
  State<PaymentOverviewScreen> createState() => _PaymentOverviewScreenState();
}

class _PaymentOverviewScreenState extends State<PaymentOverviewScreen> {
  String _selectedPaymentMethod = '';

  void _handlePaymentMethodSelected(String method) {
    setState(() {
      _selectedPaymentMethod = method;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the initial selected payment method if the list is not empty
    if (_paymentMethods.isNotEmpty) {
      _selectedPaymentMethod = _paymentMethods[0];
    }
  }

  final List<String> _paymentMethods = [
    'Cash on Delivery',
    'PhonePe',
    'Card',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PAYMENT METHOD",
              style: GoogleFonts.getFont('Poppins', color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            ..._paymentMethods.map((method) {
              return PaymentContainer(
                method: method,
                selectedPaymentMethod: _selectedPaymentMethod,
                onPaymentMethodSelected: _handlePaymentMethodSelected,
              );
            }).toList(),
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
            onPressed: () {
              if (_selectedPaymentMethod.isNotEmpty) {
                // Pass the selected payment method to the next screen or process it
                widget.onNext();
              } else {
                // Show an error or prompt the user to select a payment method
                showSnackBar(context, 'Please select a payment method', Colors.red);
              }
            },
            child: Text(
              "Confirm and continue",
              style: GoogleFonts.getFont('Poppins', color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
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
