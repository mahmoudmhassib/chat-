
import 'package:chatfirebase/screens/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen( {super.key,});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> fbKey = GlobalKey<FormState>();
  TextEditingController controlName = TextEditingController();
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlPassword = TextEditingController();
  bool visible = true;


  authForm() async {
    final auth=FirebaseAuth.instance;
    String errorMessage='Error Occured';
    try {
      UserCredential    userCredential = await auth.createUserWithEmailAndPassword(
            email: controlEmail.text.trim(),
            password: controlPassword.text.trim()
        );
        FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'email': controlEmail.text.trim(),
          'username': controlName.text.trim(),
          'password': controlPassword.text.trim()
        });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
       errorMessage='The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
    errorMessage='The account already exists for that email.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage),backgroundColor: Colors.grey,));
    } catch (e) {
      print(e);
    }
  }

  void _submit() {
    final isValid = fbKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      fbKey.currentState!.save();
      authForm();
      Navigator.push(context, MaterialPageRoute(builder: (_)=>const SignInScreen()));
    }

    print(controlEmail.text.trim());
    print(controlPassword.text.trim());
  }

  @override
  void dispose() {
    controlName;
    controlEmail;
    controlPassword;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery
                  .of(context)
                  .size
                  .width * .05,
              right: MediaQuery
                  .of(context)
                  .size
                  .width * .05),
          child: SingleChildScrollView(
            child: Form(
              key: fbKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .02,
                  ),
                  const  Text(
                    'Log in',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 2),
                  ),
                  const Text(
                    'Get great experience with nectar',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color:  Color(0xFF7C7C7C),
                        height: 1.5),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.04,
                  ),
                  TextFormField(
                    key:const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty||!value.contains('@')) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (val)=>controlEmail.text=val!,
                    controller: controlEmail,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    showCursor: true,
                    //  cursorColor: ColorsData.basicColor,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 5),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.2),
                      hintText: 'Email Address',
                      hintStyle: const TextStyle(color: Color(0xFF7C7C7C),),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),


                    ),
                  ),

                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,
                  ),
                  TextFormField(
                    key:const ValueKey('username'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (val )=> controlName.text = val!,
                    controller: controlName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    showCursor: true,
                    //  cursorColor: ColorsData.basicColor,
                    decoration: InputDecoration(

                      contentPadding: const EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 5),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.2),
                      hintText: 'Username',
                      hintStyle: const TextStyle(color: Color(0xFF7C7C7C),),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),


                    ),
                  ),


                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,
                  ),
                  TextFormField(
                    key:const ValueKey('password'),
                    validator: (value) {
                      if (value!.contains(' ') || value.isEmpty) {
                        return 'Please enter correct password';
                      }
                      return null;
                    },
                    onSaved: (val)=>controlPassword.text=val!,
                    controller: controlPassword,
                    keyboardType: TextInputType.visiblePassword,
                    showCursor: true,
                    //cursorColor: ColorsData.basicColor,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 5),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.2),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Color(0xFF7C7C7C),),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        child: Icon(
                          visible
                              ? Icons.visibility_off_sharp
                              : Icons.visibility,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    obscureText: visible,
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,
                  ),

                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forget password?',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'fonts/Gilroy-Medium.ttf',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02,
                  ),
                  Center(
                      child: GestureDetector(
                        onTap: () {
                          _submit();
                          if (fbKey.currentState!.validate()) {
                            fbKey.currentState!.save();
                            // Do something with the validated data

                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * .03,
                            bottom: MediaQuery
                                .of(context)
                                .size
                                .height * .04,
                          ),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * .84,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * .06,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(19),
                          ),
                          child: const Center(
                            child: Text('Sign Up ', style:  TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w500),),
                          ),
                        ),
                      )
                  ),

                  TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>const SignInScreen()));}, child:const Text('I already have an acccount',style: TextStyle(color: Colors.greenAccent),))

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBoxDivider(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * .2,
      child: Divider(
        endIndent: MediaQuery
            .of(context)
            .size
            .width * .02,
        indent: MediaQuery
            .of(context)
            .size
            .width * .02,
        height: 5,
        color: Colors.grey.withOpacity(.3),
        thickness: 1,
      ),
    );
  }

  Text buildText(String txt, double size, Color col, double height,
      FontWeight fontWeight) =>
      Text(
        txt,
        style: TextStyle(
            fontSize: size, fontWeight: fontWeight, color: col, height: height),
      );
}
