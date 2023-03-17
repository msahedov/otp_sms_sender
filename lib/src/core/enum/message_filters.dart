import 'package:flutter/material.dart';

enum FilterMessage {
  daily,
  weekly,
  monthly,
  yearly,
  all,
}

extension FilterMessageMapping on FilterMessage {
  String name(BuildContext context) {
    switch (this) {
      case FilterMessage.daily:
        return 'Daily';
      case FilterMessage.weekly:
        return 'Weekly';
      case FilterMessage.monthly:
        return 'Monthly';
      case FilterMessage.yearly:
        return 'Yearly';
      case FilterMessage.all:
        return 'All';
    }
  }
}
