import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_project/bloc/employees_bloc.dart';
import 'package:task_project/bloc/employees_event.dart';
import 'package:task_project/custom_widget/custom_text_field.dart';
import 'package:task_project/models/employees_model.dart';
import 'package:task_project/utils/colorutils.dart';
import 'package:task_project/utils/constants.dart';
import 'package:task_project/utils/font_utils.dart';
import 'package:task_project/utils/variable_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class AddEmployeeDetailsScreen extends StatefulWidget {
  const AddEmployeeDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeDetailsScreen> createState() =>
      _AddEmployeeDetailsScreenState();
}

class _AddEmployeeDetailsScreenState extends State<AddEmployeeDetailsScreen> {
  bool isLoading = false;
  List role = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner',
  ];
  int selectRole = -1;

  TextEditingController employeeNameController = TextEditingController();
  TextEditingController selectRoleController = TextEditingController();
  TextEditingController toDayController = TextEditingController();
  DateTime eventDate = DateTime.now();
  String startdate = '';
  String enddate = '';

  void checkValidation(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          VariableUtils.addEmployeeDetails,
          style:
              FontUtils.medium.copyWith(fontSize: 15, color: ColorUtils.white),
        ),
        backgroundColor: ColorUtils.blueF2,
        elevation: 0,
        // Add any additional properties you need
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            CustomTextField(
              controller: employeeNameController,
              validator: (val) {
                if (val!.isEmpty) {
                  return '';
                } else {
                  return null;
                }
              },
              enable: true,
              style: FontUtils.regular
                  .copyWith(color: ColorUtils.black38, fontSize: 13),
              pIcon: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Image.asset(
                  '${kimagePath}Vector (1).png',
                  scale: 4,
                ),
              ),
              hintText: VariableUtils.employeename,
              hintStyle: FontUtils.regular
                  .copyWith(color: ColorUtils.white9E, fontSize: 13),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                showModalBottomSheet(
                  shape: const UnderlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  isDismissible: true,
                  context: context,
                  builder: (BuildContext context) {
                    return ListView.separated(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectRole = index;
                              role[selectRole];
                              selectRoleController.text = role[selectRole];
                            });
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('${role[index]}'),
                                ]),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: role.length,
                    );
                  },
                );
              },
              child: CustomTextField(
                controller: selectRoleController,
                sIcon: Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 30,
                  color: ColorUtils.blueF2,
                ),
                enable: false,
                style: FontUtils.regular
                    .copyWith(color: ColorUtils.black38, fontSize: 13),
                pIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    '${kimagePath}Vector (2).png',
                    scale: 4,
                  ),
                ),
                hintText: VariableUtils.selectrole,
                hintStyle: FontUtils.regular
                    .copyWith(color: ColorUtils.white9E, fontSize: 13),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return CalenderWidget(
                            date: startdate,
                            datereceived: (d) {
                              startdate = d;
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorUtils.whiteE5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            '${kimagePath}Vector (3).png',
                            scale: 4,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          if (startdate.isEmpty)
                            Text(
                              "No Date",
                              style: TextStyle(
                                color: ColorUtils.white9E,
                              ),
                            ),
                          if (startdate.isNotEmpty)
                            Text(
                              startdate,
                              style: TextStyle(
                                color: ColorUtils.black38,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    '${kimagePath}arrow_right.png',
                    scale: 4,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: startdate.isEmpty
                        ? () {
                            checkValidation("Please select First Date");
                          }
                        : () async {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return CalenderWidget(
                                  date: enddate,
                                  datereceived: (d) {
                                    enddate = d;
                                    setState(() {});
                                  },
                                );
                              },
                            );
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorUtils.whiteE5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            '${kimagePath}Vector (3).png',
                            scale: 4,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          if (enddate.isEmpty)
                            Text(
                              "No Date",
                              style: TextStyle(
                                color: ColorUtils.white9E,
                              ),
                            ),
                          if (enddate.isNotEmpty)
                            Text(
                              enddate,
                              style: TextStyle(
                                color: ColorUtils.black38,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Divider(thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorUtils.blueFF,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    VariableUtils.cancel,
                    style: TextStyle(
                      color: ColorUtils.blueF2,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorUtils.blueF2,
                  ),
                  onPressed: () {
                    if (employeeNameController.text.isEmpty) {
                      checkValidation("Please enter Employee name");
                      return;
                    }
                    if (selectRoleController.text.isEmpty) {
                      checkValidation("Please select Role");
                      return;
                    }
                    if (startdate.isEmpty) {
                      checkValidation("Please select First Date");
                      return;
                    }
                    BlocProvider.of<EmployeesBloc>(context).add(
                      EmployeesAddedEvent(
                        employee: EmployeeModel(
                          role: selectRoleController.text,
                          employeeName: employeeNameController.text,
                          startDate: startdate,
                          endate: enddate,
                        ),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(VariableUtils.save),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CalenderWidget extends StatefulWidget {
  String date;
  Function(String) datereceived;
  CalenderWidget({super.key, required this.date, required this.datereceived});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate = DateTime.now();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: selectedIndex == 0
                                ? ColorUtils.blueF2
                                : ColorUtils.blueFF,
                          ),
                          onPressed: () {
                            selectedIndex = 0;
                            _focusedCalendarDate = DateTime.now();
                            selectedCalendarDate = DateTime.now();
                            setState(() {});
                          },
                          child: Text(
                            "Today",
                            style: TextStyle(
                              color: selectedIndex == 0
                                  ? Colors.white
                                  : ColorUtils.blueF2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: selectedIndex == 1
                                ? ColorUtils.blueF2
                                : ColorUtils.blueFF,
                          ),
                          onPressed: () {
                            selectedIndex = 1;
                            _focusedCalendarDate = DateTime(
                              _focusedCalendarDate.year,
                              _focusedCalendarDate.month + 1,
                              _focusedCalendarDate.day,
                            );
                            selectedCalendarDate = DateTime(
                              _focusedCalendarDate.year,
                              _focusedCalendarDate.month,
                              _focusedCalendarDate.day,
                            );
                            setState(() {});
                          },
                          child: Text(
                            "Next Month",
                            style: TextStyle(
                              color: selectedIndex == 1
                                  ? Colors.white
                                  : ColorUtils.blueF2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _focusedCalendarDate = DateTime(
                            _focusedCalendarDate.year,
                            _focusedCalendarDate.month - 1);
                        setState(() {});
                      },
                      child: Image.asset(
                        "${kimagePath}arrow_left_cal.png",
                        scale: 3,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      DateFormat('MMMM yyyy').format(_focusedCalendarDate),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        _focusedCalendarDate = DateTime(
                            _focusedCalendarDate.year,
                            _focusedCalendarDate.month + 1);
                        setState(() {});
                      },
                      child: Image.asset(
                        "${kimagePath}arrow_right_cal.png",
                        scale: 3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TableCalendar(
                  focusedDay: _focusedCalendarDate,
                  firstDay: _initialCalendarDate,
                  lastDay: _lastCalendarDate,
                  calendarFormat: CalendarFormat.month,
                  weekendDays: const [DateTime.sunday, 6],
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekHeight: 40.0,
                  rowHeight: 42.0,
                  headerVisible: false,
                  calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(color: ColorUtils.blueF2),
                    weekendTextStyle: const TextStyle(color: Colors.black),
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorUtils.blueF2),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  selectedDayPredicate: (currentSelectedDate) {
                    return (isSameDay(
                        selectedCalendarDate!, currentSelectedDate));
                  },
                  onPageChanged: (datetime) {
                    _focusedCalendarDate = datetime;
                    setState(() {});
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(selectedCalendarDate, selectedDay)) {
                      setState(() {
                        selectedCalendarDate = selectedDay;
                        _focusedCalendarDate = focusedDay;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const Divider(thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      child: Row(
                        children: [
                          Image.asset(
                            '${kimagePath}Vector (3).png',
                            scale: 4,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            DateFormat.yMMMMd().format(_focusedCalendarDate),
                            style: TextStyle(
                              color: ColorUtils.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ColorUtils.blueFF,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        VariableUtils.cancel,
                        style: TextStyle(
                          color: ColorUtils.blueF2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorUtils.blueF2,
                      ),
                      onPressed: () {
                        widget.datereceived(
                            DateFormat.yMMMMd().format(_focusedCalendarDate));
                        Navigator.of(context).pop();
                      },
                      child: Text(VariableUtils.save),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
