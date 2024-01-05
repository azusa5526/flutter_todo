// ignore_for_file: unused_element, unused_field

import 'dart:developer';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart' show debugPrint;

const _undefined = Object();

void console(
  Object? value, [
  Object? value2 = _undefined,
  Object? value3 = _undefined,
  Object? value4 = _undefined,
  Object? value5 = _undefined,
  Object? value6 = _undefined,
  Object? value7 = _undefined,
  Object? value8 = _undefined,
  Object? value9 = _undefined,
]) {
  _log(value);
  if (value2 != _undefined) {
    _log(value2);
  }
  if (value3 != _undefined) {
    _log(value3);
  }
  if (value4 != _undefined) {
    _log(value4);
  }
  if (value5 != _undefined) {
    _log(value5);
  }
  if (value6 != _undefined) {
    _log(value6);
  }
  if (value7 != _undefined) {
    _log(value7);
  }
  if (value8 != _undefined) {
    _log(value8);
  }
  if (value9 != _undefined) {
    _log(value9);
  }
}

void _log(Object? val) {
  if (kReleaseMode) {
    return;
  }
  var now = _Date(DateTime.now()).toTimeString();
  var prefix =
      '[${_AnsiColor.magenta.log(now)}](${_AnsiColor.yellow.log(val.runtimeType)}):';
  if (val == null) {
    debugPrint('$prefix ${_AnsiColor.white.log('null')}');
    return;
  }
  if (val is num || val is DateTime || val is bool) {
    debugPrint('$prefix ${_AnsiColor.white.log(val.toString())}');
    return;
  }
  if (val is String) {
    debugPrint('$prefix ${_AnsiColor.white.log(val)}');
    return;
  }

  inspect(val);
}

enum _AnsiColor {
  black("30"),
  red("31"),
  green("32"),
  yellow("33"),
  blue("34"),
  magenta("35"),
  cyan("36"),
  white("37");

  final String code;
  const _AnsiColor(this.code);

  String log(dynamic text) => '\x1B[${code}m${text.toString()}\x1B[0m';
}

class _Date {
  final DateTime date;
  const _Date(this.date);

  String toDateString() {
    var year = date.year;
    String y =
        (year >= -9999 && year <= 9999) ? _fourDigits(year) : _sixDigits(year);
    String m = _twoDigits(date.month);
    String d = _twoDigits(date.day);

    return '$y-$m-$d';
  }

  String toTimeString() {
    String h = _twoDigits(date.hour);
    String m = _twoDigits(date.minute);
    String s = _twoDigits(date.second);
    return '$h:$m:$s';
  }
}

String _fourDigits(int n) {
  int absN = n.abs();
  String sign = n < 0 ? "-" : "";
  if (absN >= 1000) return "$n";
  if (absN >= 100) return "${sign}0$absN";
  if (absN >= 10) return "${sign}00$absN";
  return "${sign}000$absN";
}

String _sixDigits(int n) {
  assert(n < -9999 || n > 9999);
  int absN = n.abs();
  String sign = n < 0 ? "-" : "+";
  if (absN >= 100000) return "$sign$absN";
  return "${sign}0$absN";
}

String _threeDigits(int n) {
  if (n >= 100) return "$n";
  if (n >= 10) return "0$n";
  return "00$n";
}

String _twoDigits(int n) {
  if (n >= 10) return "$n";
  return "0$n";
}
