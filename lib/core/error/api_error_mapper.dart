class ApiErrorMapper {
  static String message(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid input';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'You do not have permission';
      case 404:
        return 'Resource not found';
      case 409:
        return 'Already exists';
      case 422:
        return 'Invalid data';
      case 500:
        return 'Server error';
      default:
        return 'Something went wrong';
    }
  }
}
