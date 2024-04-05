import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../components/alert_manager.dart';

class DetailsScreen extends StatefulWidget {
  final String productId;
  final String productName;
  final String actualPrice;
  final String discountedPrice;
  final String discountPercentage;
  final String rating;
  final String ratingCount;
  final String imagePath;

  const DetailsScreen(
      {super.key, required this.productId, required this.productName, required this.actualPrice, required this.discountedPrice, required this.discountPercentage, required this.rating, required this.ratingCount, required this.imagePath});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  String productId = '';
  String productName = '';
  String actualPrice = '';
  String discountedPrice = '';
  String discountPercentage = '';
  String rating = '';
  String ratingCount = '';
  String imagePath = '';
  String predictedPrice = '';

  @override
  void initState() {
    super.initState();
    productId = widget.productId;
    productName = widget.productName;
    actualPrice = widget.actualPrice;
    discountedPrice = widget.discountedPrice;
    discountPercentage = widget.discountPercentage;
    rating = widget.rating;
    ratingCount = widget.ratingCount;
    imagePath = widget.imagePath;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://lucasdennis.pythonanywhere.com/forgot_password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'discounted_price': discountedPrice,
          'discount_percentage': discountPercentage,
          'rating': rating,
          'rating_count': ratingCount,
        }),
      );


      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          predictedPrice = data['predicted_price'];
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            fadeInDuration: Duration(milliseconds: 500),
                            fadeOutDuration: Duration(milliseconds: 500),
                            imageUrl:
                            imagePath,
                            width: MediaQuery
                                .sizeOf(context)
                                .width * 0.9,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                    child: Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 36,
                    thickness: 1,
                    color: Color(0xFFE0E3E7),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Base Price',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '\$$actualPrice',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rating',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                250, 0, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  rating,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                  size: 24,
                                ),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Rating Count',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          ratingCount,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Predicted Price',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '\$$predictedPrice',
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w600,
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
        ],
      ),
    );
  }
}
