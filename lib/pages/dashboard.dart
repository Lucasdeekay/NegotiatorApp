import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:negotiator/components/bottom_nav.dart';
import 'package:negotiator/components/route_manager.dart';
import 'package:negotiator/pages/details.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/alert_manager.dart';


class ProductItem extends StatelessWidget {
  final String product_id;
  final String product_name;
  final String actual_price;
  final String discounted_price;
  final String discount_percentage;
  final String rating;
  final String rating_count;
  final String predictedPrice;
  final String image_path;
  

  ProductItem({required this.product_id, required this.product_name, required this.actual_price, required this.discounted_price, required this.discount_percentage, required this.rating, required this.rating_count, required this.predictedPrice, required this.image_path});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            // Handle "Sign In" tap (e.g., navigate to sign in screen)
            Navigator.of(context)
                .push(createRoute(DetailsScreen(productId: product_id, productName: product_name, actualPrice: actual_price, discountedPrice: discounted_price, discountPercentage: discount_percentage, rating: rating, ratingCount: rating_count, predictedPrice: predictedPrice, imagePath: image_path)));
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow:  [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x411D2429),
                  offset: Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 1, 1, 1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        image_path,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          8, 8, 4, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            product_name,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Plus Jakarta Sans',
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(
                                0, 4, 8, 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                AutoSizeText(
                                  '$rating',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 4, 0, 0),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFF57636C),
                          size: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 12, 4, 8),
                        child: Text(
                          '\$$actual_price',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

class ProductList {
  final List<ProductItem> items;

  ProductList({required this.items});

  factory ProductList.fromJson(List<dynamic> json) {
    List<ProductItem> items = [];

    for (var item in json) {
      items.add(ProductItem(
        product_id: '${item['id']}',
        product_name: '${item['name']}',
        actual_price: '${item['actual_price']}',
        discounted_price: '${item['discounted_price']}',
        discount_percentage: '${item['discount_percentage']}',
        rating: '${item['rating']}',
        rating_count: '${item['rating_count']}',
        image_path: '${item['image_path']}',
        predictedPrice: '${item['predicted_price']}',
      ));
    }

    return ProductList(items: items);
  }
}

class DashboardScreen extends StatefulWidget {
  final String username;

  const DashboardScreen({super.key, required this.username});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String username = '';
  ProductList? products;

  @override
  void initState() {
    super.initState();
    fetchData();
    username = widget.username;
  }

  Future<void> fetchData() async {

    try {
      final response = await http.get(Uri.parse('https://www.priceprediction.com.ng/dashboard'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          products = ProductList.fromJson(data['products']);
        });
      } else {
        // Handle API error
        errorFlushbar(context, "Error", 'Failed to load product details');
      }
    } catch (e) {
      // Handle other errors
      errorFlushbar(context, "Error", '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 36, 16, 6),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Order Now',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Check out our products below',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              child: ListView(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  if (products == null || products!.items.isEmpty)
                    const Text('No product available')
                  else
                    Column(
                      children: products!.items,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(context, 0, username),
    );
  }
}
