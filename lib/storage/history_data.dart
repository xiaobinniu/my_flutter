Map<int, List<Dialogue>> dialogues = {};

enum UserType {
  user,
  system,
}

class Dialogue {
  final UserType userType;
  String text;

  Dialogue(this.userType, this.text);
}

class DialogueClass {
  int id = dialogues.length + 1;

  add(Dialogue message) {
    if (dialogues[id] == null) {
      dialogues[id] = [];
    }
    dialogues[id]!.add(message);
  }

  static List<Dialogue>? get(int id) {
    return dialogues[id];
  }

  static Map<int, List<Dialogue>> getAll() {
    return dialogues;
  }
}
