int maxLength = 50;

class RequestOpenaiData {
  final String prompt;
  int maxTokens = maxLength;

  RequestOpenaiData(this.prompt);

  Map<String, dynamic> buildRequestData() {
    return {
      "model": "gpt-3.5-turbo",
      "max_tokens": maxTokens,
      "messages": [
        // {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": prompt},
      ]
    };
  }
}

dynamic handleChatData(dynamic response) {
  return response['choices'][0]['text'];
}
