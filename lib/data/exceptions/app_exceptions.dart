class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "${_prefix ?? ''}${_message ?? 'An unknown error occurred'}";
  }
}

// Network error when data fetch fails
class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message ?? "Network Error: Failed to communicate with the server. Please check your internet connection and try again.", 
              "Error During Communication: ");
}

// Error for invalid or malformed requests
class BadRequestException extends AppExceptions {
  BadRequestException([String? message])
      : super(message ?? "Client Error: The request sent to the server was malformed or contained invalid parameters.", 
              "Invalid Request: ");
}

// Error for unauthorized access
class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message ?? "Authorization Error: You are not authorized to perform this action. Please log in with appropriate credentials.", 
              "Unauthorized: ");
}

// Error when a resource is not found
class NotFoundException extends AppExceptions {
  NotFoundException([String? message])
      : super(message ?? "Resource Not Found: The requested resource could not be found on the server. It may have been moved or deleted.", 
              "Not Found: ");
}

// Error for server-side issues
class InternalServerErrorException extends AppExceptions {
  InternalServerErrorException([String? message])
      : super(message ?? "Server Error: An unexpected error occurred on the server. Please try again later or contact support.", 
              "Internal Server Error: ");
}

// Error when user input is invalid
class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message])
      : super(message ?? "Validation Error: The provided input does not match the required format. Please correct the errors and try again.", 
              "Invalid Input: ");
}

// Error when a request times out
class TimeoutException extends AppExceptions {
  TimeoutException([String? message])
      : super(message ?? "Request Timeout: The server took too long to respond. Please check your connection and try again.", 
              "Timeout: ");
}

// Error when a request conflicts with the current state
class ConflictException extends AppExceptions {
  ConflictException([String? message])
      : super(message ?? "Conflict Error: The request could not be processed because of a conflict with the current state of the resource.", 
              "Conflict: ");
}

// Error when the service is unavailable
class ServiceUnavailableException extends AppExceptions {
  ServiceUnavailableException([String? message])
      : super(message ?? "Service Unavailable: The server is currently unable to handle the request. Please try again later.", 
              "Service Unavailable: ");
}

// Error when access to a resource is forbidden
class ForbiddenException extends AppExceptions {
  ForbiddenException([String? message])
      : super(message ?? "Forbidden: You do not have the necessary permissions to access this resource.", 
              "Forbidden: ");
}
