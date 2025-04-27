import 'package:http/http.dart' as http;

class InternetConnectionService {
  Future<bool> checkConnection() async {
    try {
      // final responseGoogle = await http.get(Uri.parse('https://google.com'));
      final responseYandex = await http.get(Uri.parse('https://yandex.ru'));
      final responseMail = await http.get(Uri.parse('https://mail.ru'));
      if (responseYandex.statusCode == 200 || responseMail.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
