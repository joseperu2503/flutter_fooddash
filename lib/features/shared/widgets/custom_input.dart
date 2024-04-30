import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.hintText,
    this.focusNode,
    this.inputFormatters,
  });

  final FormControl<String> value;
  final String? hintText;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(FormControl<String> value) onChanged;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  final TextEditingController controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      _focusNode = widget.focusNode!;
    }

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
      height: 65,
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.input,
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
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
