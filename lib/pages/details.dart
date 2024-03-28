import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../components/alert_manager.dart';

class DetailsScreen extends StatefulWidget {
  final String product_id;

  const DetailsScreen({super.key, required this.product_id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  String _product_id = '';
  String product_name = '';
  String price = '';
  String rating = '';
  String predicted_price = '';

  @override
  void initState() {
    super.initState();
    _product_id = widget.product_id;
    fetchData();
  }

  Future<void> fetchData() async {

    try {
      final response = await http.get(Uri.parse('http://your_django_api_url/?product_id=$_product_id'));


      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          product_name = data['product']['name'];
          price = data['product']['price'];
          rating = data['product']['rating'];
          predicted_price = data['predicted_price'];
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
                            'https://images.unsplash.com/photo-1515898913320-f38370edab7a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2929&q=80',
                            width: MediaQuery.sizeOf(context).width * 0.9,
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
                      product_name,
                      style: TextStyle(
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
                          style:TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '\$$price',
                          style:TextStyle(
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
                          style:TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(250, 0, 0, 0),
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
                          '\$$predicted_price',
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
