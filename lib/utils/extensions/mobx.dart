import 'package:mobx/mobx.dart';

// extension ObservableFutureExtension<T> on ObservableFuture<T> {
//   bool get isPending => (this?.status ?? FutureStatus.fulfilled) == FutureStatus.pending;
//   bool get isSuccess => (this?.status ?? FutureStatus.pending) == FutureStatus.fulfilled;
//   bool get isFailure => (this?.status ?? FutureStatus.fulfilled) == FutureStatus.rejected;
// }

extension ObservableFutureExtension<T> on ObservableFuture<T> {
  bool get isPending => this.status == FutureStatus.pending;
  bool get isSuccess => this.status == FutureStatus.fulfilled;
  bool get isFailure => this.status == FutureStatus.rejected;
}
