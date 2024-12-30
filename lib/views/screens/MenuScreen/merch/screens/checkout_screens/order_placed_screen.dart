import 'package:cricyard/views/screens/MenuScreen/merch/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Lottie.asset('assets/animations/confirm.json',
                        repeat: false, frameRate: FrameRate(120)),
                    Text(
                      "THANK YOU ",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "Your order has been successfully placed",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      "Order id #758594048495957695",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder()),
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xFF219ebc))),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductHomeScreen(),
                              ));
                        },
                        child: Text(
                          "Continue shopping",
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.white, fontSize: 16),
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
