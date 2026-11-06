/// 成功した値 [T] か、失敗の理由 [E] のどちらかを持つ。
///
/// 失敗することを戻り値の型で表すために使う。`switch` で [Ok] と [Err] の両方を
/// 扱わないとコンパイルエラーになるため、失敗の扱いを書き忘れない。
sealed class Result<T, E> {
  const Result();
}

/// 成功。
final class Ok<T, E> extends Result<T, E> {
  const Ok(this.value);

  final T value;
}

/// 失敗。
final class Err<T, E> extends Result<T, E> {
  const Err(this.error);

  final E error;
}
