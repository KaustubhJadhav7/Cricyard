
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../data/models/product_model.dart';
import '../provider/product_data_provider.dart';

class MyCartListTile extends StatelessWidget {
 final ProductModel productModel;
 final void Function()? onTapIncrement;
 final void Function()? onTapDecrement;
  const MyCartListTile({super.key,required this.productModel,required this.onTapDecrement,required this.onTapIncrement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
              borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Image.network(productModel.image.toString())),
                )),
            const SizedBox(width: 6,),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex :3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("${productModel.name}",style: const TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black),),
                             Text("\$${productModel.price}",style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black87),),
                           ],
                         ),
                          Row(
                            children: [
                              InkWell(
                                onTap:onTapDecrement,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(Icons.remove,color:Colors.grey[700],),
                                ),
                              ),
                              const SizedBox(width: 6,),
                              Consumer<ProductProvider>(builder: (context, value, child) {
                               return Text("${value.count}");
                              },),
                              const SizedBox(width: 6,),
                              InkWell(
                                onTap: onTapIncrement,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(Icons.add,color:Colors.black),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: IconButton(onPressed: (){
                        context.read<ProductProvider>().removeItem(productModel);
                      }, icon: const Icon(Icons.delete,color: Colors.red,)),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
