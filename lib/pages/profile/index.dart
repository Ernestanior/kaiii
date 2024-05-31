import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaino/components/squareTile/index.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _obscureText = true;
  bool remember = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.fromLTRB(10, 80, 10, 10),
        child: Scaffold(
          body: Column(
            children: [
              const Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_back,
                    color: Colors.blue,
                    size: 30,
                  )
                ],
              ),
              Container(
                width: 240,
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: 120,
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                        ),
                      ),
                      TextField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility))),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: remember,
                            onChanged: (e) {
                              setState(() {
                                remember = e as bool;
                              });
                            }),
                        Text('REMEMBER_ME'.tr)
                      ],
                    ),
                    GestureDetector(
                      child: Text(
                        'FORGOT_PASSWORD'.tr,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 350,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 113, 170, 216))),
                  child: Text('LOGIN'.tr),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('NO_ACCOUNT_YET'.tr),
                    Text('   '),
                    Text(
                      'SIGN_UP_HERE'.tr,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              Row(children: [
                SquareTile(imagePath: 'assets/google.png', onTap: () {})
              ])
            ],
          ),
        ));
  }
}
