class Numeral {
  final num _number;

  Numeral._(this._number);
  factory Numeral(num number) {
    assert(
        number is num, 'The data to be processed must be passed in a [num].');

    return Numeral._(number);
  }

  double get number => _number.toDouble();
  String value() {
    var value = number;
    var absolute = number.abs();
    var abbr = '';
    if (absolute >= 1000000000000) {
      value = number / 1000000000000;
      abbr = 'T';
    } else if (absolute >= 1000000000) {
      value = number / 1000000000;
      abbr = 'B';
    } else if (absolute >= 1000000) {
      value = number / 1000000;
      abbr = 'M';
    } else if (absolute >= 1000) {
      value = number / 1000;
      abbr = 'K';
    }

    return _removeEndsZore(value.toStringAsFixed(1)) + abbr;
  }
  String _removeEndsZore(String value) {
    if (value.length == 1) {
      return value;
    } else if (value.endsWith('.')) {
      return value.substring(0, value.length - 1);
    } else if (value.endsWith('0')) {
      return _removeEndsZore(value.substring(0, value.length - 1));
    }

    return value;
  }
  @override
  String toString() => value();
}