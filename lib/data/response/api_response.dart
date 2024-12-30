import 'status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  // Named constructor for loading state
  ApiResponse.loading() : status = Status.LOADING;

  // Named constructor for completed state
  ApiResponse.success(this.data) : status = Status.SUCCESS;

  // Named constructor for error state
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Data: $data";
  }
}
