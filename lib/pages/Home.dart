import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    //To check if the data comes from loading screen or choose location screen
    data = data.isNotEmpty ? data:ModalRoute.of(context).settings.arguments;

    String bgImage = data['isDayTime'] ? 'day.jpg':'night.jpg';
    Color bgColor = data['isDayTime'] ? Colors.blue:Colors.grey[800];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children: [
                  ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_location,
                          color: Colors.grey[500],
                        ),
                        Text(
                          "Edit Location",
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      ],
                  ),
                    onPressed: () async {
                      //Pushnamed is consideres to be a big async task which involves
                      //going to the new page and then coming back to the page from where it is called
                      dynamic res = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time':res['time'],
                          'location':res['location'],
                          'isDayTime':res['isDayTime'],
                          'flag':res['flag']
                        };
                      });
                    }
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}
