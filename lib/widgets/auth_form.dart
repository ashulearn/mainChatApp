import '../pickers/users_image_picket.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  AuthForm(this.submitFn,this.isLoading);

  final void Function(String email, String password, String userName,File image,
      bool idLogin, BuildContext ctx) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  
  String _userEmail = "";
  String _userId = "";
  String _userPassword = "";
  File _userImageFile;
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(_userImageFile==null && !_isLogin)
    {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("please pick an image")));
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userId.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }
  void _pickedImage(File image)
  {
    _userImageFile=image;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if(!_isLogin)  UserImagePicker(_pickedImage),
                TextFormField(
                  key: ValueKey("email"),
                  validator: (value) {
                    if (value.isEmpty || !value.contains("@")) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email address"),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey("userid"),
                    validator: (value) {
                      if (value.isEmpty || (value.length <= 4)) {
                        return "Please enter at least 4 char";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userId = value;
                    },
                    decoration: InputDecoration(labelText: "User Name"),
                  ),
                TextFormField(
                  key: ValueKey("password"),
                  validator: (value) {
                    if (value.isEmpty || (value.length <= 7)) {
                      return "Please enter at least 7 charcters";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(
                  height: 12,
                ),
                if(widget.isLoading) CircularProgressIndicator(),
                if(!widget.isLoading)
                RaisedButton(
                    child: Text(!_isLogin ? "Signup" : "Login"),
                    onPressed: _trySubmit),
                if(!widget.isLoading)
                FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(!_isLogin
                        ? "I alredy have an account"
                        : "Create an Account"),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
