import 'dart:convert';
import 'package:http/http.dart' as http;

String url = 'http://127.0.0.1:5000';


final headers = {
'Content-Type': 'application/json',
"Access-Control-Allow-Origin": "*", // Required for CORS support to work
"Access-Control-Allow-Credentials":
'true', // Required for cookies, authorization headers with HTTPS
"Access-Control-Allow-Headers":
"Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
"Access-Control-Allow-Methods": "POST, OPTIONS"
};

postData(String route, final passedBody) async {
  print(jsonEncode(passedBody));
  http.Response response = await http.post(Uri.parse(url+route), headers: headers,  body: json.encode(passedBody));
  return response.body;
}
getData(String route) async {
  http.Response response = await http.get(Uri.parse(url+route),  headers: headers);
  return response.body;
}
patchData(String route, passedBody) async {
  http.Response response = await http.patch(
      Uri.parse(url + route), headers: headers, body: jsonEncode(passedBody));
  return response.body;
}

deleteData(String route, passedBody) async {
  http.Response response = await http.delete(
      Uri.parse(url + route), headers: headers, body: jsonEncode(passedBody));
  return response.body;
}