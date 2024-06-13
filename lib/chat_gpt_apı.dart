import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> callChatGPT(String prompt) async {
  const apiKey = "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"; 
  const apiUrl = "https://api.openai.com/v1/chat/completions";

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey'
  };

  final body = jsonEncode(
    {
      "model": "gpt-4o",
      'messages': [
        {'role': 'system', 'content': 'You are a friendly AI assistant.'},
        {'role': 'user', 'content': prompt},
      ],
      'max_tokens': 2048,
    },
  );

  return await _makeRequest(apiUrl, headers, body);
}

Future<String?> _makeRequest(String apiUrl, Map<String, String> headers, String body, {int retries = 3}) async {
  int attempt = 0;
  while (attempt < retries) {
    try {
      final response = await http
          .post(
            Uri.parse(apiUrl),
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 60)); // Zaman aşımı süresi 

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final result = jsonResponse['choices'][0]['message']['content'];
        return utf8.decode(result.codeUnits);
      } else {
        print('Hata: ${response.statusCode} - ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Hata: $e');
      attempt++;
      if (attempt >= retries) {
        return null;
      }
      await Future.delayed(const Duration(seconds: 2)); // Tekrar denemeden önce bekleme süresi
    }
  }
  return null;
}


// CHAT GPT API KEY : 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
// CHAT GPT API URL : https://api.openai.com/v1/chat/completions
// CHAT GPT CHAT MODEL : gpt-4o
