import 'package:delivery_app/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputSearchAddress extends StatefulWidget {
  const InputSearchAddress({
    super.key,
    required this.value,
    required this.onChanged,
    required this.focusNode,
  });

  final String value;
  final void Function(String value) onChanged;
  final FocusNode focusNode;

  @override
  State<InputSearchAddress> createState() => _InputSearchAddressState();
}

class _InputSearchAddressState extends State<InputSearchAddress> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.value = controller.value.copyWith(
      text: widget.value,
      selection: TextSelection.collapsed(
        offset: controller.selection.end > widget.value.length
            ? widget.value.length
            : controller.selection.end,
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
      child: Row(
        children: [
          Expanded(
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
              controller: controller,
              onChanged: (value) {
                widget.onChanged(value);
              },
              focusNode: widget.focusNode,
            ),
          ),
          if (widget.value.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(right: 10),
              height: 30,
              width: 30,
              child: IconButton(
                padding: EdgeInsetsDirectional.zero,
                onPressed: () {
                  widget.onChanged('');
                },
                icon: SvgPicture.asset(
                  'assets/icons/close.svg',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
