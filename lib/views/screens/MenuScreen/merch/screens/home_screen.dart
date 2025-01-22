import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/my_product_tile.dart';
import '../data/models/product_model.dart';
import '../provider/product_data_provider.dart';
import 'cart_screen.dart';
import 'details_screen.dart';

class ProductHomeScreen extends StatefulWidget {
  const ProductHomeScreen({Key? key}) : super(key: key);

  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  // ProductProvider productProvider = ProductProvider();

  @override
  void initState() {
    // TODO: implement initState
    // productProvider.getProduct();
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Build");
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.getProduct();
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ));
              },
              child: Consumer<ProductProvider>(
                builder: (context, provider, _) => Badge(
                  label: Text("${provider.cart.length}"),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Color(0xFF219ebc),
                  ),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color.fromARGB(255, 68, 67, 67),
        title: const Text(
          "Bat Shop",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(
                child: CircularProgressIndicator(color: Colors.grey[700]));
          } else {
            return ListView(
              children: [
                const SizedBox(height: 20),
                // search bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: TextField(
                      onChanged: (value) {
                        provider.search(value);
                      },
                      controller: searchController,
                      cursorColor: Colors.grey,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF219ebc),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        label: Text("Search... for your favourite bat"),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: Text(
                    "Popular premium products",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.searchedProducts.length,
                    itemBuilder: (context, index) {
                      ProductModel productModel =
                          provider.searchedProducts[index];
                      return ProductTile(
                        productModel: productModel,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                productModel: productModel,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
