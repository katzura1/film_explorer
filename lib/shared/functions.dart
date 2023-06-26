import 'dart:io';

import 'package:film_explorer/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:intl/intl.dart';

String formatRupiah(int number, {String symbol = ""}) {
  return NumberFormat.currency(locale: 'id', symbol: "$symbol ", decimalDigits: 0).format(number);
}

void showCustomSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: orangColor,
    messageColor: whiteColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

String messageBuilder(Map<String, dynamic> messages) {
  String message = "";
  Map<String, dynamic>.from(messages).forEach((key, value) {
    for (String item in value) {
      if (message.isEmpty == true) {
        message += item;
      } else {
        message += '$item\n';
      }
    }
  });
  return message;
}

String errorBuilder(Map<String, dynamic> body) {
  if (body.containsKey('message')) {
    return body['message'];
  } else if (body.containsKey('errors')) {
    return messageBuilder(body['errors']);
  } else {
    return 'Unknown error';
  }
}

String getFileExtension(String filePath) {
  final file = File(filePath);
  final fileName = file.path.split('/').last;
  final fileNameParts = fileName.split('.');
  if (fileNameParts.length > 1) {
    return fileNameParts.last;
  }
  return '';
}

String formatDate(DateTime date, {bool showTime = false}) {
  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inDays == 0) {
    // Hari ini
    if (showTime) {
      final timeFormat = DateFormat('jm', 'en_US');
      return 'Today at ${timeFormat.format(date)}';
    } else {
      return 'Today';
    }
  } else if (diff.inDays == 1) {
    // Kemarin
    if (showTime) {
      final timeFormat = DateFormat('jm', 'en_US');
      return 'Yesterday at ${timeFormat.format(date)}';
    } else {
      return 'Yesterday';
    }
  } else if (diff.inDays < 365) {
    // Tahun yang sama
    final dateFormat = DateFormat('MMM d', 'en_US');
    return dateFormat.format(date);
  } else {
    // Tahun yang berbeda
    final dateFormat = DateFormat('MMM d y', 'en_US');
    return dateFormat.format(date);
  }
}

bool isDateFormatValid(String dateString) {
  try {
    DateTime.parse(dateString);
    return true; // Format tanggal valid
  } catch (e) {
    return false; // Format tanggal tidak valid
  }
}
