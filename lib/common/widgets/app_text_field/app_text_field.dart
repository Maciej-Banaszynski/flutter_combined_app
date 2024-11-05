import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends HookWidget {
  const AppTextField({
    super.key,
    required this.textInputAction,
    required this.labelText,
    this.obscureText = false,
    this.onChanged,
    this.isRequired = true,
    this.displayError,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.suffixIcon,
    this.onSubmitted,
    this.autocorrect = true,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.shouldRejectWhiteSpaces = false,
    this.autofillHints,
  });

  final TextInputAction textInputAction;
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final void Function(String)? onChanged;
  final bool isRequired;
  final TextInputType keyboardType;
  final dynamic displayError;
  final Widget? suffixIcon;
  final void Function(String)? onSubmitted;
  final bool autocorrect;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final bool shouldRejectWhiteSpaces;
  final List<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    final state = useAppTextFieldState();
    final isInputVisible = useState(!obscureText);
    return TextField(
      autofillHints: autofillHints ?? [],
      inputFormatters: shouldRejectWhiteSpaces
          ? [
              FilteringTextInputFormatter.deny(
                RegExp(r'\s'),
              ),
            ]
          : [],
      focusNode: state.focusNode,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        isDense: true,
        labelText: labelText,
        errorText: state.shouldValidate ? errorText : null,
        suffixIcon: suffixIcon ?? _visibilityButton(isInputVisible),
      ),
      autocorrect: autocorrect,
      obscureText: !isInputVisible.value,
      onChanged: onChanged,
      keyboardType: keyboardType,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
    );
  }

  Widget _visibilityButton(ValueNotifier<bool> isInputVisible) {
    return obscureText
        ? Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: IconButton(
              icon: Icon(isInputVisible.value ? Icons.visibility : Icons.visibility_off),
              style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  backgroundColor: Colors.transparent),
              iconSize: 24.r,
              onPressed: () => isInputVisible.value = !isInputVisible.value,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget get errorIcon {
    return errorText != null
        ? Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: Icon(
              Icons.error,
              size: 24.r,
            ),
          )
        : const SizedBox.shrink();
  }
}

class AppTextFieldState {
  AppTextFieldState({
    required this.shouldValidate,
    required this.focusNode,
  });

  final bool shouldValidate;
  final FocusNode focusNode;
}

AppTextFieldState useAppTextFieldState() {
  final focusNode = useFocusNode();

  final shouldValidate = useState<bool>(false);

  useEffect(() {
    listener() {
      if (!focusNode.hasFocus) {
        shouldValidate.value = true;
      }
    }

    focusNode.addListener(listener);
    return () => focusNode.removeListener(listener);
  });

  return AppTextFieldState(
    shouldValidate: shouldValidate.value,
    focusNode: focusNode,
  );
}
