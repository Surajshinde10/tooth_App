// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../utils/constant.dart';
//
// void main() {
//
//   runApp(DentistSalesGallery());
// }
//
// class DentalProduct {
//   final String id;
//   final String name;
//   final String image;
//   final double price;
//   final String category; // Add a category property
//
//   DentalProduct({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.price,
//     required this.category,
//   });
// }
//
//
// class Order {
//   final String productId;
//   final String productName;
//   final String productImage;
//   late final int quantity;
//
//   Order({
//     required this.productId,
//     required this.productName,
//     required this.productImage,
//     required this.quantity,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'productId': productId,
//       'productName': productName,
//       'productImage': productImage,
//       'quantity': quantity,
//     };
//   }
// }
//
// class DentistSalesGallery extends StatelessWidget {
//
//   List<Order> cartItems = [];
//
//   final List<DentalProduct> dentalProducts = [
//     DentalProduct(id: '1', name: 'Toothpaste', image: 'assets/toothpaste (2).png',price: 2.99, category: 'aass'),
//     DentalProduct(id: '2', name: 'Toothbrush', image: 'assets/brush.png',price: 1.49, category: 'ass'),
//     DentalProduct(id: '3', name: 'Dental Floss', image: 'assets/floss.png',price: 4.2, category: 'aaxx'),
//
//   ];
//
//
//
//
//   double calculateTotalPrice(double price, int quantity) {
//     // Replace with your logic to calculate the total price
//     return price * quantity;
//   }
//
//   DentistSalesGallery({ Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//
//           backgroundColor: kScaffoldBackground,
//           //appbar//
//           appBar: AppBar(
//
//             backgroundColor: kDoctorCard1,
//             title: Center(child: Text('Dentist Sales Gallery',style: TextStyle(color: primary,fontSize: 16,fontWeight: FontWeight.bold),)),
//             actions: [   Icon(
//               Icons.shopping_cart,
//               size: 35,
//               color: Colors.black54,
//             ),],
//           ),
//           //body//
//           body:
//
//
//           SingleChildScrollView(
//             child: Column(
//               children: [
//
//                 Container(
//                   decoration: BoxDecoration(color: kScaffoldBackground),
//
//                   height: MediaQuery.of(context).size.height/4.1,
//                   child:
//                   CarouselSlider(
//                     options: CarouselOptions(
//                       height: MediaQuery.of(context).size.height / 3,
//                       autoPlay: true,
//                       aspectRatio: 1.0,
//                       enlargeCenterPage: true,
//                       enableInfiniteScroll: false,
//                       initialPage: 0,
//                     ),
//                     items: dentalProducts.map((product) {
//                       return GestureDetector(
//                         onTap: () {
//                           // Handle the tap on a product.
//                           // You can navigate to a new screen or display a list of related products here.
//                           // For example, let's navigate to a screen that shows related products.
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => RelatedProductsScreen(product: product, allProducts: dentalProducts, )
//                             ),
//                           );
//                         },
//                         child: Card(
//                           color: kScaffoldBackground,
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10),
//                                 child: Container(
//                                   color: kDoctorCard1,
//                                   height: MediaQuery.of(context).size.height / 4.5,
//                                   width: MediaQuery.of(context).size.width / 0,
//                                   child: Image.asset(
//                                     product.image,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   )
//
//                 ),
//
//                 SizedBox(height: 20,),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.start,
//                 //   children: [
//                 //     Text("Categories",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//                 //   ],
//                 // ),
//                 // SizedBox(height: 20,),
//                 //
//                 // Container(
//                 //   height: MediaQuery.of(context).size.height / 1,
//                 //   width: MediaQuery.of(context).size.width/0.8,
//                 //   child: GridView.builder(
//                 //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 //       crossAxisCount: 2,
//                 //       crossAxisSpacing: 10,
//                 //       mainAxisSpacing: 10,
//                 //     ),
//                 //     itemCount: dentalProducts.length,
//                 //     itemBuilder: (context, index) {
//                 //       final product = dentalProducts[index];
//                 //       return GestureDetector(
//                 //         onTap: () {
//                 //           // _showProductDetails(context, product);
//                 //         },
//                 //         child: Card(
//                 //           color: kScaffoldBackground,
//                 //           child: Column(
//                 //             mainAxisAlignment: MainAxisAlignment.center,
//                 //             children: [
//                 //               Padding(
//                 //                 padding: const EdgeInsets.all(8.0),
//                 //                 child: Image.asset(
//                 //                   product.image,
//                 //                   // width: 100,
//                 //                   // height: 100,
//                 //                   fit: BoxFit.contain,
//                 //                 ),
//                 //               ),
//                 //               const SizedBox(height: 8),
//                 //               Text(
//                 //                 product.name,
//                 //                 style: const TextStyle(fontSize: 16),
//                 //               ),
//                 //             ],
//                 //           ),
//                 //         ),
//                 //       );
//                 //     },
//                 //   ),
//                 // ),
//
//
//               ],
//             ),
//           )
//
//       ),
//     );
//   }
//
//
//
//   void _addToCart(DentalProduct product, int quantity) {
//     // Save the order to Firestore
//     CollectionReference ordersCollection =
//     FirebaseFirestore.instance.collection('orders');
//
//     Order order = Order(
//       productId: product.id,
//       productName: product.name,
//       productImage: product.image,
//       quantity: quantity,
//     );
//
//     ordersCollection.add(order.toMap());
//   }
// }
//
// class RelatedProductsScreen extends StatelessWidget {
//   final DentalProduct product;
//   final List<DentalProduct> allProducts;
//
//
//   RelatedProductsScreen({required this.product, required this.allProducts, });
//
//
//   @override
//   Widget build(BuildContext context) {
//     // Define a list to store related products
//     List<DentalProduct> relatedProducts = [];
//
//     // Filter related products based on the tapped product's category
//     relatedProducts.addAll(allProducts
//         .where((item) => item.category == product.category)
//         .toList());
//
//     // Add additional filtering criteria or logic here to include more related products
//     // For example, you can add products with similar prices, different brands, etc.
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Related Products'),
//       ),
//       body: ListView.builder(
//         itemCount: relatedProducts.length,
//         itemBuilder: (context, index) {
//           final relatedProduct = relatedProducts[index];
//           return ListTile(
//             leading: Image.asset(relatedProduct.image),
//             title: Text(relatedProduct.name),
//             subtitle: Text('\$${relatedProduct.price.toStringAsFixed(2)}'),
//             onTap: () {
//               // Handle the tap on a related product if needed.
//             },
//           );
//         },
//       ),
//     );
//   }
// }
// class ShoppingCart {
//   List<Order> items = [];
//
//   void addToCart(DentalProduct product) {
//     // Check if the product is already in the cart
//     bool isAlreadyInCart = items.any((item) => item.productId == product.id);
//
//     if (!isAlreadyInCart) {
//       items.add(Order(
//         productId: product.id,
//         productName: product.name,
//         productImage: product.image,
//         quantity: 1,
//       ));
//     } else {
//       // If the product is already in the cart, increase its quantity
//       var existingItem = items.firstWhere((item) => item.productId == product.id);
//       existingItem.quantity++;
//     }
//   }
// }













