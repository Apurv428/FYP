import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_order_app/screen/home_page.dart';
import 'package:food_order_app/screen/widgets/text_field.dart';
import 'package:food_order_app/services/signUpServices.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController signupName = TextEditingController();
  TextEditingController signupRegId = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupPassword = TextEditingController();

  bool _isObscure = true;

  User? currentUser = FirebaseAuth.instance.currentUser;
  final globalScaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void validation() {
    if (signupPassword.text.trim().isEmpty) {
      globalScaffoldKey.currentState?.showSnackBar(const SnackBar(
        content: Text("Password is empty"),
        duration: Duration(seconds: 3),
      ));
      return;
    }
  }

  void signUp(BuildContext context) async {
    validation();
    var userName = signupName.text.trim();
    var userId = signupRegId.text.trim();
    var userEmail = signupEmail.text.trim();
    var userPassword = signupPassword.text.trim();

    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      // ignore: use_build_context_synchronously
      await signUpUser(userName, userId, userEmail, userPassword, context);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(userEmail),
      ));
    } catch (e) {
      globalScaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text("Error creating user: $e"),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'CANTEEN HUB',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: Image.asset('images/signup.png'),
              ),
              const SizedBox(height: 40),
              const Text(
                'SIGN UP',
                style: TextStyle(
                  color: Color(0xFF001F3F),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                hintText: "Name",
                obscureText: false,
                controller: signupName,
                prefixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              MyTextField(
                hintText: "Reg Id",
                obscureText: false,
                controller: signupRegId,
                prefixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: signupEmail,
                prefixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              MyTextField(
                hintText: "Password",
                obscureText: _isObscure,
                controller: signupPassword,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    signUp(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFFFAB317),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
