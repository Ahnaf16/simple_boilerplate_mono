import 'dart:math';

import 'package:core_functionality/core_functionality.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:shared_ui/shared_ui.dart';

class KTextField extends HookWidget {
  const KTextField({
    Key? key,
    Key? superKey,
    this.name,
    this.title,
    this.hintText,
    this.isRequired = false,
    this.isPassField = false,
    this.initialValue,
    this.validators,
    this.keyboardType,
    this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.fillColor,
    this.prefixIcon,
    this.borderRadius,
    this.textInputAction,
    this.autofocus = false,
    this.outsideSuffix,
    this.isDense = true,
    this.prefixText,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.suffixIcon,
    this.titleStyle,
    this.focusNode,
    this.valueTransformer,
    this.suffixFillColor,
    this.prefixFillColor,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
  }) : _key = key,
       super(key: superKey);

  final Key? _key;
  final String? name;
  final String? title;
  final String? hintText;
  final bool isRequired;
  final bool isPassField;
  final String? initialValue;
  final TextInputType? keyboardType;
  final List<FormFieldValidator<String>>? validators;
  final void Function(String? value)? onChanged;
  final void Function(String? value)? onSubmitted;
  final TextEditingController? controller;
  final int? maxLength;
  final int maxLines;
  final bool readOnly;
  final bool enabled;
  final Function()? onTap;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final Widget? outsideSuffix;
  final bool isDense;
  final String? prefixText;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final TextStyle? titleStyle;
  final FocusNode? focusNode;
  final dynamic Function(String? value)? valueTransformer;
  final Color? suffixFillColor;
  final Color? prefixFillColor;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  @override
  Widget build(BuildContext context) {
    final hideText = useState<bool>(true);

    final effectiveVPad = isDense ? 10.0 : 15.0;
    final effectiveHPad = prefixText != null ? 10.0 : 20.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) Text(title!, style: titleStyle ?? context.text.titleSmall).required(isRequired),
        if (title != null) const Gap(Insets.sm),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                key: _key,
                name: name ?? Random.secure().nextInt(100000).toString(),
                autofocus: autofocus,
                obscureText: isPassField ? hideText.value : false,
                initialValue: initialValue,
                controller: controller,
                inputFormatters: inputFormatters,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                maxLines: maxLines,
                maxLength: maxLength,
                readOnly: readOnly,
                focusNode: focusNode,
                enabled: enabled,
                onTap: onTap,
                onChanged: onChanged,
                onSubmitted: onSubmitted,
                valueTransformer: (value) {
                  valueTransformer?.call(value);
                  return name == null ? '' : value;
                },
                onTapOutside: (_) => InputUtils.unFocus(),
                validator: FormBuilderValidators.compose([
                  if (isRequired) FormBuilderValidators.required(),
                  ...?validators,
                ]),
                textAlign: textAlign,
                decoration: InputDecoration(
                  isDense: isDense,
                  contentPadding: Pads.sym(effectiveHPad, effectiveVPad),
                  hintText: hintText,
                  hintStyle: context.text.bodyMedium!.op(.5),
                  filled: true,
                  fillColor: fillColor,
                  prefixIcon: prefixIcon == null ? null : KIconBox(color: prefixFillColor, child: prefixIcon),
                  prefixText: prefixText,
                  prefixStyle: context.text.bodyMedium!.op(.5),
                  prefixIconConstraints: prefixIconConstraints,
                  suffixIconConstraints: suffixIconConstraints,

                  suffixIcon: !isPassField
                      ? suffixIcon
                      : GestureDetector(
                          onTap: () {
                            if (isPassField) hideText.value = !hideText.value;
                          },
                          child: KIconBox(
                            color: suffixFillColor,
                            child: Icon(hideText.value ? Icons.visibility_off_rounded : Icons.visibility_rounded),
                          ),
                        ),
                ),
              ),
            ),
            if (outsideSuffix != null) const Gap(Insets.sm),
            if (outsideSuffix != null) outsideSuffix!,
          ],
        ),
      ],
    );
  }
}

class KIconBox extends StatelessWidget {
  const KIconBox({super.key, this.color, this.child, this.size = 40, this.margin, this.padding});

  final Color? color;
  final Widget? child;
  final double size;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    if (child == null) return const SizedBox.shrink();
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: size, height: size),
      child: Center(
        child: DecoContainer(
          margin: margin ?? Pads.xs('lr'),
          padding: padding ?? Pads.sm(),
          borderRadius: Corners.circle,
          alignment: Alignment.center,
          width: size,
          height: size,
          color: color,
          child: child,
        ),
      ),
    );
  }
}
