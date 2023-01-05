import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vault_007_3/model/auto_generate_password.dart';
import 'package:vault_007_3/model/passwords.dart';
import 'package:vault_007_3/database/database.dart';
import 'package:vault_007_3/model/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdatePasswordForm extends StatefulWidget {
  const UpdatePasswordForm({Key? key, required this.isarService, required this.currentPassword}) : super(key: key);

  final IsarService isarService;
  final Passwords currentPassword;

  @override
  UpdatePasswordFormState createState() => UpdatePasswordFormState();
}

class UpdatePasswordFormState extends State<UpdatePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String hint = "";
  final _titleNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _hintController = TextEditingController();

  // Fill With Original Data
  @override
  void initState() {
    _titleNameController.text = widget.currentPassword.serviceName!;
    _userNameController.text = widget.currentPassword.userName!;
    _passwordController.text = Crypto().decryptMyData(widget.currentPassword.password!);
    super.initState();
  }

  _updateData() {
    setState(() {
      widget.currentPassword.serviceName = _titleNameController.text;
      widget.currentPassword.userName = _userNameController.text;
      widget.currentPassword.password = Crypto().encryptMyData(_passwordController.text);
      widget.isarService.createPassword(widget.currentPassword);
    });
    // print("[LOG]: Data added successfully");
    Navigator.of(context).pop();
  }

  // AutoGenerate
  int _selectedIndex = 0;
  final List<String> _options = ["I have my password", "Autogenerate"];

  Widget _buildChips() {
    List<Widget> chips = [];
    for(int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: _selectedIndex == i?
        Text(
          _options[i],
          style: GoogleFonts.lato(
            textStyle: const TextStyle(color: Color(0xff003060)),
          ),
        )
            :
        Text(_options[i],
          style: GoogleFonts.lato(
            textStyle: const TextStyle(color: Color(0xffA6C8FF)),
          ),
        ),
        elevation: 3,
        pressElevation: 5,
        backgroundColor: Colors.black,
        selectedColor: const Color(0xffA6C8FF),
        onSelected: (bool selected) {
          setState(() {
            if(selected){
              _selectedIndex = i;
            }
          });
        },
      );
      chips.add(choiceChip);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: chips,
    );
  }

  // Validate Helper Function
  String? _fieldValidator(String? value) {
    if(value == null || value.isEmpty) {
      return 'Field can\'t be empty!';
    }
    return null;
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Site or App Name",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Color(0xffe3e3e3),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Color(0xffe3e3e3),
                ),
              ),
              obscureText: false,
              controller: _titleNameController,
              validator: _fieldValidator,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffe3e3e3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff4285F4)),
                ),
                labelText: "Title",
                labelStyle: TextStyle(
                  color: Color(0xffCAC4D0),
                ),
                floatingLabelStyle: TextStyle(
                  color: Color(0xff4285F4),
                ),
                // helperText: "eg. Google, Facebook, Instagram...",
                errorStyle: TextStyle(
                  color: Color(0xff601410),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff601410)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff4285F4)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Color(0xffe3e3e3),
                ),
              ),
              obscureText: false,
              controller: _userNameController,
              validator: _fieldValidator,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffe3e3e3)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff4285F4)),
                ),
                labelText: "Username",
                labelStyle: const TextStyle(
                  color: Color(0xffCAC4D0),
                ),
                floatingLabelStyle: const TextStyle(
                  color: Color(0xff4285F4),
                ),
                errorStyle: const TextStyle(
                  color: Color(0xff601410),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff601410)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff4285F4)),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                      Icons.copy,
                      color: Color(0xffffffff),
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _userNameController.text))
                        .then((result) {
                      Fluttertoast.showToast(
                        msg: "${_titleNameController.text}'s Username Copied to Clipboard!",
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: const Color(0xffEFB8C8),
                        textColor: const Color(0xff492532),
                        timeInSecForIosWeb: 1,
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 14.0,
                      );
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildChips(),
          ),
          if(_selectedIndex == 0) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                style: GoogleFonts.sourceCodePro(
                  textStyle: const TextStyle(color: Color(0xffe3e3e3)),
                ),
                obscureText: _isObscure,
                controller: _passwordController,
                validator: _fieldValidator,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe3e3e3)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4285F4)),
                  ),
                  labelText: "Password",
                  helperText: "Make sure that you are saving your current password",
                  labelStyle: const TextStyle(
                    color: Color(0xffCAC4D0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Color(0xff4285F4),
                  ),
                  errorStyle: const TextStyle(
                    color: Color(0xff601410),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff601410)),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4285F4)),
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: const Color(0xffe3e3e3),
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }
                  ),
                ),
              ),
            ),
          ]
          else ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Color(0xffe3e3e3),
                  ),
                ),
                controller: _hintController,
                onChanged: (String hintDone) {
                  setState(() {
                    hint = hintDone;
                    _passwordController.text = AutoGeneratePassword(hint: hint).generatePassword();
                  });
                },
                validator: _fieldValidator,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffe3e3e3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4285F4)),
                  ),
                  labelText: "Hint",
                  helperText: "Enter a Hint To Generate Password!",
                  labelStyle: TextStyle(
                    color: Color(0xffCAC4D0),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Color(0xff4285F4),
                  ),
                  errorStyle: TextStyle(
                    color: Color(0xff601410),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff601410)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4285F4)),
                  ),
                ),
              ),
            ),
            if(hint != "") ...[
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  enabled: false,
                  key: Key(hint),
                  obscureText: _isObscure,
                  validator: _fieldValidator,
                  style: GoogleFonts.sourceCodePro(
                    textStyle: const TextStyle(color: Color(0xffe3e3e3)),
                  ),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff4285F4)),
                    ),
                    labelText: "AutoGenerated Password",
                    floatingLabelStyle: const TextStyle(
                      color: Color(0xff4285F4),
                    ),
                    errorStyle: const TextStyle(
                      color: Color(0xff601410),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff601410)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff4285F4)),
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: const Color(0xffe3e3e3),
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }
                    ),
                  ),
                ),
              ),
            ],
          ],
          Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 24.0),
              child: SizedBox(
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      _updateData();
                    }
                  },
                  child: Text(
                    'Update Password',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(color: Color(0xff003060)),
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}