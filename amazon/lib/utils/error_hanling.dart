import 'package:amazon/utils/exports.dart';
import 'package:http/http.dart' as http;

void httpErrorHandling({
  required http.Response response,
  required VoidCallback onSuccess,
  required BuildContext context,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body.toString());
  }
}
