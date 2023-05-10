import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String id) async {
  try {
    var url = "https://api.coingecko.com/api/v3/coins/$id";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      String coinPrice = json['market_data']['current_price']['usd'].toString();
      return double.parse(coinPrice);
    }

    ///String imageUrl = json['image']['thumb'];
    return 0.0;
  } catch (e) {
    print("Error: ${e.toString()}");
    return 0.0;
  }
}
