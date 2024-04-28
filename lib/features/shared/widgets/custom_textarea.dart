import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomTextarea extends StatefulWidget {
  const CustomTextarea({
    super.key,
    required this.value,
    required this.onChanged,
    this.hintText,
  });

  final FormControl<String> value;
  final String? hintText;

  final void Function(FormControl<String> value) onChanged;

  @override
  State<CustomTextarea> createState() => _CustomTextareaState();
}

class _CustomTextareaState extends State<CustomTextarea> {
  final TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FormControl<String> formControl = widget.value;
        formControl.markAsTouched();
        widget.onChanged(formControl);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.value = controller.value.copyWith(
      text: widget.value.value,
      selection: TextSelection.collapsed(
        offset: controller.selection.end,
      ),
    );

    return Container(
      height: 150,
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(233, 233, 233, 0.25),
            offset: Offset(15, 20),
            blurRadius: 45,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.inputBorder,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: AppColors.inputHint,
          ),
          // contentPadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
        maxLines: 10,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.input,
          height: 1.2,
        ),
        controller: controller,
        onChanged: (value) {
          FormControl<String> formControl = widget.value;
          formControl.patchValue(value);
          formControl.markAsTouched();
          widget.onChanged(formControl);

          widget.onChanged(
            formControl,
          );
        },
        focusNode: _focusNode,
      ),
    );
  }
}
