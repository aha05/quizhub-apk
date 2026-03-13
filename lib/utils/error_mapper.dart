String mapErrorToMessage(int statusCode, Map<String, dynamic>? body) {
  final Map<int, String> errorMessages = {
    400: "Invalid request.",
    401: "Incorrect email or password.",
    403: "You do not have permission to perform this action.",
    404: "Requested resource not found.",
    500: "Internal server error. Please try again later.",
  };

  // If backend sends a specific message
  if (body != null && body.containsKey('error')) {
    return body['error'];
  }

  // Fallback to predefined messages
  if (errorMessages.containsKey(statusCode)) {
    return errorMessages[statusCode]!;
  }

  return "Something went wrong. Please try again.";
}