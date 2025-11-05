import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:property_managment/widget/text_field.dart';

class CalendarPickerContainer extends FormField<DateTime> {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<DateTime>? validator;
  final Function(DateTime)? onDateSelected;
  CalendarPickerContainer({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onDateSelected,
  }) : super(
         validator: validator,
         builder: (FormFieldState<DateTime> state) {
          //  final TextEditingController controller = controller;

           if (state.value != null) {
             controller.text = DateFormat('dd/MM/yyyy').format(state.value!);
           }

           Future<void> selectDate(BuildContext context) async {
             DateTime? pickedDate = await showDatePicker(
               context: context,
               initialDate: state.value ?? DateTime.now(),
               firstDate: DateTime(2000),
               lastDate: DateTime(2100),
             );

             if (pickedDate != null) {
               controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
               state.didChange(pickedDate); // important for validation

               if (onDateSelected != null) {
                 onDateSelected(pickedDate);
               }
             }
           }

           return GestureDetector(
             onTap: () => selectDate(state.context),
             child: AbsorbPointer(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   TextFieldContainer(
                     text: hintText,
                     priffixIcon: const Icon(Icons.calendar_today),
                     suffixIcon: const Icon(Icons.arrow_drop_down),
                     controllerName: controller,
                     validator: (_) => null, // handled by FormField below
                   ),
                   if (state.hasError)
                     Padding(
                       padding: const EdgeInsets.only(left: 12, top: 5),
                       child: Text(
                         state.errorText ?? '',
                         style: const TextStyle(
                           color: Colors.red,
                           fontSize: 12,
                         ),
                       ),
                     ),
                 ],
               ),
             ),
           );
         },
       );
}