// class ProductListScreen extends StatelessWidget {
//   final List<DentalProduct> dentalProducts;
//
//   ProductListScreen({required this.dentalProducts});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product List'),
//       ),
//       body: ListView.builder(
//         itemCount: dentalProducts.length,
//         itemBuilder: (context, index) {
//           final product = dentalProducts[index];
//           return ListTile(
//             leading: Image.asset(product.image),
//             title: Text(product.name),
//             trailing: IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () {
//                 // Add the product to the cart
//                 // You can call the _addToCart function here
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/constant.dart';

class DentistSalesGallery extends StatelessWidget {


  Future<void> uploadDentalProducts(List<DentalProduct> dentalProducts) async {
    CollectionReference dentalProductsCollection = FirebaseFirestore.instance.collection('dental_products');

    for (var product in dentalProducts) {
      await dentalProductsCollection.doc(product.id).set(dentalProductToMap(product));
    }
  }

  Map<String, dynamic> dentalProductToMap(DentalProduct product) {
    return {
      'id': product.id,
      'name': product.name,
      'image': product.image,
      'price': product.price,
      'category': product.category,
    };
  }


  final List<DentalProduct> dentalProducts = [
    DentalProduct(
      id: '1',
      name: 'Toothpaste',
      image: 'assets/toothpaste (2).png',
      price: 2.99,
      category: 'a',
    ),
    DentalProduct(
      id: '2',
      name: 'Toothbrush',
      image: 'assets/brush.png',
      price: 1.49,
      category: 'aNH',
    ),
    DentalProduct(
      id: '3',
      name: 'Dental Floss',
      image: 'assets/floss.png',
      price: 4.2,
      category: 'aaC',
    ),
    // Duplicate Toothpaste
    DentalProduct(
      id: '4',
      name: 'Toothpaste',
      image: 'assets/toothpaste (2).png',
      price: 2.99,
      category: 'a',
    ),
    DentalProduct(
      id: '5',
      name: 'Toothpaste',
      image: 'assets/toothpaste (2).png',
      price: 2.99,
      category: 'a',
    ),
  ];
  CollectionReference dentalProductsCollection = FirebaseFirestore.instance.collection('dental_products');


