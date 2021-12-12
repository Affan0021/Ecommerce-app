
import 'dart:async';

import 'package:flutter/material.dart';
// import 'code.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:international_phone_input/international_phone_input.dart';

import 'otp.dart';


class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);


  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
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

  Widget build(BuildContext context)
  {

    var query = MediaQuery.of(context);
    var height = query.size.height;
    // var container = height;
    var width =  query.size.width;

    return Scaffold(

        body: SingleChildScrollView(
            child: Stack(
              //      Column(
                children: [

                  Container(
                    margin:  const EdgeInsets.fromLTRB(0, 0, 0, 0),
//alignment: Alignment.center,

                    width: MediaQuery.of(context).size.width,
                    height:MediaQuery.of(context).size.height,
//                     decoration:   BoxDecoration(
// //   shape: BoxShape.circle,
//                       image:  const DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage('user/log.jpg'),
//
//                       ),
//
//
//                     ),

                  ),


                  Column(
                    children: [

                      SizedBox(
                        height: height/2.3,
                      ),


                      Container(
                        //alignment: Alignment.center,
                        margin:  const EdgeInsets.fromLTRB(40, 0, 0, 0),

                        width: MediaQuery.of(context).size.width/1.17,
                        height: MediaQuery.of(context).size.height/17,
                        decoration:   BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.transparent,
                                offset: const Offset(
                                  100.0,
                                  10.0,
                                ), //Offset
                                blurRadius: 4.0,
                                spreadRadius: 0.11,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.yellow,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ),
                              //BoxShadow
                            ],
                            border: Border.all(
                              color: Colors.transparent,
                              width: 4,
                            ),
                            borderRadius:  const BorderRadius.all(Radius.circular(10))
                        ),
                      ),




                    ],
                  ),



                  Column(
                    children: [


                      SizedBox(
                        height: height/6,
                      ),

                      Container(

                        margin:EdgeInsets.fromLTRB(50, 200, 0, 0),

                        child : InternationalPhoneInput(

                          decoration: InputDecoration.collapsed(
                            hintText: 'Enter your number',
                            hintStyle: TextStyle(

                              color: Colors.black,
                              fontSize: 20,
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
                        height: height/14,
                      ),

                      Container(
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.height/22,
                          margin: const EdgeInsets.only(left: 5.0),
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
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      )


                    ],
                  )



                ]
            )
        )
    );




  }
}