import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //create var to store user input
  String _userType = 'student' ;
  bool _termsAccepted = false ;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:[
              Color(0xFF0F4D92),
              Color(0xFF1A5FA8),
              Color(0xFF4299E1),
              Colors.white,
            ],
            stops: [0.0, 0.4, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:24.0, vertical: 20.0),
              child: Column(
                children: [
                  //back button
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 10 , bottom:20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
                        onPressed: (){
                          Navigator.pop(context); //going back to the previous screen
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0,10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.school_rounded,
                        size:50,
                        color: Color(0xFF0F4D92),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  //registration title
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Join Campus Connect Community',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 40),

                  //registration card form
                  Container(
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                          offset: Offset(0,15),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: TextStyle(color: Color(0xFF0F4D92)),
                            prefixIcon: Icon(Icons.person_rounded, color: Color(0xFF0F4D92)),
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
                        SizedBox(height: 20),

                        //email filed
                        TextField(
                          decoration: InputDecoration(
                            labelText:  'University Email',
                            labelStyle: TextStyle(color: Color(0xFF0F4D92)),
                            prefixIcon: Icon(Icons.email_rounded, color: Color(0xFF0F4D92)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color:Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFF0F4D92), width: 2),
                            ),
                            hintText: 'name@univ-constantine2.com',
                          ),
                        ),
                        SizedBox(height: 20),

                        //user type selectinion
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I am a : ',
                              style: TextStyle(
                                color: Color(0xFF0F4D92),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                //student option
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _userType = 'student'; //set to student
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: _userType == 'student' ? Color(0xFF0F4D92).withOpacity(0.1) //selected color
                                            : Colors.grey[100], //unselected color
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: _userType == 'student' ? Color(0xFF0F4D92) //BLUE WHEN selected
                                              : Colors.grey[300]!,
                                          width: _userType =='student' ? 2 :1 ,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.school_rounded,
                                            color: _userType == 'student' ? Color(0xFF0F4D92)  : Colors.grey[600],
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Student',
                                            style: TextStyle(
                                              color: _userType == 'student' ? Color(0xFF0F4D92) : Colors.grey[700],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                //teacher option
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _userType = 'teacher';
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: _userType=='teacher' ? Color(0xFF0F4D92).withOpacity(0.1)
                                            : Colors.grey[100],
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: _userType =='teacher' ? Color(0xFF0F4D92)
                                              : Colors.grey[300]!,
                                          width: _userType == 'teacher' ? 2 : 1 ,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.people_rounded,
                                            color: _userType == 'teacher' ? Color(0xFF0F4D92) : Colors.grey[600],
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Teacher',
                                            style: TextStyle(
                                              color: _userType =='teacher' ? Color(0xFF0F4D92) : Colors.grey[700],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //student registration note
                            if(_userType == 'student') ...[
                              SizedBox(height: 16),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFACD).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.orange.withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline_rounded,
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Student accounts require first admin approval. You can login after your account is approved.',
                                        style: TextStyle(
                                          color: Colors.orange[800],
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 20),

                        //password field
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Color(0xFF0F4D92)),
                            prefixIcon: Icon(Icons.lock_rounded, color: Color(0xFF0F4D92)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFF0F4D92), width: 2),
                            ),
                            hintText: 'At least 8 characters',
                          ),
                        ),
                        SizedBox(height: 20),

                        //confirm passwrd
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Color(0xFF0F4D92)),
                            prefixIcon: Icon(Icons.lock_outline_rounded, color: Color(0xFF0F4D92)),
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
                        SizedBox(height: 20),

                        //terms and conditions
                        Row(
                          children: [
                            Checkbox(
                              value: _termsAccepted,
                              onChanged: (bool? value){
                                setState((){
                                  _termsAccepted = value ?? false; //update state
                                });
                              },
                              activeColor: Color(0xFF0F4D92),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _termsAccepted = !_termsAccepted; //toggle checkbox
                                  });
                                },
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'I agree to the ',
                                        style: TextStyle(color: Colors.grey[700]),
                                      ),
                                      TextSpan(
                                        text: 'Terms of Service ',
                                        style: TextStyle(
                                          color: Color(0xFF0F4D92),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'and ',
                                        style: TextStyle(color: Colors.grey[700]),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(
                                          color: Color(0xFF0F4D92),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),

                        //sign up button
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
                            onPressed: _termsAccepted ? () {
                              if( _userType == 'student') {
                                //show student approval msg
                                _showPendingApprovalDialog(context);
                              } else{
                                //teacher registration
                                Navigator.pushNamed(context , '/home');
                              }
                            } : null , //button disable if terms not accepted
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
                                  Icons.person_add_rounded,
                                  color:Colors.white,
                                  size: 24 ,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'SIGN UP',
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

                        //divider with or
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'ALREADY HAVE AN ACCOUNT!?',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
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

                        //login link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already registered? ',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                'Login Here',
                                style: TextStyle(
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
                  SizedBox(height: 40),

                  //footer note
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Use your university email for registration',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //show pending approval dialog
  void _showPendingApprovalDialog(BuildContext context)  {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.hourglass_top_rounded,
                color: Colors.orange,
                size: 28,
              ),
              SizedBox(width:12),
              Text(
                'Registration Submitted',
                style: TextStyle(
                  color: Color(0xFF0F4D92),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your student account has been created successfully!' ,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF0F4D92).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Color(0xFF0F4D92),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Your account requires admin approval. You will receive an email when it\'s approved.',
                        style: TextStyle(
                          color: Color(0xFF0F4D92),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); //close dialog
                Navigator.pop(context); //go back to login
              },
              child: Text(
                'OK, RETURN TO LOGIN',
                style: TextStyle(
                  color: Color(0xFF0F4D92),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}