import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemsExpandableContainer extends StatefulWidget {
  const ItemsExpandableContainer({super.key});

  @override
  _ItemsExpandableContainerState createState() => _ItemsExpandableContainerState();
}

class _ItemsExpandableContainerState extends State<ItemsExpandableContainer> {
  bool _isExpanded = false;

  final List<Map<String, dynamic>> _items = [
    {
      "name": "Item 1",
      "imageUrl": "https://cdn11.bigcommerce.com/s-3954e/images/stencil/1280x1280/products/13011/23986/IMG-20230201-WA0002-removebg-preview__52504.1676055757.jpg?c=2",
      "quantity": 1,
      "price": 100,
    },
    {
      "name": "Item 2",
      "imageUrl": "https://cdn11.bigcommerce.com/s-3954e/images/stencil/1280x1280/products/13011/23986/IMG-20230201-WA0002-removebg-preview__52504.1676055757.jpg?c=2",
      "quantity": 2,
      "price": 200,
    },
    {
      "name": "Item 3",
      "imageUrl": "https://cdn11.bigcommerce.com/s-3954e/images/stencil/1280x1280/products/13011/23986/IMG-20230201-WA0002-removebg-preview__52504.1676055757.jpg?c=2",
      "quantity": 3,
      "price": 300,
    },
    {
      "name": "Item 4",
      "imageUrl": "https://cdn11.bigcommerce.com/s-3954e/images/stencil/1280x1280/products/13011/23986/IMG-20230201-WA0002-removebg-preview__52504.1676055757.jpg?c=2",
      "quantity": 4,
      "price": 400,
    },
    {
      "name": "Item 5",
      "imageUrl": "https://cdn11.bigcommerce.com/s-3954e/images/stencil/1280x1280/products/13011/23986/IMG-20230201-WA0002-removebg-preview__52504.1676055757.jpg?c=2",
      "quantity": 5,
      "price": 500,
    },
    {
      "name": "Item 6",
      "imageUrl": "https://cdn11.bigcommerce.com/s-3954e/images/stencil/1280x1280/products/13011/23986/IMG-20230201-WA0002-removebg-preview__52504.1676055757.jpg?c=2",
      "quantity": 1,
      "price": 100,
    },
  ];

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
                "Items (${_items.length})",
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
        if (_isExpanded)
          ..._items.map((item) => _itemDetails(
            item["name"],
            item["imageUrl"],
            item["quantity"],
            item["price"],
          )),
        const SizedBox(height: 10),
        const Divider(color: Colors.grey),
      ],
    );
  }

  Widget _itemDetails(String name, String imageUrl, int quantity, int price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(imageUrl,fit:BoxFit.cover ,)),
              ),
            ),
            const SizedBox(width: 10,),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: GoogleFonts.getFont('Poppins', fontWeight: FontWeight.w500,color: Colors.black,fontSize: 17)),
                    Text("Qty: $quantity", style: GoogleFonts.getFont('Poppins',color: Colors.grey,fontSize: 12)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Text("\$$price", style: GoogleFonts.getFont('Poppins', fontWeight: FontWeight.w500,color: Colors.black,fontSize: 17)),
            ),
          ],
        ),
      ),
    );
  }
}
