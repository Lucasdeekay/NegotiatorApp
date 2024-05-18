import 'package:flutter/material.dart';
import 'package:negotiator/components/alert_manager.dart';
import 'package:negotiator/pages/sign_in.dart';
import 'package:negotiator/pages/splash.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/bottom_nav.dart';
import '../components/greeting.dart';
import '../components/route_manager.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {

  String username = '';

  @override
  void initState() {
    super.initState();
    username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 36, 0, 6),
                      child: Text(
                        greeting(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Plus Jakarta Sans',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 6),
                      child: Text(
                        'Welcome $username',
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Plus Jakarta Sans',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.blueAccent,
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(18),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Thank you for supporting us!',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 6, 0, 0),
                                child: Text(
                                  'As a local business, we thank you for supporting us and hope you enjoy.',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 12, 0, 12),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                final response = await http.post(
                                  Uri.parse('https://www.priceprediction.com.ng/logout'),
                                  headers: {
                                    'Content-Type': 'application/json',
                                  },
                                );
                                Navigator.of(context).pushAndRemoveUntil(
                                  createRoute(SplashScreen()),
                                      (route) => false,
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.blueAccent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.logout,
                                        color:Colors.black54,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        18, 0, 0, 0),
                                    child: Text(
                                      'Log out',
                                      style: TextStyle(
                                        fontSize: 18.0,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(context, 1, username),
    );
  }
}
