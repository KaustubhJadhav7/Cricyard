import 'package:cricyard/views/screens/MenuScreen/merch/screens/checkout_screens/checkout_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/myCartListTile.dart';
import '../data/models/product_model.dart';
import '../provider/product_data_provider.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  void removeFormCart(BuildContext context, ProductModel productModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Are you sure want to remove !!"),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancle"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProductProvider>().removeItem(productModel);
            },
            child: const Text("Remove"),
          ),
        ],
      ),
    );
  }

  late int newPrice = 0;
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<ProductProvider>().cart;
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                  borderRadius: BorderRadius.circular(12)),
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
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text(
              "Cart is empty...",
              style: TextStyle(color: Colors.black),
            ))
          : Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    "Total:-\$$newPrice",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return MyCartListTile(
                        productModel: item,
                        onTapDecrement: () {
                          context.read<ProductProvider>().decrementCount(item);
                        },
                        onTapIncrement: () {
                          context.read<ProductProvider>().incrementCount(item);
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 22.0, left: 10, right: 10),
                  child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xFF219ebc))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckOutHomeScreen(),
                                ));
                          },
                          child: Text(
                            "Proceed",
                            style: GoogleFonts.getFont('Poppins',
                                fontSize: 20, color: Colors.white),
                          ))),
                )
              ],
            ),
    );
  }
}
