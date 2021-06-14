class BusStops
{
String name;
String latitude;
String longitude;
String  sub;

BusStops();

BusStops.fromMap(Map<String,dynamic> data){
  name = data['name'];
  sub = data['sub'];
  latitude = data['latitude'];
  longitude = data['longitude'];
}





}