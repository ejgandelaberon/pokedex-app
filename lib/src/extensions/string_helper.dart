extension StringHelper on String {
  bool isSnakeCase() {
    return RegExp(r'^[a-z0-9]+(_[a-z0-9]+)*$').hasMatch(this);
  }

  bool isCamelCase() {
    return RegExp(r'^[a-z0-9]+([A-Z][a-z0-9]+)*$').hasMatch(this);
  }
}