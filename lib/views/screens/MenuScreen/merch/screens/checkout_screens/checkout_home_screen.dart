import 'package:cricyard/views/screens/MenuScreen/merch/screens/checkout_screens/payment_screens/payment_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/merch/screens/checkout_screens/review_screen/review_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/merch/screens/checkout_screens/shipping_screens/shipping_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutHomeScreen extends StatefulWidget {
  const CheckOutHomeScreen({Key? key}) : super(key: key);

  @override
  _CheckOutHomeScreenState createState() => _CheckOutHomeScreenState();
}

class _CheckOutHomeScreenState extends State<CheckOutHomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

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
          "Checkout",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: _currentPage >= 0 ? Colors.black : Colors.white,
                      ),
                      Text("Shipping",style: GoogleFonts.getFont('Poppins',color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Container(
                    color: Colors.grey,
                    width:  MediaQuery.of(context).size.width*0.2,
                    height: 1,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payment,
                        color: _currentPage >= 1 ? Colors.black : Colors.grey,
                      ),
                      Text("Payment",style: GoogleFonts.getFont('Poppins',color: _currentPage >= 1 ? Colors.black : Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),)
                    ],
                  ),
                  Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width*0.2,
                    height: 1,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt,
                        color: _currentPage >= 2 ? Colors.black : Colors.grey,
                      ),
                      Text("Review",style: GoogleFonts.getFont('Poppins',color:_currentPage >= 2 ? Colors.black : Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ShippingOverviewScreen(
                  onNext: () => _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                PaymentOverviewScreen(
                  onNext: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  onPrevious: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                ReviewPage(
                  onPrevious: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}