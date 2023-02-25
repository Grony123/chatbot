import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'register.dart';
import 'home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:
  DefaultFirebaseOptions.currentPlatform);
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Page'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        resizeToAvoidBottomInset : false,
        body: const Form(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class Form extends StatefulWidget {
  const Form({Key? key}) : super(key: key);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool emailValidator = false;
  bool passValidator = false;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bool goToNextScreen = true;

    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 170.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                labelText: 'Email',
                errorText: emailValidator ?'Value can\'t be empty!' : null,
              ),
            ),
            const SizedBox(height: 15.0),
            TextField(
              controller: _pass,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                labelText: 'password',
                errorText: passValidator ? 'Value can\'t be empty!' : null,
              ),
            ),
            const SizedBox(height: 60.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _email.text.isEmpty ? emailValidator = true : emailValidator = false;
                    _pass.text.isEmpty ? passValidator = true : passValidator = false;
                  });
                  try {
                    UserCredential userCreds = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email.text,
                        password: _pass.text,
                    );
                  } on FirebaseAuthException catch(e) {
                      if (e.code == 'user-not-found') {
                        const snackBar = SnackBar(
                          content: Text('User not Found!!'),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (e.code == 'wrong-password') {
                        const snackBar = SnackBar(
                          content: Text('Wrong password provided for that user!'),
                          duration: Duration(seconds: 1),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      goToNextScreen = false;
                    }
                    if (goToNextScreen) {
                      String mail = _email.text;
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home(name: '', email: mail))
                      );
                      _email.text = "";
                      _pass.text = "";
                    }
                  },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      )
                  )),
                child: const Text(
                  ' Login ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) => const Register()
                  ));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )
                    )),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


