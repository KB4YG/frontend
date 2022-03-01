extension StringExtension on String {
  String capitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  String capitalizeAll() {
    var temp = '';
    for (var word in split(' ')) {
      temp += "${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ";
    }
    return temp;
  }
}
