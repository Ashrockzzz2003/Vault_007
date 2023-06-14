import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultzerozeroseven_marktwo/db/database.dart';
import 'package:vaultzerozeroseven_marktwo/model/passwords.dart';
import 'package:vaultzerozeroseven_marktwo/util/custom_tile.dart';

class PasswordSearchDelegate extends SearchDelegate {
  PasswordSearchDelegate({required this.isarService});
  final IsarService isarService;

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchScreen(
      isarService: isarService,
      query: query,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchScreen(
      isarService: isarService,
      query: query,
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen(
      {super.key, required this.isarService, required this.query});
  final IsarService isarService;
  final String query;

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final StreamController<List<Passwords>> _searchResultsController =
      StreamController();

  @override
  void dispose() {
    _searchResultsController.close();
    super.dispose();
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.brightness == Brightness.dark
              ? Colors.black
              : Theme.of(context).colorScheme.background,
      body: StreamBuilder<List<Passwords>>(
        stream: widget.isarService.listenToSearch(widget.query),
        builder: (context, s) {
          if (s.hasError) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    child: Text(
                      "Something Went Wrong...\nTry again later.\n${s.error}",
                      style: GoogleFonts.raleway(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.errorContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )),
            );
          }
          if (s.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Searching Passwords ... ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                      fontSize: 16,
                    )),
                  )
                ],
              ),
            );
          } else if (s.data!.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Theme.of(context).colorScheme.onErrorContainer
                          : Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                      child: Text(
                        "No matching passwords found.",
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(context).colorScheme.errorContainer
                              : Theme.of(context).colorScheme.onErrorContainer,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
            );
          } else {
            return ListView.builder(
              controller: controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: s.data!.length,
              itemBuilder: (_, i) {
                return buildPasswords(context, s.data![i], s.data!.length, i);
              },
            );
          }
        },
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
