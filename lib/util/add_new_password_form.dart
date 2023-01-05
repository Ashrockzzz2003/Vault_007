import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vault_007_3/model/auto_generate_password.dart';
import 'package:vault_007_3/model/passwords.dart';
import 'package:vault_007_3/database/database.dart';
import 'package:vault_007_3/model/crypto.dart';

class AddPasswordForm extends StatefulWidget {
  const AddPasswordForm({Key? key, required this.isarService}) : super(key: key);

  final IsarService isarService;

  @override
  AddPasswordFormState createState() => AddPasswordFormState();
}

class AddPasswordFormState extends State<AddPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String hint = "";
  final _titleNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _hintController = TextEditingController();

  // AutoGenerate
  int _selectedIndex = 0;
  final List<String> _options = ["I have a password", "Autogenerate"];

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

  // Add Data
  _addData() {
    setState(() {
      final newPassword = Passwords()
        ..serviceName = _titleNameController.text
        ..userName = _userNameController.text
        ..password = Crypto().encryptMyData(_passwordController.text);


      _titleNameController.clear();
      _userNameController.clear();
      _hintController.clear();
      _passwordController.clear();

      widget.isarService.createPassword(newPassword);
    });
    Navigator.of(context).pop();
    // print("[LOG]: Data added successfully");
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
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              autofocus: true,
              cursorColor: const Color(0xff4285F4),
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
                labelText: "Site or App name",
                labelStyle: TextStyle(
                  color: Color(0xffCAC4D0),
                ),
                floatingLabelStyle: TextStyle(
                  color: Color(0xff4285F4),
                ),
                helperText: "The site/app for which you are storing the password.\neg. Facebook, Instagram, Google...",
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
              cursorColor: const Color(0xff4285F4),
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  color: Color(0xffe3e3e3),
                ),
              ),
              obscureText: false,
              controller: _userNameController,
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
                labelText: "Username",
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildChips(),
          ),
          if(_selectedIndex == 0) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                cursorColor: const Color(0xff4285F4),
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
                cursorColor: const Color(0xff4285F4),
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Color(0xffe3e3e3),
                  ),
                ),
                controller: _hintController,
                onChanged: (String hintDone) {
                  if(hintDone == ""){
                    setState(() {
                      hint = "";
                      _passwordController.clear();
                    });
                  }
                  else{
                    setState(() {
                      hint = hintDone;
                      _passwordController.text = AutoGeneratePassword(hint: hint).generatePassword();
                    });
                  }
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
                  cursorColor: const Color(0xff4285F4),
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
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff4285F4)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff4285F4)),
                    ),
                    disabledBorder: const OutlineInputBorder(
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
                      _addData();
                    }
                  },
                  child: Text(
                    'Add Password',
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