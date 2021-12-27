import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);


  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();




  // firebase work
  var Email , Password , Username , Phone;
  late String _email, _password;
  final auth = FirebaseAuth.instance;


  getEmail(email)
  {
    this.Email = email;
  }
  getPassword(age)
  {
    this.Password = age;
  }
  getUsername(username)
  {
    this.Username = username;
  }
  getPhone(phone)
  {
    this.Phone = phone;
  }

  createData()
  {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Users").doc(Username);

    Map<String,dynamic> students=
    {
      "UserEmail": Email,
      "UserPassword": Password,
      "Username": Username,
      "UserPhone": Phone,



    };
    documentReference.set(students).whenComplete(() {
      print("user created");
    });

  }



  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    var height = query.size.height;
    var width = query.size.width;
    return Scaffold(

        key: _scaffoldkey,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Stack(children: <Widget>[


            // To have bacground image

            Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery
                .of(context)
                .size
                .height,
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

         child:  Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            SizedBox(
            height: height / 10,
          ),

          Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            width: MediaQuery
                .of(context)
                .size
                .width / 1.79,
            height: MediaQuery
                .of(context)
                .size
                .height / 3.7,
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
              SizedBox(
                height: height / 45,
              ),
          buildPassword(),
              SizedBox(
                height: height / 45,
              ),
          buildUsername(),
              SizedBox(
                height: height / 45,

              ),
          buildPhone(),
              SizedBox(
                height: height / 45,
              ),
          // buildsigninauth(),
             buildsignauth(),
        ]
         )
        )

        ]
    )))
    );
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
  } );
      },

    validator: (value) {
      final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
      final regExp = RegExp(pattern);

      if (value!.isEmpty) {
        return 'Enter an email';
      } else if (!regExp.hasMatch(value)) {
        return 'Enter a valid email';
      } else {
        print(value);
        return getEmail(value);
      }
    },
    keyboardType: TextInputType.emailAddress,
    onSaved: (value) => setState(() => email = value!),

      )
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
        return getPassword(value);
      }
    },
    onSaved: (value) => setState(() => password = value!),
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
  ));

  Widget buildUsername() => Container(

      width: MediaQuery.of(context).size.width/1.2,

      child:TextFormField(
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
        Icons.people,
        color: Colors.blue,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      labelText: 'Username',
      hintStyle: TextStyle(
        color: Colors.blueGrey, // <-- Change this
        fontSize: 17,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),


    ),

    validator: (value) {
      if (value!.length < 4) {
        return 'Enter at least 4 characters';
      } else {
        return getUsername(value);

      }
    },
    maxLength: 30,
    onSaved: (value) => setState(() => username = value!),
  ));


  Widget buildPhone() => Container(

      width: MediaQuery.of(context).size.width/1.2,

    child:  TextFormField(
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
        Icons.phone,
        color: Colors.blue,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      labelText: 'Phone',
      hintStyle: TextStyle(
        color: Colors.blueGrey, // <-- Change this
        fontSize: 17,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),


    ),

    validator: (value) {
      if (value!.length < 11) {
        return 'Enter at least 11 digits';
      } else {
        return getPhone(value);

      }
    },
    maxLength: 11,
    onSaved: (value) => setState(() => username = value!),
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
          createData();
          auth.createUserWithEmailAndPassword(
              email: _email, password: _password).then((_) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Login()));
          }
          );
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
          '\tSign  2',
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
  //   builder: (context) => ButtonWidget(
  //     text: 'Submxxit',
  //     onClicked: () {
  //       final isValid = formKey.currentState!.validate();
  //       FocusScope.of(context).unfocus();
  //
  //       if (isValid) {
  //         formKey.currentState!.save();
  //
  //       //   final message =
  //       //       'Username: $username\nPassword: $password\nEmail: $email';
  //       //   final snackBar = SnackBar(
  //       //     content: Text(
  //       //       message,
  //       //       style: TextStyle(fontSize: 20),
  //       //     ),
  //       //     backgroundColor: Colors.green,
  //       //   );
  //       //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //         createData();
  //
  //       }
  //     },
  //   ),
  //
  //
  // );
}
//
// class ButtonWidget extends StatelessWidget {
//   final String text;
//   final VoidCallback onClicked;
//
//   const ButtonWidget({
//     Key? key,
//     required this.text,
//     required this.onClicked,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) =>
//       Container(
//
//           width: MediaQuery
//               .of(context)
//               .size
//               .width / 1.8,
//           height: MediaQuery
//               .of(context)
//               .size
//               .height / 18,
//
//           child: ElevatedButton(
//              onPressed: onClicked,
//
//
//
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                     (Set<MaterialState> states) {
//                   if (states.contains(MaterialState.pressed))
//                     return Colors.red;
//                   return Colors.blue;
//                 },
//               ),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                   )),
//             ),
//             child: Text(
//               '\tSign up ',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontFamily: 'OpenSans',
//                 fontSize: 25.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           )
//       );
//
//
// }
