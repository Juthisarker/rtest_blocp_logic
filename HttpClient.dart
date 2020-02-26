
import 'package:rtest_blocp_logic/src/resources/utils/StorageUtil.dart';
import '../data/StorageKeyConst.dart';
import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  String token;
  http.Client _client;

  HttpClient() {
    this._client = new http.Client();
  }

  Future<String> getBearerToken() async {
    var token = await StorageUtil.getString(StorageKeyConst.token);
    if (token == null) return null;
    return token;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    var bearerToken = await getBearerToken();
    request.headers['Content-Type'] = 'application/json';
    request.headers['Accept'] = 'application/json';
    if (bearerToken != null) request.headers['Authorization'] = 'Bearer $bearerToken';
    return _client.send(request);
  }
}
