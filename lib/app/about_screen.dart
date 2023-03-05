import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                "About",
                style: GoogleFonts.raleway(
                  textStyle: const TextStyle(color: Color(0xffe3e3e3)),
                ),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xffe3e3e3),
              ),
            ),
          ),

          // rest of the UI
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    // border: Border.all(color: const Color(0xffA6C8FF)),
                    color: const Color.fromRGBO(27, 28, 28, 1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 24,),
                      const CircleAvatar(
                        foregroundImage: AssetImage(
                          "assets/logo/logo_v1.png",
                        ),
                        radius: 64.0,
                      ),
                      const SizedBox(height: 24,),
                      Text(
                        "Vault007",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 32,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        "Version 1.0",
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24,),
                      Text(
                        "All rights reserved",
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24,),
                Text(
                  "Developer",
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                InkWell(
                  onTap: () {
                    launchUrl(
                        Uri.parse("https://ashrockzzz2003.github.io/portfolio/"),
                        mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(27, 28, 28, 1),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          foregroundImage: AssetImage(
                            "assets/dev_image.jpeg",
                          ),
                          radius: 32.0,
                        ),
                        Column(
                          children: [
                            Text(
                              "Ashwin Narayanan S",
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                Text(
                  "Logo Designer",
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                InkWell(
                  onTap: () {
                    launchUrl(
                        Uri.parse("https://www.linkedin.com/in/rohith-m-profilein/"),
                        mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(27, 28, 28, 1),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          foregroundImage: AssetImage(
                            "assets/editor_image.jpeg",
                          ),
                          radius: 32.0,
                        ),
                        Column(
                          children: [
                            Text(
                              "Rohith M",
                              style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
