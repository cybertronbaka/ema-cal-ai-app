import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reactive_forms/reactive_forms.dart';

FormGroup useFormGroup({
  required Map<String, Object> controls,
  List<Validator<dynamic>> validators = const [],
  List<AsyncValidator<dynamic>> asyncValidators = const [],
  String debugLabel = 'useFormGroup',
  bool debug = false,
}) {
  final formGroup = useMemoized(() {
    if (debug) debugPrint('$debugLabel: Memoizing');
    return fb.group(controls, validators, asyncValidators);
  }, []);

  useEffect(() => formGroup.dispose, []);

  return formGroup;
}
