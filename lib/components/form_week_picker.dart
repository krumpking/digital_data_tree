import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../app/app_const.dart';

class FormWeekPicker {
  static dynamic weekPicked;
  static weekPicker() {
    DateRangePickerController controller = DateRangePickerController();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SfDateRangePicker(
          todayHighlightColor: AppColors.primaryColor,
          selectionColor: AppColors.thirdColor,
          startRangeSelectionColor: AppColors.primaryColor,
          endRangeSelectionColor: AppColors.primaryColor,
          rangeSelectionColor: AppColors.thirdColor,
          controller: controller,
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.range,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            int firstDayOfWeek = DateTime.sunday % 7;
            int endDayOfWeek = (firstDayOfWeek - 1) % 7;
            endDayOfWeek = endDayOfWeek < 0 ? 7 + endDayOfWeek : endDayOfWeek;
            PickerDateRange ranges = args.value;
            DateTime date1 = ranges.startDate!;
            DateTime date2 = (ranges.endDate ?? ranges.startDate)!;
            if (date1.isAfter(date2)) {
              var date = date1;
              date1 = date2;
              date2 = date;
            }
            int day1 = date1.weekday % 7;
            int day2 = date2.weekday % 7;

            DateTime dat1 = date1.add(Duration(days: (firstDayOfWeek - day1)));
            DateTime dat2 = date2.add(Duration(days: (endDayOfWeek - day2)));

            bool isSameDate(DateTime? date1, DateTime? date2) {
              if (date2 == date1) {
                return true;
              }
              if (date1 == null || date2 == null) {
                return false;
              }
              return date1.month == date2.month &&
                  date1.year == date2.year &&
                  date1.day == date2.day;
            }

            if (!isSameDate(dat1, ranges.startDate) ||
                !isSameDate(dat2, ranges.endDate)) {
              controller.selectedRange = PickerDateRange(dat1, dat2);
              weekPicked = PickerDateRange(dat1, dat2);
            }
          },
          monthViewSettings:
              DateRangePickerMonthViewSettings(enableSwipeSelection: false),
        ));
  }
}
