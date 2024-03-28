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
  final String price;
  final String rating;

  ProductItem({required this.product_id, required this.product_name, required this.price, required this.rating});

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
                .push(createRoute(DetailsScreen(product_id: product_id,)));
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
                        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1760&q=80',
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
                            child: AutoSizeText(
                              '$rating',
                              textAlign: TextAlign.start,
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
                          '\$$price',
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
        product_id: item['id'],
        product_name: item['name'],
        price: item['price'],
        rating: item['rating'],
      ));
    }

    return ProductList(items: items);
  }
}

class DashboardScreen extends StatefulWidget {


  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  ProductList? products;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {

    try {
      final response = await http.get(Uri.parse('http://your_django_api_url/dashboard'));


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
      bottomNavigationBar: BottomBar(context, 0),
    );
  }
}
