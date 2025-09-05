import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fioke/view/component/Input/TextfieldComponent.dart';
import 'package:fioke/network/api_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/logofioke.png',
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Text(
                        'Daftar ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff035F79),
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
               const SizedBox(height: 32),
              Center(
                child: Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(48, 8, 48, 8),
                  child: Column(
                    children: [
                      MakeTextfield(
                        text: "Nama",
                        icon: Icon(Icons.person),
                        controller: _name,
                        isPassword: false,
                      ),
                      const SizedBox(height: 18),
                      MakeTextfield(
                        text: "Email",
                        icon: Icon(Icons.mail),
                        controller: _email,
                        isPassword: false,
                      ),
                      const SizedBox(height: 18),
                      MakeTextfield(
                        text: "Password",
                        icon: Icon(Icons.lock),
                        controller: _password,
                        isPassword: true,
                      ),

                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed: () async {
                         try{
                             Response response = await ApiService().postData('api/register', {
                              "name" : _name.text.trim(),
                              "email": _email.text.trim(),
                              "password" : _password.text.trim()
                          });
                            if(response.statusCode == 200) {
                              Navigator.pushReplacementNamed(context, '/beranda');
                            }
                         }on DioException catch(e) {
                            if(e.response?.statusCode == 401){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email atau Password salah")));
                            }
                             if(e.response?.statusCode == 402){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("data gaboleh kosong / data tidak valid")));
                            } 
                            if(e.response?.statusCode == 422){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Format email salaah, kasih @mail.com")));
                            }
                            print("salahnya di $e");
                         }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 108,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              28,
                            ), // biar rounded
                          ),
                        ),
                        child: Text("Daftar", style: TextStyle(fontSize: 20)),
                      ),
                      const SizedBox(height: 36,),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text("Sudah Punya Akun? Login disini"),
                      )

                    ],
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
