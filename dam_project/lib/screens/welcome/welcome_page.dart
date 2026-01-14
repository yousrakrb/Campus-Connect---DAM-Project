import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context ){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F4D92), //bleu the top color
              Color(0xFF1A5FA8), //medium bleu
              Color(0xFF4299E1), //light bleu
              Colors.white, //bottom color
            ],
            stops: [0.0,0.4,0.7,1.0],//this is the color transition points
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            //enables scrolling if content overflows
            child: Padding(
              //add padding around the content to make it more orgnized
              padding: const EdgeInsets.symmetric(horizontal: 24.0 , vertical: 20.0),
              child: Column(
                //arranges widgets vertically
                children: [
                  SizedBox(height: 40), //empty spave at top


                  //logo
                  Container( //widget
                    width: 130, //this fir the circular container
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle, //makes container circular
                      boxShadow: [
                        //adding depth to the logo
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3), //shadow color
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: Offset(0,10),
                        ),
                      ],
                    ),
                    child: Center(
                      //center widget centers its child
                      child: Icon(
                        Icons.school_rounded, //scool icon
                        size:70,
                        color: Color(0xFF0F4D92), //icon s color
                      ),
                    ),
                  ),
                  SizedBox(height: 30), //spacing between the logo and the title


                  //title
                  Column(
                    children: [
                      Text( 'Welcome to',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.2, //space between letters
                        ),
                      ),
                      SizedBox(height: 8),//small spacing

                      //ap name
                      Text(
                        'CAMPUS CONNECT',
                        style: TextStyle(
                          fontSize: 34,
                          color: Colors.white,
                          fontWeight: FontWeight.w800, //extra bold
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 8),

                      //university name

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15), //lil transparent
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Constantine 2 University',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFFFFFACD),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  //some features
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //shedule
                          _FeatureBox(
                            icon: Icons.calendar_today_rounded,
                            title: 'Schedule',
                            subtitle: 'Class times',
                            color: Colors.blueAccent,
                          ),
                          //grades
                          _FeatureBox(
                            icon: Icons.analytics_rounded,
                            title: 'Grades',
                            subtitle: 'Track progress',
                            color: Colors.greenAccent,
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //updates
                          _FeatureBox(
                            icon: Icons.announcement_rounded,
                            title: 'Updates',
                            subtitle: 'Campus News',
                            color: Colors.orangeAccent,
                          ),
                          //connect
                          _FeatureBox(
                              icon: Icons.forum_rounded,
                              title : 'Connect',
                              subtitle: 'With peers',
                              color: Colors.purpleAccent
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),

                  //content card

                  Container(
                    padding: EdgeInsets.all(28), //inner padding
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), //shadow color
                          blurRadius: 30,
                          spreadRadius: 5,
                          offset: Offset(0, 15),//shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xFF0F4D92),
                              size: 22 ,
                            ),
                            SizedBox(width: 10),
                            Text('Your Campus Companion',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF0F4D92),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],

                        ),
                        SizedBox(height: 24 ), //spacing between header and the description

                        //description text

                        Text(
                          'Everything you need for your academic success, organzied in one app.'
                              'Manage your schedule,track grades , and stay connected with campus life!!!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 40),
                        //separation text
                        Row(
                          children: [
                            Expanded(
                              //left seper
                              child: Divider(
                                color: Colors.grey[300],
                                thickness: 1, //line thickness
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              //right side
                              child: Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30), //spacing before buttons

                        //two buttons : login and registration
                        //  login
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
                                offset: Offset(0,5),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: (){
                              //navigation to login screen
                              Navigator.pushNamed(context, '/login');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),//to match the container
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.lock_open_rounded, //login icon
                                  color: Colors.white,
                                  size: 22,
                                ),

                                SizedBox(height: 12) , //space between icon and the text
                                Text(
                                  'Login To Account',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16), //space between login button and the sign up

                        Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0F4D92),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: OutlinedButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/register');
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              side: BorderSide.none,//removing default border
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_add_alt_1_rounded,
                                  color: Color(0xFF0F4D92),
                                  size: 22,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Create New Account',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0F4D92),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 30),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 3,
                        color: Colors.white.withOpacity(0.5),

                      ),
                      SizedBox(height: 20),

                      Text(
                        'DAM Project',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      SizedBox(height: 4),
                      Text(
                        'Faculty of Computer Science',
                        style:TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _FeatureBox({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  })
  {
    return Container(
      width: 150,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ) ,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //property that decides how to space the children
        children: [
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 26,
            ),
          ),

          SizedBox(height: 12), //spacing between icon and text

          //feature title
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600, //this to choose how thick the text should be
            ),
          ),

          SizedBox(height: 4) , //small spacing

          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

}