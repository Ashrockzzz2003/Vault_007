import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultzerozeroseven_marktwo/db/database.dart';
import 'package:vaultzerozeroseven_marktwo/model/passwords.dart';
import 'package:vaultzerozeroseven_marktwo/screens/about.dart';
import 'package:vaultzerozeroseven_marktwo/screens/user/new_password.dart';
import 'package:vaultzerozeroseven_marktwo/screens/user/search.dart';
import 'package:vaultzerozeroseven_marktwo/util/custom_tile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  final isarService = IsarService();
  final ScrollController controller = ScrollController();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.dark
              ? Colors.black
              : Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.onSecondaryContainer
            : Theme.of(context).colorScheme.onSecondaryContainer,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewPasswordScreen(
                isarService: widget.isarService,
              ),
            ),
          );
        },
        label: Text(
          "New Password",
          style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.primaryContainer),
        ),
        icon: Icon(
          Icons.add_rounded,
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
      body: CustomScrollView(
        slivers: [
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
                "Vault007",
                style: GoogleFonts.lato(
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: PasswordSearchDelegate(
                          isarService: widget.isarService),
                    );
                  },
                  icon: const Icon(Icons.search_rounded))
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AboutScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.temple_hindu_rounded,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: <Widget>[
              Image.asset(
                "assets/image_3.webp",
                width: 240,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.onSecondaryContainer,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    child: Text(
                      "Create, store, and manage your passwords securely, experience seamless sign-ins.",
                      style: GoogleFonts.raleway(
                        textStyle: Theme.of(context).textTheme.bodyLarge?.merge(
                              TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
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
              StreamBuilder<List<Passwords>>(
                stream: widget.isarService.listenToPasswords(),
                builder: (context, s) {
                  if (s.hasError) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.onErrorContainer,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 16.0, 16.0, 16.0),
                            child: Text(
                              "Something Went Wrong...\nTry again later.\n${s.error}",
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    );
                  } else if (s.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Fetching your saved Passwords...",
                            style: GoogleFonts.raleway(
                                textStyle: const TextStyle(
                              fontSize: 16,
                            )),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  } else if (s.data!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? Theme.of(context).colorScheme.onErrorContainer
                                : Theme.of(context).colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 16.0, 16.0, 16.0),
                            child: Text(
                              "No passwords found.\nAdd your password by clicking on 'New Password'.",
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Theme.of(context)
                                        .colorScheme
                                        .errorContainer
                                    : Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    );
                  } else {
                    return ListView.builder(
                      controller: controller,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: s.data!.length,
                      itemBuilder: (_, i) {
                        return buildPasswords(
                            context, s.data![i], s.data!.length, i);
                      },
                    );
                  }
                },
              ),
              const SizedBox(
                height: 96,
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget buildPasswords(
      BuildContext context, Passwords password, int totalLength, int i) {
    if (totalLength == 1) {
      return CustomListTile(
        password: password,
        isarService: widget.isarService,
        isOnlyOne: true,
        isFirst: false,
        isLast: false,
      );
    } else if (i == totalLength - 1) {
      return CustomListTile(
        password: password,
        isarService: widget.isarService,
        isOnlyOne: false,
        isFirst: false,
        isLast: true,
      );
    } else if (i == 0) {
      return CustomListTile(
          isarService: widget.isarService,
          password: password,
          isFirst: true,
          isLast: false,
          isOnlyOne: false);
    }
    return CustomListTile(
      password: password,
      isarService: widget.isarService,
      isOnlyOne: false,
      isFirst: false,
      isLast: false,
    );
  }
}
