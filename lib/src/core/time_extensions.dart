import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'enum/message_filters.dart';

extension DateUtils on DateTime {
  String get formattedDate => DateFormat('dd/MM/yyyy').format(this);
  String get formattedDateFull => DateFormat('dd-MM-yyy HH:mm').format(this);
  String get dayString => DateFormat('dd').format(this);
  String get weekString => DateFormat('EEE').format(this);
  String get shortDayString => DateFormat('dd EEEE  HH:mm').format(this);

  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day && tomorrow.month == month && tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  int get daysDifference => daysElapsedSince(this, DateTime.now());

  int get ordinalDate {
    const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
    return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
  }

  /// True if this date is on a leap year.
  bool get isLeapYear {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  int get weekOfYear {
    final woy = ((ordinalDate - weekday + 10) ~/ 7);
    if (woy == 0) {
      return DateTime(year - 1, 12, 28).weekOfYear;
    }
    if (woy == 53 &&
        DateTime(year, 1, 1).weekday != DateTime.thursday &&
        DateTime(year, 12, 31).weekday != DateTime.thursday) {
      return 1;
    }
    return woy;
  }

  String formatted(FilterMessage filterBudget) {
    switch (filterBudget) {
      case FilterMessage.daily:
        return DateFormat('dd EEEE MMM').format(this);
      case FilterMessage.weekly:
        return "Week $weekOfYear of ${DateFormat('yyyy').format(this)}";
      case FilterMessage.monthly:
        return DateFormat('MMMM yyyy').format(this);
      case FilterMessage.yearly:
        return DateFormat('yyyy').format(this);
      case FilterMessage.all:
        return 'All';
    }
  }

  bool isAfterBeforeTime(DateTimeRange range) {
    return (isAfter(range.start) || isAtSameMomentAs(range.start)) &&
        (isAtSameMomentAs(range.end) || isBefore(range.end));
  }
}

int daysElapsedSince(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return to.difference(from).inDays;
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'enum/message_filters.dart';

// extension DateUtils on DateTime {
//   String get formattedDate => DateFormat('dd/MM/yyyy').format(this);
//   String get dayString => DateFormat('dd').format(this);
//   String get weekString => DateFormat('EEE').format(this);
//   String get timeString => DateFormat('HH:mm').format(this);
//   String get shortDayString {
//     var weekDay = DateFormat('EEEE').format(this);
//     var day = DateFormat('dd').format(this);
//     return '$day ${convertDayToTkm(weekDay)}';
//   }

//   bool get isToday {
//     final now = DateTime.now();
//     return now.day == day && now.month == month && now.year == year;
//   }

//   bool get isTomorrow {
//     final tomorrow = DateTime.now().add(const Duration(days: 1));
//     return tomorrow.day == day && tomorrow.month == month && tomorrow.year == year;
//   }

//   bool get isYesterday {
//     final yesterday = DateTime.now().subtract(const Duration(days: 1));
//     return yesterday.day == day && yesterday.month == month && yesterday.year == year;
//   }

//   int get daysDifference => daysElapsedSince(this, DateTime.now());

//   int get ordinalDate {
//     const offsets = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];
//     return offsets[month - 1] + day + (isLeapYear && month > 2 ? 1 : 0);
//   }

//   /// True if this date is on a leap year.
//   bool get isLeapYear {
//     return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
//   }

//   int get weekOfYear {
//     final woy = ((ordinalDate - weekday + 10) ~/ 7);
//     if (woy == 0) {
//       return DateTime(year - 1, 12, 28).weekOfYear;
//     }
//     if (woy == 53 &&
//         DateTime(year, 1, 1).weekday != DateTime.thursday &&
//         DateTime(year, 12, 31).weekday != DateTime.thursday) {
//       return 1;
//     }
//     return woy;
//   }

//   String convertDayToTkm(String dayName) {
//     switch (dayName) {
//       case 'Monday':
//         return 'Duşenbe';
//       case 'Tuesday':
//         return 'Sişenbe';
//       case 'Wednesday':
//         return 'Çarşenbe';
//       case 'Thursday':
//         return 'Penşenbe';
//       case 'Friday':
//         return 'Anna';
//       case 'Saturday':
//         return 'Şenbe';
//       case 'Sunday':
//         return 'Ýekşenbe';
//       default:
//         return 'Duşenbe';
//     }
//   }

//   String convertMonthToTkm(String monthName) {
//     switch (monthName) {
//       case 'January':
//         return 'Ýanwar';
//       case 'February':
//         return 'Fewral';
//       case 'March':
//         return 'Mart';
//       case 'April':
//         return 'Aprel';
//       case 'May':
//         return 'Maý';
//       case 'June':
//         return 'Iýun';
//       case 'July':
//         return 'Iýul';
//       case 'August':
//         return 'Awgust';
//       case 'September':
//         return 'Sentýabr';
//       case 'October':
//         return 'Oktýabr';
//       case 'November':
//         return 'Noýabr';
//       case 'December':
//         return 'Dekabr';

//       default:
//         return 'Ýanwar';
//     }
//   }

//   String formatted(FilterMessage filterMessage) {
//     switch (filterMessage) {
//       case FilterMessage.daily:
//         {
//           var day = DateFormat('dd').format(this);
//           var weekDay = DateFormat('EEEE').format(this);
//           var month = DateFormat('MMMM').format(this);

//           return '${convertMonthToTkm(month)} $day, ${convertDayToTkm(weekDay)}';
//         }
//       case FilterMessage.weekly:
//         {
//           return "${DateFormat('yyyy').format(this)} , $weekOfYear-nji(y) hepde";
//         }
//       case FilterMessage.monthly:
//         {
//           var month = DateFormat('MMMM').format(this);
//           var year = DateFormat('yyyy').format(this);

//           return '${convertMonthToTkm(month)} $year';
//         }
//       case FilterMessage.yearly:
//         return DateFormat('yyyy').format(this);
//       case FilterMessage.all:
//         return 'Ählisi';
//     }
//   }

//   bool isAfterBeforeTime(DateTimeRange range) {
//     return (isAfter(range.start) || isAtSameMomentAs(range.start)) &&
//         (isAtSameMomentAs(range.end) || isBefore(range.end));
//   }
// }

// int daysElapsedSince(DateTime from, DateTime to) {
//   from = DateTime(from.year, from.month, from.day);
//   to = DateTime(to.year, to.month, to.day);
//   return to.difference(from).inDays;
// }
