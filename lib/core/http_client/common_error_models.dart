abstract class CommonError implements Exception {}

class CommonErrorNoNetwork implements CommonError {
  @override
  String toString() {
    return 'No/bad internet connection';
  }
}

class CommonErrorUndefined implements CommonError {
  final String message;

  CommonErrorUndefined(this.message);

  @override
  String toString() {
    return 'Error: $message';
  }
}

class CommonFormatException implements CommonError {
  final dynamic responseData;

  CommonFormatException(this.responseData);

  @override
  String toString() {
    return 'Received response: \n "$responseData" \n which is not JSON';
  }
}

class CommonErrorUnauthorized implements CommonError {
  final String? message;

  CommonErrorUnauthorized(this.message);

  @override
  String toString() {
    return 'Authorization error: \n$message';
  }
}

class CommonErrorToManyRequests implements CommonError {
  @override
  String toString() {
    return 'Error: Too many requests';
  }
}

class CommonTypeError implements CommonError {
  final dynamic error;
  final dynamic responseData;

  CommonTypeError(this.error, this.responseData);

  @override
  String toString() =>
      'Error response from server \n $responseData \n does not match contract CommonApiError, $error';
}

class CommonApiError implements CommonError {
  final String? id;
  final String? message;
  final String? statusCode;
  final dynamic errors;

  CommonApiError(this.id, this.message, {this.statusCode, this.errors});

  factory CommonApiError.fromJson(Map<String, dynamic> json) {
    return CommonApiError(
      json['id'],
      json['message'],
      errors: json['errors'],
    );
  }

  @override
  String toString() {
    if (statusCode != null) {
      return 'StatusCode: $statusCode\nCommonApiError: \nid: $id,\nmessage: $message';
    } else {
      return "CommonApiError: \nid: $id,\nmessage: $message";
    }
  }
}