  DentistSalesGallery({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: kScaffoldBackground,

          appBar: AppBar(
            backgroundColor: kDoctorCard1,
            title: Center(child: Text('Dentist Sales Gallery',style: TextStyle(color: primary,fontSize: 16,fontWeight: FontWeight.bold),)),
            actions: [   Icon(
              Icons.shopping_cart,
              size: 35,
              color: Colors.black54,
            ),],
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                    decoration: BoxDecoration(color: kScaffoldBackground),

                    height: MediaQuery.of(context).size.height/4.1,
                    child:
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height / 3,
                        autoPlay: true,
                        aspectRatio: 1.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                      ),
                      items: dentalProducts.map((product) {
                        return GestureDetector(
                          onTap: () {
                            // Handle the tap on a product.
                            // You can navigate to a new screen or display a list of related products here.
                            // For example, let's navigate to a screen that shows related products.
                            uploadDentalProducts(dentalProducts);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => RelatedProductsScreen(product: product, allProducts: dentalProducts, )
                              ),
                            );
                          },
                          child: Card(
                            color: kScaffoldBackground,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    color: kDoctorCard1,
                                    height: MediaQuery.of(context).size.height / 4.5,
                                    width: MediaQuery.of(context).size.width / 0,
                                    child: Image.asset(
                                      product.image,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )

                ),

                SizedBox(height: 20,),


              ],
            ),
          )

      ),
    );
  }




}

class RelatedProductsScreen extends StatelessWidget {
  final DentalProduct product;
  final List<DentalProduct> allProducts;


  RelatedProductsScreen({required this.product, required this.allProducts, });


  @override
  Widget build(BuildContext context) {
    // Define a list to store related products
    List<DentalProduct> relatedProducts = [];

    // Filter related products based on the tapped product's category
    relatedProducts.addAll(allProducts
        .where((item) => item.category == product.category)
        .toList());

    // Add additional filtering criteria or logic here to include more related products
    // For example, you can add products with similar prices, different brands, etc.

    return Scaffold(
      appBar: AppBar(
        title: Text('Related Products'),
      ),
      body: ListView.builder(
        itemCount: relatedProducts.length,
        itemBuilder: (context, index) {
          final relatedProduct = relatedProducts[index];
          return ListTile(
            leading: Image.asset(relatedProduct.image),
            title: Text(relatedProduct.name),
            subtitle: Text('\$${relatedProduct.price.toStringAsFixed(2)}'),
            onTap: () {
              // Handle the tap on a related product if needed.
            },
          );
        },
      ),
    );
  }
}


class DentalProduct {
  final String id;
  final String name;
  final String image;
  final double price;
  final String category; // Add a category property

  DentalProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
  });
}


class Order {
  final String productId;
  final String productName;
  final String productImage;
  late final int quantity;

  Order({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'quantity': quantity,
    };
  }
}


