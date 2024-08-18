import 'package:app_settings/app_settings.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaultzerozeroseven_marktwo/screens/home.dart';
import 'package:vaultzerozeroseven_marktwo/screens/intro/introduction_screen.dart';
import 'package:vaultzerozeroseven_marktwo/util/crypto.dart';

bool? seenIntro;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  seenIntro = sp.getBool("seenIntro") ?? false;
  Crypto().initKey();
  runApp(const MyApp());
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  static final _defaultLightColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.lightBlueAccent, brightness: Brightness.light);
  static final _defaultDarkColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.lightBlueAccent, brightness: Brightness.dark);

  Future<bool> checkIntro() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getBool("seenIntro") == null) {
      return false;
    }
    return sp.getBool("seenIntro")!;
  }

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  String _authorized = 'Not Authorized';
  late AppLifecycleState prevState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    _authenticate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print("[State]: $state, [Authorized]: $_authorized");
    }
    switch (state) {
      case AppLifecycleState.inactive:
        setState(() {
          _authorized = 'Not Authorized';
        });
        break;
      case AppLifecycleState.resumed:
        if(_authorized == "Not Authorized") {
          setState(() {
            _authorized = "Not Authorized";
          });
          _authenticate();
        }
        break;
      case AppLifecycleState.paused:
        setState(() {
          _authorized = 'Not Authorized';
        });
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access your passwords.',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ),
      );
      if (authenticated) {
        setState(() {
          _authorized = 'Authorized';
        });
      } else {
        setState(() {
          _authorized = 'Not Authorized';
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Vault 007",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
        ),
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme ?? _defaultDarkColorScheme),
        themeMode: ThemeMode.system,
        home: (_authorized == 'Authorized')
            ? (!seenIntro! ? const IntroductionScreen() : HomeScreen())
            : (_supportState == _SupportState.supported)
                ? Scaffold(
                    backgroundColor: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Colors.black
                        : Theme.of(context).colorScheme.surface,
                    body: CustomScrollView(
                      slivers: [
                        // AppBar
                        SliverAppBar.large(
                          floating: false,
                          pinned: true,
                          snap: false,
                          centerTitle: true,
                          backgroundColor:
                              Theme.of(context).colorScheme.brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Theme.of(context).colorScheme.surface,
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: Text(
                              "Vault007",
                              style: GoogleFonts.lato(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface,
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
                              Image.asset(
                                "assets/image_4.webp",
                                width: 320,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 5.0, 10.0, 0.0),
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 16.0, 16.0, 16.0),
                                    child: Text(
                                      "You need to authenticate to move forward",
                                      style: GoogleFonts.raleway(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.merge(
                                              TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer),
                                            ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              FilledButton.tonalIcon(
                                onPressed: _authenticate,
                                label: Text(
                                  "Authenticate",
                                  style: GoogleFonts.poppins(),
                                ),
                                icon: const Icon(Icons.security_rounded),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Scaffold(
                    backgroundColor: Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? Colors.black
                        : Theme.of(context).colorScheme.surface,
                    body: CustomScrollView(
                      slivers: [
                        // AppBar
                        SliverAppBar.large(
                          floating: false,
                          pinned: true,
                          snap: false,
                          centerTitle: true,
                          backgroundColor:
                              Theme.of(context).colorScheme.brightness ==
                                      Brightness.light
                                  ? Colors.black
                                  : Theme.of(context).colorScheme.surface,
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: Text(
                              "Vault007",
                              style: GoogleFonts.lato(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface),
                            ),
                          ),
                        ),

                        // rest of the UI
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/image_4.webp",
                                width: 320,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 5.0, 10.0, 0.0),
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 16.0, 16.0, 16.0),
                                    child: Text(
                                      "You need to setup authentication in your mobile settings to move forward.\nThis is for your own safety.",
                                      style: GoogleFonts.raleway(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.merge(
                                              TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer),
                                            ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              FilledButton.tonalIcon(
                                onPressed: () {
                                  AppSettings.openLockAndPasswordSettings();
                                },
                                label: Text(
                                  "Open Settings",
                                  style: GoogleFonts.poppins(),
                                ),
                                icon: const Icon(Icons.settings),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      );
    });
  }
}
