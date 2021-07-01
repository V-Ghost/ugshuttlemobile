class Settings{
   String price;
   Settings();
   Settings.fromMap(Map<String, dynamic> data) {
    price = data['price'];
   
   
  }
}