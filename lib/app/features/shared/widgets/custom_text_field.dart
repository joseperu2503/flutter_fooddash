import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddash/app/config/constants/app_colors.dart';
import 'package:fooddash/app/features/shared/plugins/formx/formx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddash/app/features/shared/widgets/custom_label.dart';

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
    this.label,
    this.isPassword = false,
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
  final String? label;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    setValue();

    _effectiveFocusNode.addListener(() {
      if (!_effectiveFocusNode.hasFocus) {
        widget.onChanged(widget.value.touch());
      }
    });
  }

  @override
  void dispose() {
    _effectiveFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    //actualiza el controller cada vez que el valor se actualiza desde afuera
    setValue();
    super.didUpdateWidget(oldWidget);
  }

  setValue() {
    if (widget.value.value != _controller.value.text) {
      _controller.value = _controller.value.copyWith(
        text: widget.value.value,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.label != null)
              CustomLabel(
                widget.label!,
              ),
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
              child: Row(
                children: [
                  Expanded(
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
                        suffixIcon: (widget.isPassword)
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      showPassword
                                          ? 'assets/icons/eye.svg'
                                          : 'assets/icons/eye_closed.svg',
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.gray600,
                                        BlendMode.srcIn,
                                      ),
                                      width: 22,
                                      height: 22,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.input,
                      ),
                      controller: _controller,
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
                      obscureText: widget.isPassword && !showPassword,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (widget.value.errorMessage != null && widget.value.touched)
          Positioned(
            bottom: -20,
            child: Container(
              padding: const EdgeInsets.only(left: 6),
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
          ),
      ],
    );
  }
}
