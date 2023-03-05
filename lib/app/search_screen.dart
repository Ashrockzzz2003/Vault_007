import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vault_007_3/database/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vault_007_3/model/passwords.dart';
import 'package:vault_007_3/util/password_tile.dart';

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
  const SearchScreen({super.key, required this.isarService, required this.query});
  final IsarService isarService;
  final String query;

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final StreamController<List<Passwords>> _searchResultsController = StreamController();

  @override
  void dispose() {
    _searchResultsController.close();
    super.dispose();
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<List<Passwords>>(
        stream: widget.isarService.listenToSearch(widget.query),
        builder: (context, s) {
          if (s.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xffA6C8FF),
              ),
            );
          } else if (s.data!.isEmpty) {
            return Padding(
              padding:
              const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 5.0),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: const Color(0xffEFB8C8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      16.0, 16.0, 16.0, 16.0),
                  child: Text(
                    "No Passwords found!\nClick on + icon to Add new Password",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color(0xff492532),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
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
                return buildPasswords(context, s.data![i]);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildPasswords(BuildContext context, Passwords password) {
    return PasswordTile(
      password: password,
      isarService: widget.isarService,
    );
  }
}