import 'package:flutter_fooddash/config/constants/app_colors.dart';
import 'package:flutter_fooddash/features/shared/plugins/formx/formx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.value,
    required this.onChanged,
    this.hintText,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.readOnly = false,
  });

  final FormxInput<String> value;
  final String? hintText;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(FormxInput<String> value) onChanged;
  final TextInputAction? textInputAction;
  final void Function(String value)? onFieldSubmitted;
  final bool autofocus;
  final bool readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  @override
  void initState() {
    super.initState();

    _effectiveFocusNode.addListener(() {
      if (!_effectiveFocusNode.hasFocus) {
        widget.onChanged(widget.value.touch());
      }
    });
  }

  @override
  void dispose() {
    _effectiveFocusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    //actualiza el controller cada vez que el valor se actualiza desde afuera
    if (widget.value.value != oldWidget.value.value &&
        widget.value.value != controller.value.text) {
      controller.value = controller.value.copyWith(
        text: widget.value.value,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
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
              widget.onChanged(
                widget.value.updateValue(value),
              );
            },
            focusNode: _effectiveFocusNode,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            autofocus: widget.autofocus,
            readOnly: widget.readOnly,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
          ),
        ),
        if (widget.value.errorMessage != null && widget.value.touched)
          Container(
            padding: const EdgeInsets.only(top: 6, left: 6),
            child: Text(
              '${widget.value.errorMessage}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: AppColors.error,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
      ],
    );
  }
}
