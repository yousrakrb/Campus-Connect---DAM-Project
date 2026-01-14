import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F4D92),
              Color(0xFF1A5FA8),
              Color(0xFF4299E1),
              Colors.white,
            ],
            stops : [0.0 ,0.4,0.7,1.0], //where each color starts
          ),
        ),
        child: SingleChildScrollView( //allows scrolling if content is too long for the screen
          child: Padding(
            //this to add space around all content
            padding: const EdgeInsets.symmetric(horizontal: 24.0 , vertical: 20.0),
            child: Column(
              children: [
                //back button (top left)
                Align(
                  alignment: Alignment.topLeft, //position at top-left corner
                  child: Container(
                    margin: EdgeInsets.only(top:10, bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_rounded,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },

                    ),
                  ),
                ),

                SizedBox(height: 20), //space between widgets


                //logo section
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:Colors.blue.withOpacity(0.3),  //blue shadow
                        blurRadius: 20,
                        offset: Offset(0,10),
                      ),
                    ],
                  ),
                  child: Center(
                    //centring the icon inside the container
                    child: Icon(
                      Icons.school_rounded,
                      size: 50 ,
                      color: Color(0xFF0F4D92),
                    ),
                  ),
                ),

                SizedBox(height: 30) , //space between theicon an the title

                //title section
                Text(
                  'Welcome Back' ,
                  style: TextStyle(
                    fontSize: 32, //large fontsize for the main title
                    color: Colors.white,
                    fontWeight: FontWeight.w800, //for extra bold
                    letterSpacing : 1.2,
                  ),
                ),

                SizedBox(height: 8),
                Text(
                  'Login to Campus Connect',
                  style: TextStyle(
                    fontSize: 18,//making it medium for the subtitle
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w300,
                  ),
                ),

                SizedBox(height: 40), // space before form

                //login form card
                Container(
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24), //rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 30, // very blurry shaadow
                        spreadRadius: 5,
                        offset: Offset(0,15),//shadow below card
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      //email input
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(0xFF0F4D92)),
                          prefixIcon: Icon(Icons.email_rounded , color: Color(0xFF0F4D92)),
                          border : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),//ight grey border
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xFF0F4D92), width: 2),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      //password input  filed
                      TextField(
                        obscureText: true, //hides text for password
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Color(0xFF0F4D92)),
                          prefixIcon: Icon(Icons.lock_rounded , color:Color(0xFF0F4D92)),
                          suffixIcon: Icon(Icons.visibility_off_rounded, color: Colors.grey[400]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xFF0F4D92), width: 2),
                          ),

                        ),
                      ),

                      SizedBox(height: 16),

                      //forgot password link
                      Align(
                        alignment: Alignment.centerRight,//positions on the right side
                        child: TextButton(
                          onPressed: (){
                            //we will add functionality og forgot password
                            //and the navigator.pushnamed(cotext, 'forgotpassword
                          },
                          child: Text(
                            'I Forgot My Password!!',
                            style: TextStyle(
                              color: Color(0xFF0F4D92),
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        ),
                      ),

                      SizedBox(height: 30), //space before the button
                      Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF0F4D92),
                              Color(0xFF1A5FA8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF0F4D92).withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: (){
                            //after a successful llogin go to ur panel or ur home page
                            Navigator.pushNamed(context,'/home');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login_rounded,
                                color: Colors.white,
                                size: 24,
                              ),

                              SizedBox(width: 12), //space between icon and text
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 24),


                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey[300],//light grey for the left devider line
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Divider(
                              color: Colors.grey[300],
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      //sign up link for new users
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            //making text clickable
                            onTap: (){
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              'Sign Up',
                              style:TextStyle(
                                color: Color(0xFF0F4D92),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                //social login options
                Column(
                  children: [
                    Text(
                      'Login With',
                      style:TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        //google login button
                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),//light shade
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child:Text(
                              'G',
                              style:TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        //facebook login
                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape:BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0,5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'f',
                              style:TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontFamily: 'Arial',
                              ),
                            ),
                          ),
                        ),

                        //univ log in button

                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.school_rounded,
                              color: Color(0xFF0F4D92),
                              size:28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),


        ),

      ),
    );
  }
}