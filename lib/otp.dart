
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:login_full/welcome_Login.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'home.dart';


class Search extends StatefulWidget {

  var title , code;
  Search({ this.title  });


  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
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


  Widget build(BuildContext context) {

    var query = MediaQuery.of(context);
    var height = query.size.height;
    // var container = height;
    var width =  query.size.width;

    return Scaffold(
        key: _scaffoldkey,
        body: SingleChildScrollView(
            child: Stack(
              //      Column(
                children: [

                  Container(
                    margin:  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height,
                    // decoration:   BoxDecoration(
                    //   image:  const DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image: AssetImage('user/log.jpg'),
                    //
                    //   ),
                    //
                    // ),

                  ),


                  Column(

                    children: [

                      SizedBox(
                        height: height/5,
                      ),

                      Container(
                        margin:  const EdgeInsets.fromLTRB(0, 0, 130,0),
                        width: MediaQuery.of(context).size.width/2,
                        height: MediaQuery.of(context).size.height/10,
                        color: Colors.transparent,
                        child: const Text(
                          'Enter\nPincode',
                          style: TextStyle(

                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,


                          ),


                        ),


                      ),



                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 100, 0, 0),

                        child: PinPut(
                          fieldsCount: 6,
                          withCursor: true,

                          textStyle: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.red,
                          ),
                          eachFieldWidth: 30.0,
                          eachFieldHeight: 60.0,
                          fieldsAlignment: MainAxisAlignment.spaceEvenly,
                          // onSubmit: (String pin) => _showSnackBar(p
                          focusNode: _pinPutFocusNode,
                          controller: _pinPutController,
                          submittedFieldDecoration: pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          selectedFieldDecoration: pinPutDecoration.copyWith(color: Colors.tealAccent),
                          followingFieldDecoration: pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),
                          pinAnimationType: PinAnimationType.fade,

                          onSubmit: (pin) async {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(PhoneAuthProvider.credential(
                                  verificationId: _verificationCode, smsCode: pin))
                                  .then((value) async {
                                if (value.user != null) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => Home()),
                                          (route) => false);
                                }
                              });
                            } catch (e) {
                              FocusScope.of(context).unfocus();
                              _scaffoldkey.currentState!
                                  .showBottomSheet((context) => Container(
                                color: Colors.red,
                                child : Text('wrong code'),
                              ));
                            }
                          },
                        ),


                      ),


                    ],
                  )

                ]

            )
        )

    );
  }



  _verifyPhone() async
  {
    await FirebaseAuth.instance.verifyPhoneNumber(

        phoneNumber: '${widget.title}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                      (route) => false);
            }
            else
            {
              print('not logged in');
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }


  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }

}
