import 'package:intl/intl.dart';

class TimeFormatter {
  String formatTime(DateTime dateTime) =>
      DateFormat('HH:mm').format(dateTime).toString();

  String formatDate(DateTime dateTime) {
    List<String> days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu'
    ];
    List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    String dayName = days[dateTime.weekday - 1];
    String day = dateTime.day.toString();
    String month = months[dateTime.month - 1];
    String year = dateTime.year.toString();

    return '$dayName, $day $month $year';
  }

  String formatHMY(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime).toString();
  }

  String formatTimeName(DateTime dateTime) {
    String name = '';

    int hour = dateTime.hour;

    if (hour >= 4 && hour < 11) {
      name = 'Selamat Pagi';
    } else if (hour >= 11 && hour < 15) {
      name = 'Selamat Siang';
    } else if (hour >= 15 && hour < 19) {
      name = 'Selamat Sore';
    } else {
      name = 'Selamat Malam';
    }

    return name;
  }
}
