

import 'package:http/http.dart' as http;

  void main() async {
    var url = Uri.parse('https://agropulse.web.tr/api/data');
    var response = await http.post(url, body: {'title': 'foo', 'body': 'bar', 'userId': '1'});

    if (response.statusCode == 201) {
      print('Post created: ${response.body}');
    } else {
      print('Failed to create post: ${response.statusCode}');
    }
  }