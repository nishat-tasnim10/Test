import 'package:flutter/material.dart';
import 'package:untitled2/main.dart';
import 'WelcomeScreen.dart';
import 'HomePage.dart';

class LoginPage extends  StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool hidePassword = true;

  var nameText = TextEditingController();
  var passText = TextEditingController();

    void dispose(){
      nameText.dispose();
      passText.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Login",style: TextStyle(color: Color(0xFFFED7A5)),),backgroundColor:Color(0xFF132E35) ,),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/loginPg.png"),
              fit:BoxFit.cover
          )
        ),
        child: Center(
          child:Column(
            mainAxisAlignment :MainAxisAlignment.center,
            //Color(0xFF1F4B4F)  Color(0xFF132E35)


            children: [
              Spacer(flex: 2),
              const SizedBox(height: 20,),
            Padding(padding: const EdgeInsets.symmetric(horizontal:30),
               child:SizedBox(
                   height: 66,
                   width: double.infinity,
              child:TextField(
                controller: nameText,
                style: TextStyle(color: Color(0xFFFED7A5),fontSize: 20),
                decoration: InputDecoration(hintText: " Enter Email or Username:",
                    hintStyle:TextStyle(color: Color(0xFFFED7A5),fontSize: 20 ) ,

                   // suffixIcon: Icon(Icons.email_outlined, color: Color(0xFFFED7A5)),
                    enabledBorder:OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(4.0)), gapPadding: 4.0,
                    borderSide:BorderSide(color:Colors.transparent,width:2,style: BorderStyle.solid,)
                ),
                    filled:true,fillColor : Color(0xFF132E35).withOpacity(0.8),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color:  Colors.tealAccent,), borderRadius: const BorderRadius.all(Radius.circular(4.0)), gapPadding: 4.0)
                ),
              )
               ),
            ),




            const SizedBox(height: 20,),
              Padding(padding: const EdgeInsets.symmetric(horizontal:30),
                child:SizedBox(
                    height: 66,
                    width: double.infinity,
                    child:TextField(
                      controller: passText,
                      obscureText: hidePassword,
                      style: TextStyle(color: Color(0xFFFED7A5),fontSize: 20),
                      decoration: InputDecoration(hintText: " Enter Password: ",
                          hintStyle:TextStyle(color: Color(0xFFFED7A5),fontSize: 20 ),

                          suffixIcon:IconButton( icon: Icon(
                            hidePassword? Icons.remove_red_eye_outlined :Icons.visibility_off_outlined
                            , color: Color(0xFFFED7A5),
                          ),

                          onPressed:(){
                        setState(() {
                          hidePassword=!hidePassword;
                        });
                          }
                          ),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(4.0)), gapPadding: 4.0,
                              borderSide:BorderSide(color:Colors.transparent,width:2,style: BorderStyle.solid,)
                          ),
                          filled:true,fillColor : Color(0xFF132E35).withOpacity(0.8),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.tealAccent,), borderRadius: const BorderRadius.all(Radius.circular(4.0)), gapPadding: 4.0)
                      ),
                    )
                ),

              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child:SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      String username = nameText.text.trim();
                      String password = passText.text.trim();
                      if(username.isEmpty || password.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Enter Correct email or Username & pasword",
                              style: TextStyle(color: Color(0xFFFED7A5)
                              ),
                            ),
                            backgroundColor: Color(0xFF132E35),
                            ),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: Color(0xFF1F4B4F),
                      backgroundColor: const Color(0xFF1F4B4F),
                      foregroundColor: const Color(0xFFFED7A5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical:16), // height
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFFFED7A5),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),



              Spacer(flex: 5),
            ],
          )
        ),





      ),
    );
  }
}