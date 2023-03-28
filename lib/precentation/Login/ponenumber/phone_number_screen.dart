import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ScreenPhoneNumber extends StatelessWidget {
  const ScreenPhoneNumber({super.key});
  static String phoneNumber = '';
  static String verify = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/Mobile-login-Cristina.jpg'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: Text(
                  "You will get a 4 -digit code to verify next",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'IN',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (phone) {
                    phoneNumber = phone.completeNumber;
                    print(phone.completeNumber);
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: phoneNumber,
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        verify = verificationId;
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const ScreenOtp())
                        //  );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );

                    // log(phoneNumber);
                  },
                  child: Text(
                    'Send the code',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
