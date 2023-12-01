import 'dart:convert';
import 'package:http/http.dart' as http;

String url = 'http://192.168.0.114:5000/';

final headers = {'Content-Type': 'application/json'};
postData(String Route, final passedBody) async {
  // print(jsonEncode(passedBody));
  http.Response response = await http.post(Uri.parse(url+Route), headers: headers,  body: json.encode(passedBody));
  print(Uri.parse(url+Route));
  return response.body;
}
getData(String Route) async {
  http.Response response = await http.get(Uri.parse(url+Route),  headers: headers);
  return response.body;
}
patchData(String Route, passedBody) async{
  http.Response response = await http.patch(Uri.parse(url+Route),headers: headers,body: jsonEncode(passedBody));
  return response.body;
}
