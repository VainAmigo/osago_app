class CarPlateParser {
  final String plate;

  CarPlateParser(this.plate);

  // kg new format
  bool isFormatOne() {
    return RegExp(r"^\d{2}[a-zA-Z]{2}\d{3}[a-zA-Z]{3}$").hasMatch(plate);
  }

  // kg old format
  bool isFormatTwo() {
    return RegExp(r"^[A-Z]\d{4}[A-Z]{2}$").hasMatch(plate.toUpperCase());
  }



  // new format parser
  List<String> parseFormatOne() {
    RegExp regExp = RegExp(r"(\d{2})([a-zA-Z]{2})(\d{3})([a-zA-Z]{3})");
    var match = regExp.firstMatch(plate);

    if (match != null) {
      return [
        match.group(1) ?? '',
        match.group(2) ?? '',
        match.group(3) ?? '',
        match.group(4) ?? ''
      ];
    }
    return ['', '', '', ''];
  }

  // old format parser
  List<String> parseFormatTwo() {
    RegExp regExp = RegExp(r"^([A-Z])(\d{4})([A-Z]{2})$");
    var match = regExp.firstMatch(plate.toUpperCase());

    if (match != null) {
      return [match.group(1) ?? '', match.group(2) ?? '', match.group(3) ?? ''];
    }
    return ['', '', ''];
  }
}