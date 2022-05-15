import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:raven/home_screen.dart';
import 'package:raven/models/message_model.dart';
import 'package:raven/models/user_model.dart';
import 'package:snapshot/snapshot.dart';

import 'firebase_options.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String otp;
  late String verificationId, smsCode;
  late Auth.FirebaseAuth firebaseAuth;
  late BuildContext context;
  late String phoneNumber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    WidgetsBinding.instance.addPostFrameCallback((_) => firebaseInit());
  }

  Future<void> firebaseInit() async {
    // if (Firebase.apps.length == 0) {
    //   // await Firebase.initializeApp(
    //       // options: DefaultFirebaseOptions.currentPlatform);
    // } // Firebase.initializeApp().onError((error, stackTrace) => (error));

    // FirebaseApp secondaryApp = Firebase.app('raven (ios)');
    // FirebaseDatabase database = FirebaseDatabase.instanceFor(app: secondaryApp);

    User user = User(id: 001, name: 'name', imageUrl: 'imageUrl');
    Message message = Message(
        sender: user, time: 'time', text: 'text', isLiked: true, unread: true);
    if (!kIsWeb) {
      // ignore: unrelated_type_equality_checks

      if (Platform.isMacOS) {
        await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform);

        FirebaseFirestore.instance
            .collection('testing')
            .doc('Desktop')
            .collection('macOs')
            .add({'Name': 'Raven1', 'DOB': 1999});

        var db = FirebaseFirestore.instance;

        await db.collection("testing").get().then((event) {
          for (var doc in event.docs) {
            print("${doc.id} => ${doc.data()}");
            var v = doc.get('Name');
            print(v);
          }
        });
        DatabaseReference ref = FirebaseDatabase.instance.ref("raven (macOS)");
        await ref
            .child(Timeline.now.toString())
            .set({'user': message.toJson(message)})
            .onError((error, stackTrace) => error.toString())
            .then((value) => value);
      } else if (Platform.isAndroid) {
        await Firebase.initializeApp();

        FirebaseFirestore.instance
            .collection('testing')
            .doc('Mobile')
            .collection('Android')
            .add({'Name': 'Raven1', 'DOB': 1999});

        var db = FirebaseFirestore.instance;

        await db.collection("testing/Mobile/Android").get().then((event) {
          for (var doc in event.docs) {
            print("${doc.id} => ${doc.data()}");
            var v = doc.get('Name');
            print(v);
          }
        });
        DatabaseReference ref =
            FirebaseDatabase.instance.ref("raven (Android)");

        await ref
            .child(Timeline.now.toString())
            .set({'user': message.toJson(message)})
            .onError((error, stackTrace) => error.toString())
            .then((value) => value);
      } else if (Platform.isIOS) {
        await Firebase.initializeApp();

        FirebaseFirestore.instance
            .collection('testing')
            .doc('Mobile')
            .collection('iOS')
            .add({'Name': 'Raven1', 'DOB': 1999});

        var db = FirebaseFirestore.instance;
        await db.collection("testing/Mobile/iOS").get().then((event) {
          for (var doc in event.docs) {
            print("${doc.id} => ${doc.data()}");
            var v = doc.get('Name');
            print(v);
          }
        });
        // var ios = DefaultFirebaseOptions.ios;
        DatabaseReference ref = FirebaseDatabase.instance.ref("raven (iOS)");

        await ref
            .child(Timeline.now.toString())
            .set({'user': message.toJson(message)})
            .onError((error, stackTrace) => error.toString())
            .then((value) => value);

        final getRef = FirebaseDatabase.instance.ref("raven (iOS)");
        final snapshot = await ref.get();
        if (snapshot.exists) {
          var decoder = SnapshotDecoder()
            ..register<Map<String, dynamic>, Message>(
                (v) => Message.fromJson(v));

          Map m = jsonDecode(jsonEncode(snapshot.value));

          // log(m['17873075840'].toString());
        } else {
          print('No data available.');
          // }
        }
      }
    } else {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);

      // var auth = Auth.FirebaseAuth.instance;

      // Auth.ConfirmationResult confirmationResult;
      // confirmationResult = await auth.signInWithPhoneNumber('+91 7283844571');
      // log(confirmationResult.verificationId.toString());
      // Auth.UserCredential userCredential;

      // userCredential = await confirmationResult.confirm('683767');
      // confirmationResult = await auth.signInWithPhoneNumber(
      //     '+91 7283844571',
      //     Auth.RecaptchaVerifier(
      //       container: 'recaptcha',
      //       size: Auth.RecaptchaVerifierSize.compact,
      //       theme: Auth.RecaptchaVerifierTheme.dark,
      //     ));
      // Auth.RecaptchaVerifier(
      //   onSuccess: () => print('reCAPTCHA Completed!'),
      //   onError: (Auth.FirebaseAuthException error) => print(error),
      //   onExpired: () => print('reCAPTCHA Expired!'),
      // );

      ;
      ;

      // await auth.verifyPhoneNumber(
      //   phoneNumber: '+91 7283844571',
      //   verificationCompleted: (Auth.PhoneAuthCredential credential) {},
      //   verificationFailed: (Auth.FirebaseAuthException e) {
      //     log(e.code.toString());
      //   },
      //   codeSent: (String verificationId, int? resendToken) {},
      //   codeAutoRetrievalTimeout: (String verificationId) {},
      // );
      FirebaseFirestore.instance
          .collection('testing')
          .doc('web')
          .collection('web')
          .add({'Name': 'Raven3', 'DOB': 1999});

      var db = FirebaseFirestore.instance;

      await db.collection("testing/web/web").get().then((event) {
        for (var doc in event.docs) {
          print("${doc.id} => ${doc.data()}");
          var v = doc.get('Name');
          print(v);
        }
      });
      DatabaseReference ref = FirebaseDatabase.instance.ref("raven (Web)");

      User user = User(id: 001, name: 'name', imageUrl: 'imageUrl');
      Message message = Message(
          sender: user,
          time: 'time',
          text: 'text',
          isLiked: true,
          unread: true);

      // await ref
      //     .child(Timeline.now.toString())
      //     .set({'user': message.toJson(message)});
    }
  }

  Future<void> sendOtp() async {
    if (Platform.isIOS) {
      firebaseAuth = await Auth.FirebaseAuth.instance;

      if (phoneNumberController.text.isEmpty) {
        showAlertDialog(context, 'Error', 'Please enter a phone number');
      } else {
        firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (Auth.PhoneAuthCredential credential) {
            // log(credential.toString());
          },
          verificationFailed: (Auth.FirebaseAuthException e) {
            // log(e.code.toString());
            showToast(e.code);
            if (e.code.contains('quota')) {
              showToast('Please try again after some time');
            }
            else{
              showToast(e.code);
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            this.verificationId = verificationId.toString();
            showToast('OTP is sent to $phoneNumber');
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            showToast('Time out please try again');
          },
        );
      }
    }
  }

  Future<void> verifyOtp() async {
    if (Platform.isIOS || Platform.isAndroid) {
      
      if (otpController.text.isEmpty) {
        showAlertDialog(context, 'Error', 'Please enter the OTP');
      } else {
        if (otpController.text.isNotEmpty) {
          smsCode = otpController.text;

          Auth.PhoneAuthCredential credential =
              Auth.PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: smsCode);

          await firebaseAuth
              .signInWithCredential(credential)
              .whenComplete(() => {
                    showToast('Signed up successfully'),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()))
                  })
              .catchError(showToast('Please enter a valid OTP') as Function);
        }
      }
    }
  }

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: ListView(),
                ),
                Row(
                  children: [
                    Flexible(
                      child: InternationalPhoneNumberInput(
                        textFieldController: phoneNumberController,
                        onInputChanged: (PhoneNumber phoneNumber) {
                          this.phoneNumber = phoneNumber.phoneNumber!;
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        spaceBetweenSelectorAndTextField: 0,
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: PhoneNumber(
                            isoCode:
                                'IN'), //enter country code for the default value
                        formatInput: false,
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputBorder: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(onPressed: sendOtp, child: Text('Send OTP')),
                SizedBox(height: 30, width: 30, child: ListView()),
                Column(
                  children: [
                    AbsorbPointer(
                      absorbing: false,
                      child: PinCodeTextField(
                        enabled: true,
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        hintCharacter: '0',
                        hintStyle: TextStyle(
                          color: const Color(0x36000000),
                        ),
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(8),
                          borderWidth: 0,
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          activeColor: Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        controller: otpController,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => verifyOtp(),
                        child: Container(
                          child: TextButton(
                            onPressed: verifyOtp,
                            child: Text('Verify the OTP',
                                style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 0.688,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

showAlertDialog(BuildContext context, String title, String errorMessage) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(errorMessage),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
