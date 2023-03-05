import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:vault_007_3/app/home_page.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _authenticate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        setState(() {
          _auth = false;
        });
        // print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        setState(() {
          _authenticate();
        });
        // print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        setState(() {
          _auth = false;
        });
        break;
      case AppLifecycleState.detached:
        // print('appLifeCycleState detached');
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final LocalAuthentication auth = LocalAuthentication();

  bool _isAuthenticating = false;
  bool _auth = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to view your Passwords',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            sensitiveTransaction: true,
          ));
      if(authenticated) {
        setState(() {
          _auth = true;
        });
      }
      else {
        setState(() {
          _auth = false;
        });
      }
      setState(() {
        _isAuthenticating = false;

      });
    } on PlatformException {
      setState(() {
        _isAuthenticating = false;
        _auth = false;
      });
      return;
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _auth
          ? HomePage()
          : Scaffold(
              backgroundColor: Colors.black,
              body: CustomScrollView(
                slivers: [
                  // AppBar
                  SliverAppBar.large(
                    floating: false,
                    pinned: true,
                    snap: false,
                    centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        "Vault007",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(color: Color(0xffe3e3e3)),
                        ),
                      ),
                    ),
                  ),

                  // rest of the UI
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/image_4.webp",width: 320,),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffA6C8FF),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 16.0, 16.0),
                              child: Text(
                                "You Need to authenticate to move forward!",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color(0xff003060),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        FloatingActionButton.extended(
                          onPressed: _authenticate,
                          label: Text(
                            "Try Again",
                            style: GoogleFonts.poppins(),
                          ),
                          icon: const Icon(Icons.update),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
