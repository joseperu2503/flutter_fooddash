import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class InputSearchAddress extends StatefulWidget {
  const InputSearchAddress({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final void Function(String value) onChanged;

  @override
  State<InputSearchAddress> createState() => _InputSearchAddressState();
}

class _InputSearchAddressState extends State<InputSearchAddress> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.value = controller.value.copyWith(
      text: widget.value,
      selection: TextSelection.collapsed(
        offset: controller.selection.end,
      ),
    );

    return Container(
      height: 51,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.gray50,
        border: Border.all(
          color: const Color(0xffEFEFEF),
        ),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: 'Search address',
          hintStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: AppColors.inputHint,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
        ),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.input,
        ),
        autofocus: true,
        controller: controller,
        onChanged: (value) {
          widget.onChanged(value);
        },
      ),
    );
  }
}
