String mapErrorToMessage(String error) {
  final Map<String, String> errorMessages = {
    '400': "Invalid email or password.",
    '401': "Incorrect email or password.",
    '403': "You do not have permission to perform this action.",
    '404': "Requested resource not found.",
    '500': "Internal Server error. Please try again later.",
    'SocketException': "No internet connection.",
    'TimeoutException': "Request timed out. Try again.",
  };

  for (final key in errorMessages.keys) {
    if (error.contains(key)) {
      return errorMessages[key]!;
    }
  }

  print(error);
  return "Something went wrong. Please try again.";
}