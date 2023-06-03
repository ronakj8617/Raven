
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:raven/models/message_model.dart';
import 'package:raven/models/user_model.dart';

import 'global variables/api_keys.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String otp = '';
  late String verificationId = '', smsCode = '';
  late var userID = ID.unique();
  @override
  late BuildContext context;
  late String phoneNumber = '';

  late Client client;
  late var account;
  API_KEYS api_keys = API_KEYS();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsFlutterBinding.ensureInitialized();

    WidgetsBinding.instance.addPostFrameCallback((_) => appwriteInit());
  }

  Future<void> appwriteInit() async {
    User user = User(id: 001, name: 'name', imageUrl: 'imageUrl');
    Message message = Message(
        sender: user, time: 'time', text: 'text', isLiked: true, unread: true);

    client = Client()
        .setEndpoint(api_keys.endPoint) // Your API Endpoint
        .setProject(api_keys.project)
        .setSelfSigned(status: api_keys.selfSigned); // Your project ID

    account = Account(client);

    // final session = await account.createPhoneSession(
    //     userId: ID.unique(),
    //     phone: '$phoneNumber'
    //   );
  }

  Future<void> sendOtp() async {
    var x = 5;
  }

  Future<void> verifyOtp() async {
    final session = await account.createPhoneSession(
      userId: userID,
      phone: phoneNumber,
      otp: otpController.text,
    );

    // final session = await account.updatePhoneSession(
    //     userId: userID,
    //     secret: otpController.text
    //   );
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
                          var c = phoneNumberController.text;
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        spaceBetweenSelectorAndTextField: 0,
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: PhoneNumber(isoCode: 'IN'),
                        //enter country code for the default value
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputBorder: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(onPressed: sendOtp, child: const Text('Send OTP')),
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
                        hintStyle: const TextStyle(
                          color: Color(0x36000000),
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
                        animationDuration: const Duration(milliseconds: 300),
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
                            child: const Text('Verify the OTP',
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
    child: const Text("OK"),
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
