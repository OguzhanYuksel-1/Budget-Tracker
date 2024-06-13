import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = TextEditingController();
  List<Map<String, String>> _messages = [];
  bool _isLoading = false; 

  Future<void> _callChatGPT(String prompt) async {
    setState(() {
      
      _isLoading = true;
    });

    final response = await callChatGPT(prompt);

    setState(() {
      
      _isLoading = false;
    });

    if (response != null) {
      setState(() {
        _messages.add({'sender': 'Kullanıcı', 'content': prompt});
        _messages.add({'sender': 'AI', 'content': response});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green, Colors.blue],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Align(
                    alignment: message['sender'] == 'Kullanıcı'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: message['sender'] == 'Kullanıcı'
                            ? Colors.blue[400]
                            : Colors.green[300],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        message['content']!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(32.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Mesajınızı Yazınız...',
                      filled: true,
                      fillColor: Colors.grey[200], 
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          String userMessage = _textController.text;
                          await _callChatGPT(userMessage);
                          _textController.clear();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400], 
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        ) 
                      : Text(
                          'Gönder',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
      'max_tokens': 2048, // Sınırı artırma
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




