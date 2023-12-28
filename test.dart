void main() {
  var obj = {
    "a": "a",
  };

  var b = [];

  b.add(obj);
  print(b);

  obj["a"] = "aa";

  print(b); // 输出 "a a"
}
