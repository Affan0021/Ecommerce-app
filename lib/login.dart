import 'package:flutter/material.dart';
import 'main.dart';
import 'package:email_validator/email_validator.dart';

import 'twitter auth.dart';

//
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
 final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  @override

  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    var height = query.size.height;
    var width = query.size.width;

    return Scaffold(
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Stack(children: <Widget>[


      // To have bacground image

      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: Colors.white,

        child: DecoratedBox(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage('assets/back.jpg'), fit: BoxFit.fill),
          ),
        ),
       ),
      Column(
        children: [
          //
          SizedBox(
              height: height / 10,
          ),

          Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: MediaQuery.of(context).size.width / 1.79,
              height: MediaQuery.of(context).size.height / 3.7,
              color: Colors.transparent,
               child: Image.asset(
                'assets/bakk.png',
              ),
           ),

          //
          SizedBox(
              height: height / 45,
          ),
          buildEmail(),
          const SizedBox(height: 32),
          buildPassword(),
          const SizedBox(height: 32),
          buildSubmit(),


          SizedBox(
              height: height / 40,
          ),

          Row(
              children: [
                SizedBox(
                  width: width / 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 7,
                  height: MediaQuery.of(context).size.height / 12,
                  // color: Colors.blueGrey,
                  child: Image.asset(
                    'assets/google.png',
                  ),
                ),
                SizedBox(
                  width: width / 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 9,
                  height: MediaQuery.of(context).size.height / 12,
                  // color: Colors.blueGrey,
                  child: Image.asset(
                    'assets/phone.png',
                  ),
                ),
                SizedBox(
                  width: width / 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 11,
                  // color: Colors.blueGrey,
                   child: IconButton(
                      icon: Image.asset('assets/twitter.png'),
                      iconSize: 50,

                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Twitter()),
                        );


                      },
                    )
                ),


                SizedBox(
                  width: width / 28,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 10,
                  // color: Colors.blueGrey,
                  child: Image.asset(
                    'assets/facebook.png',
                  ),
                ),
              ],
          ),

          SizedBox(
              height: height / 40,
          ),

          Row(
              children: [
                SizedBox(
                  width: width / 6,
                ),
                Container(
                  // margin:EdgeInsets.only(left: 100),
                  child: Text(
                    'Create an account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: width / 115,
                ),
                Container(
                    child: TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Signup()),
                    // );
                  },
                  child: Text(
                    '\tSign up',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
              ],
          ),

        ],
      )
    ]),
            )));


  }

  Widget buildEmail() =>  TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: 'OpenSans',
      ),
    decoration: InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          // width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      // contentPadding: const EdgeInsets.only(top: 11.0),
      prefixIcon: Icon(
        Icons.email,
        color: Colors.blue,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      labelText: 'Email',
      hintStyle: TextStyle(
        color: Colors.blueGrey, // <-- Change this
        fontSize: 17,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),


    ),

    validator: (value) {
      final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
      final regExp = RegExp(pattern);

      if (value!.isEmpty) {
        return 'Enter an email';
      } else if (!regExp.hasMatch(value)) {
        return 'Enter a valid email';
      } else {
        return null;
      }
    },
    keyboardType: TextInputType.emailAddress,
    onSaved: (value) => setState(() => email = value!),



  );

  Widget buildPassword() => TextFormField(
    // cursorWidth: 20,

    // maxLines:  5,

    decoration: InputDecoration(
      contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          // width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      // contentPadding: const EdgeInsets.only(top: 11.0),
      prefixIcon: Icon(
        Icons.lock,
        color: Colors.blue,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      labelText: 'Password',
      hintStyle: TextStyle(
        color: Colors.blueGrey, // <-- Change this
        fontSize: 17,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),


    ),

    validator: (value) {
      if (value!.length < 7) {
        return 'Password must be at least 7 characters long';
      } else {
        return null;
      }
    },
    onSaved: (value) => setState(() => password = value!),
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
  );

  Widget buildSubmit() => Builder(
    builder: (context) => ButtonWidget(
      text: 'Submxxit',
      onClicked: () {
        final isValid = formKey.currentState!.validate();
         FocusScope.of(context).unfocus();

        if (isValid) {
          formKey.currentState!.save();

          final message =
              'Username: $username\nPassword: $password\nEmail: $email';
          final snackBar = SnackBar(
            content: Text(
              message,
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    ),
  );
}







class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(

      width: MediaQuery.of(context).size.width / 1.3,
      height: MediaQuery.of(context).size.height / 15,

      child:ElevatedButton(
    onPressed: onClicked,

    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return Colors.red;
          return Colors.blue;
        },
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
           )),
    ),
    child: Text(
      '\tSign in ',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
     )
  );
}
