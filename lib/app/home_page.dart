import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vault_007_3/database/database.dart';
import 'package:vault_007_3/app/add_new_password_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vault_007_3/model/passwords.dart';
import 'package:vault_007_3/util/password_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final isarService = IsarService();

  late ScrollController controller = ScrollController();

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddPassword(
                    isarService: widget.isarService,
                  ),
                ),
              ),
          label: Text(
            "New Password",
            style: GoogleFonts.poppins(),
          ),
          icon: const Icon(Icons.add)),
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
            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddPassword(
                      isarService: widget.isarService,
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.add,
                  color: Color(0xffe3e3e3),
                ),
              )
            ],
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.security,
                color: Color(0xffe3e3e3),
              ),
            ),
          ),

          // rest of the UI
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: const Color(0xffA6C8FF),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                        child: Text(
                          "Create, save and manage your passwords and easily sign in to sites and apps.",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color(0xff003060),
                              fontSize: 16,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                StreamBuilder<List<Passwords>>(
                  stream: widget.isarService.listenToPasswords(),
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
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
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
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ],
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
