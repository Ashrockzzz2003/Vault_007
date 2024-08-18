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
      backgroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.dark
              ? Colors.black
              : Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar.large(
            backgroundColor:
                Theme.of(context).colorScheme.brightness == Brightness.dark
                    ? Colors.black
                    : Theme.of(context).colorScheme.surface,
            floating: false,
            pinned: true,
            snap: false,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "About",
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromRGBO(27, 28, 28, 1)
                        : Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const CircleAvatar(
                        foregroundImage: AssetImage(
                          "assets/logo_v1.png",
                        ),
                        radius: 64.0,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Vault 007",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Version 3.0.0",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              fontSize: 16,
                              color:
                                  Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Team",
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        fontSize: 32,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(16.0),
                  onTap: () {
                    launchUrl(
                      Uri.parse("https://ashrockzzz2003.github.io/portfolio/"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          foregroundImage: AssetImage(
                            "assets/dev_image.jpeg",
                          ),
                          radius: 32.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ashwin Narayanan S",
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface,
                                ),
                              ),
                            ),
                            Text(
                              "Amrita Vishwa Vidyapeetham",
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer),
                              ),
                            ),
                            Text(
                              "Coimbatore, Tamil Nadu",
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            ),
                            Chip(
                              padding: const EdgeInsets.all(1),
                              backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Theme.of(context).colorScheme.surface,
                              elevation: 3,
                              label: Text(
                                "Developer",
                                style: GoogleFonts.raleway(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface,
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(16.0),
                  onTap: () {
                    launchUrl(
                      Uri.parse(
                          "https://www.linkedin.com/in/rohith-m-profilein/"),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1.0,
                      ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rohith M",
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            ),
                            Text(
                              "Amrita Vishwa Vidyapeetham",
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer),
                              ),
                            ),
                            Text(
                              "Coimbatore, Tamil Nadu",
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            ),
                            Chip(
                              padding: const EdgeInsets.all(1),
                              backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .brightness ==
                                      Brightness.dark
                                  ? Colors.black
                                  : Theme.of(context).colorScheme.surface,
                              elevation: 3,
                              label: Text(
                                "Logo Designer",
                                style: GoogleFonts.raleway(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface,
                                    textStyle: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
