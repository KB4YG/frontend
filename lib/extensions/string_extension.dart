/// Add capitalize() and capitalizeAll() to strings
extension StringExtension on String {
  /// Make first character uppercase, rest lowercase.
  String capitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  /// Capitalize every word (delimited by space).
  String capitalizeAll() {
    var temp = '';
    for (var word in split(' ')) {
      temp += "${word[0].toUpperCase()}${word.substring(1).toLowerCase()} ";
    }
    return temp;
  }
}
