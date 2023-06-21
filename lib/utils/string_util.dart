  String convertToSnakeCase(String input) {
    String snakeCase = input.replaceAllMapped(RegExp('([A-Z])'),
        (Match match) => '_${match.group(1)!.toLowerCase()}');
    if (snakeCase.startsWith('_')) {
      snakeCase = snakeCase.substring(1);
    }
    return snakeCase;
  }

  String capitalizeFirstLetter(String text) {
  if (text.isEmpty) {
    return text;
  }
  return text[0].toUpperCase() + text.substring(1);
}
