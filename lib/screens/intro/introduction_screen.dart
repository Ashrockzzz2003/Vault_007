import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaultzerozeroseven_marktwo/screens/home.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  void saveIntroScreen() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("seenIntro", true);
  }

  final introContent = {
    1: {
      "description": "Passwords at your fingertips.\nSafe and secure with Vault 007",
      "image": "assets/intro_1.webp",
      "title": "Vault 007"
    },
    2: {
      "description": "Enhanced security with biometric authentication",
      "image": "assets/image_2.webp",
      "title": "Secure Biometrics"
    },
    3: {
      "description": "Generate strong and unique passwords with ease",
      "image": "assets/image_3.webp",
      "title": "Password Generator"
    },
    4: {
      "description": "Seamless access to your passwords anytime, anywhere",
      "image": "assets/image_4.webp",
      "title": "Access on the Go"
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  children: List.generate(
                      introContent.length,
                      (int index) => Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                    introContent[index + 1]!["image"]!),
                                const SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  introContent[index + 1]!["title"]!,
                                  style: GoogleFonts.raleway(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.merge(TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              fontWeight: FontWeight.w600))),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  introContent[index + 1]!["description"]!,
                                  style: GoogleFonts.raleway(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ))),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(introContent.length,
                        (int index) => _buildDots(index: index)),
                  ),
                  _currentPage + 1 == introContent.length
                      ? Padding(
                          padding: const EdgeInsets.all(32),
                          child: FilledButton.tonal(
                            onPressed: () {
                              saveIntroScreen();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomeScreen()),
                                      (route) => false);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(32, 24, 32, 24),
                              child: Text(
                                "Get Started",
                                style: GoogleFonts.raleway(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.merge(TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer))),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    _controller
                                        .jumpToPage(introContent.length - 1);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 16, 8, 16),
                                    child: Text(
                                      "Skip",
                                      style: GoogleFonts.raleway(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.merge(TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onErrorContainer))),
                                    ),
                                  )),
                              FilledButton.tonal(
                                onPressed: () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 16, 8, 16),
                                  child: Text("Next",
                                      style: GoogleFonts.raleway(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.merge(TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimaryContainer)))),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
