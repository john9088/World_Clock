import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime{

  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location,this.flag,this.url});

  //Add future in front of Async function, so that when it is called, the call can be awaited
  Future<void> getData() async{

    try{
      //await means move forward only when you get data(Blocking method)
      print("URL: worldtimeapi.org/api/timezone/"+url+".json");
      Response res = await get(Uri.https('worldtimeapi.org','api/timezone/'+url+'.json'));
      Map data = jsonDecode(res.body);
      //Get properties from data
      String dateTime = data['datetime'].split('+')[0];
      String offSet = data['utc_offset'].substring(1,3);

      //Create datetime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offSet)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true:false;
      print(isDayTime);
      time = DateFormat.jm().format(now);
    }catch(e){
      print('Caught Error: $e');
      time = 'Could not get time data';
    }
  }
}