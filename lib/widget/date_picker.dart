import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:property_managment/widget/text_field.dart';


class CalendarPickerContainer extends StatefulWidget {
  final String hintText;
  final Function(DateTime)? onDateSelected;

  const CalendarPickerContainer({
    super.key,
    required this.hintText,
    this.onDateSelected,
  });

  @override
  State<CalendarPickerContainer> createState() => _CalendarPickerContainerState();
}

class _CalendarPickerContainerState extends State<CalendarPickerContainer> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        _controller.text = formattedDate;
      });

      if (widget.onDateSelected != null) {
        widget.onDateSelected!(pickedDate);
      }
    }
  }

  // TextEditingController dateCtrl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer( // prevent typing inside
        child: TextFieldContainer(
          text: widget.hintText,
          priffixIcon: const Icon(Icons.calendar_today),
          suffixIcon: const Icon(Icons.arrow_drop_down), controllerName: _controller, validator: (String? p1) {  }
        ),
      ),
    );
  }
}
