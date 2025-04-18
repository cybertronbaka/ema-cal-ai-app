import 'package:drift/drift.dart';

extension DbValueExt<T> on T {}

extension DbNullableValueExt<T> on T? {
  Value<T> toDbValue() {
    final value = this;

    if (value == null) {
      throw 'Value cannot be null';
    }

    return Value(value);
  }

  Value<T?> toDbNullableValue() => Value(this);

  Value<T> toDbValueOrAbsent() {
    final value = this;
    return value == null ? const Value.absent() : Value(value);
  }
}

extension NumToBigInt on num {
  BigInt toBigInt() => BigInt.from(this);
}

extension NullableNumToBigInt on num? {
  BigInt? toBigInt() => this?.toBigInt();
}
