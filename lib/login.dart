import 'package:flutter/material.dart';
import 'facebook auth.dart';
import 'google auth.dart';
import 'home.dart';
import 'main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'otp.dart';
import 'phone.dart';
import 'signup.dart';
import 'twitter auth.dart';

//
class Login extends StatefulWidget {
  // const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
 final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  var count;
  @override
  TextEditingController _emailTEC = TextEditingController();
  //var _email;
  var phone;
  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phone =internationalizedPhoneNumber;
      print(phone);


    });
  }
  var _verificationCode;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  String userEmail = "hell";


  var Email , Password;


  getEmail(email)
  {
    this.Email = email;
  }
  getPassword(age)
  {
    this.Password = age;
  }

  createData()
  {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("My").doc(Email);

    Map<String,dynamic> students=
    {
      "UserEmail": Email,
      // "UserPassword": Password,
      // "studentPhone": studentPhone,



    };
    documentReference.set(students).whenComplete(() {
      print("user created");
    });

  }


  late String _email, _password;
  final auth = FirebaseAuth.instance;

  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    var height = query.size.height;
    var width = query.size.width;

    return Scaffold(
        key: _scaffoldkey,
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Stack(

                  children: <Widget>[


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
          Align(
              alignment: Alignment.center,

              child: Column(
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
          buildsignauth(),


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
                    'assets/twitter.png',
                  ),
                ),
                SizedBox(
                  width: width / 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 7.5,
                  height: MediaQuery.of(context).size.height / 11,
                  // color: Colors.blueGrey,
                    child: IconButton(
                      icon: Image.asset('assets/phone.png'),
                      // iconSize: 50,

                      onPressed: () {


                        // await signInWithGoogle();

                        // setState(() {});

                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => Phone()),
                      //   );

                        showDialog(context: context,
                          builder: (BuildContext context){
                            return SimpleDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),

                              ),

                              title: Row(
                                  children:[
                                    Image.asset('assets/phone.png',
                                      width: 40, height: 40, fit: BoxFit.contain, color: Colors.black,),
                                    Text('   Sign in with phone ',
                                      style: TextStyle(

                                          color: Colors.black,
                                          fontSize: 23,
                                          fontFamily: 'bold'
                                      ),
                                    )
                                  ]
                              ),


                            backgroundColor: Colors.teal,
                              children: [

                                Container(

                                  margin:EdgeInsets.fromLTRB(10, 20, 0, 0),

                                  child : InternationalPhoneInput(

                                    decoration: InputDecoration.collapsed(
                                      hintText: 'Enter your number',
                                      hintStyle: TextStyle(

                                        color: Colors.black26,
                                        fontSize: 18,
                                      ),

                                      // fillColor: Colors.brown,
                                    ),
                                    onPhoneNumberChange: onPhoneNumberChange,
                                    initialPhoneNumber: phone,
                                    initialSelection: 'PAK',
                                    enabledCountries: ['+92', '+1', '+91' , '90', '99', '97', '60', '70', '80'],
                                    showCountryCodes: true,

                                  ),
                                ),

                                SizedBox(
                                  height: height/30,
                                ),

                                Container(
                                    // width: MediaQuery.of(context).size.width/12,
                                    height: MediaQuery.of(context).size.height/25,
                                    margin: const EdgeInsets.only(left: 70.0, right: 70),
                                    child: ElevatedButton(
                                      onPressed: ()

                            {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Search(  title: phone,)),
                            );

                                                 },
                                      style: ButtonStyle(

                                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                            if (states.contains(MaterialState.pressed))
                                              return Colors.white;
                                            return Colors.indigoAccent;
                                          },
                                        ),
                                        shape:
                                        MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                side: BorderSide(
                                                    color: Colors.white)
                                            )
                                        ),

                                      ),

                                      child: Text(
                                        '\tSend ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'OpenSans',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                )



                              ],







                        );

                                }
                        );

                      },
                    )
                ),
                SizedBox(
                  width: width / 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 11,
                  // color: Colors.blueGrey,
                   child: IconButton(
                      icon: Image.asset('assets/google.png'),
                      iconSize: 50,

                      onPressed: () async{


                          await signInWithGoogle();

                          setState(() {});

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
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
                    child: IconButton(
                      icon: Image.asset('assets/facebook.png'),
                      iconSize: 50,

                      onPressed: () async{

                        await signInWithFacebook();

                        setState(() {});

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => LoginWithFacebook()),
                        // );
                      },
                    )
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );

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
      ))
    ]),
            )));


  }

  Widget buildEmail() => Container(

      width: MediaQuery.of(context).size.width/1.2,

      child:TextFormField(
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
        onChanged: (value) {
          setState(() {
            _email = value.trim();
          });
        },

        // onChanged: (String email)
        // {
        //   getEmail(email);
        //   print('email is send');
        //   print(email);
        // },

        validator: (value) {
          final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);

          if (value!.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            // count = 1;
            return null;
          }
        },

        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => setState(() => email = value!),


      ),

      // if(){
      //
      //   }
  );

  Widget buildPassword() => Container(

      width: MediaQuery.of(context).size.width/1.2,

      child:TextFormField(
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
            color: Colors.blueGrey,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),


        ),
        onChanged: (value) {
          setState(() {
            _password = value.trim();
          });
        },
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
      ));

  Widget buildsignauth() =>  Container(

      width: MediaQuery.of(context).size.width / 2.2,
      height: MediaQuery.of(context).size.height / 17,

      child:ElevatedButton(
        // onPressed: onClicked,
          onPressed: () {
            final isValid = formKey.currentState!.validate();
                   FocusScope.of(context).unfocus();



                  if (isValid) {
                    formKey.currentState!.save();

                  //  buildsignauth();

                  };
            auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
            });

          },


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
          '\tSign  ',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
  );



  // Widget buildSubmit() => Builder(
  //
  //
  //   builder: (context) => ButtonWidget(
  //     // text: 'Submxxit',
  //
  //     onClicked: () {
  //       final isValid = formKey.currentState!.validate();
  //        FocusScope.of(context).unfocus();
  //
  //
  //
  //       if (isValid) {
  //         formKey.currentState!.save();
  //
  //         buildsignauth();
  //
  //       }
  //     },
  //   ),
  //
  //
  // );


  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile', 'user_birthday']
    );

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    final userData = await FacebookAuth.instance.getUserData();

    userEmail = userData['email'];
    print(userEmail);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

 // paste
}






// class ButtonWidget extends StatelessWidget {
//   // final String text;
//   final VoidCallback onClicked;
//
//   const ButtonWidget({
//     Key? key,
//     // required this.text,
//     required this.onClicked,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => Container(
//
//       width: MediaQuery.of(context).size.width / 2.2,
//       height: MediaQuery.of(context).size.height / 17,
//
//       child:ElevatedButton(
//      onPressed: onClicked,
//
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.resolveWith<Color>(
//             (Set<MaterialState> states) {
//           if (states.contains(MaterialState.pressed))
//             return Colors.red;
//           return Colors.blue;
//         },
//       ),
//       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30.0),
//            )),
//     ),
//     child: Text(
//       '\tSign in ',
//       style: TextStyle(
//         color: Colors.white,
//         fontFamily: 'OpenSans',
//         fontSize: 25.0,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//      )
//   );
//
//
// }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!
        .authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

