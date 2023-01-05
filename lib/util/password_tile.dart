import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vault_007_3/database/database.dart';
import 'package:vault_007_3/model/passwords.dart';
import 'package:vault_007_3/model/crypto.dart';
import 'package:vault_007_3/app/update_password_screen.dart';

class PasswordTile extends StatefulWidget {
  const PasswordTile({
    super.key,
    required this.password,
    required this.isarService
  });

  final Passwords password;
  final IsarService isarService;

  @override
  State<PasswordTile> createState() => PasswordTileState();
}

class PasswordTileState extends State<PasswordTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UpdatePassword(isarService: widget.isarService, currentPassword: widget.password,),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // border: Border.all(color: const Color(0xffA6C8FF)),
            color: const Color.fromRGBO(27, 28, 28, 1),
            borderRadius: BorderRadius.circular(16.0),
          ),

          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text(
                    widget.password.serviceName.toString()[0].toUpperCase(),
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: Column(
              children: [
                Center(
                  child: Text(widget.password.serviceName.toString().replaceFirst(widget.password.serviceName.toString()[0], widget.password.serviceName.toString()[0].toUpperCase()), style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Color(0xffffffff),
                    ),
                  ),
                  ),
                ),
                const Divider(
                  color: Color(0xfff1f1f1),
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Color(0xffffffff),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpdatePassword(isarService: widget.isarService, currentPassword: widget.password,),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xffFFB4A3),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                              'Confirm Delete',
                              style: GoogleFonts.poppins(),
                          ),
                          content: Text(
                              'Are you sure you want to delete ${widget.password.serviceName} password?',
                              style: GoogleFonts.poppins(),
                          ),
                          actions: <Widget>[
                            FilledButton.tonal(
                              child: Text(
                                  'Cancel',
                                  style: GoogleFonts.poppins(),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FilledButton.tonal(
                              child: Text(
                                  'Delete',
                                   style: GoogleFonts.poppins(),
                              ),
                              onPressed: () {
                                setState(() {
                                  widget.isarService.deletePassword(widget.password.id);
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                    color: Color(0xffffffff),
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: Crypto().decryptMyData(widget.password.password.toString())))
                        .then((result) {
                      Fluttertoast.showToast(
                        msg: "${widget.password.serviceName}'s Password Copied to Clipboard!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: const Color(0xffEFB8C8),
                        textColor: const Color(0xff492532),
                        timeInSecForIosWeb: 1,
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 14.0,
                      );
                    });
                  },
                ),
              ],
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}