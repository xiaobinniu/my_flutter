class Dialogue {
  final String user;
  final String system;

  Dialogue(this.user, this.system);
}

void main() {
  Map<int, List<Dialogue>> dialogues = {
    3: [Dialogue("User3", "System3")],
    1: [Dialogue("User1", "System1"), Dialogue("User1_2", "System1_2")],
    2: [Dialogue("User2", "System2")],
  };

  // 获取并排序 Map 的键
  List<int> sortedKeys = dialogues.keys.toList()..sort();

  // 按照排序后的键输出 List<Dialogue>
  for (int key in sortedKeys) {
    print('Key: $key');
    print('Dialogues: ${dialogues[key]}');
  }
}
