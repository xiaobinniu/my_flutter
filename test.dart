void main() {
  var str = 'Nice to meet you.\n';
  print(str.contains('\n'));
  var newstr = str.replaceAll("\n", "replace");
  print(newstr);
}
