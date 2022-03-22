emailValidation(String? email, errorText) {
  return (email!.isEmpty ||
          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(email))
      ? errorText
      : null;
}

notEmptyField(String? value, minChar, errorText) {
  return value!.isEmpty || value.length < minChar ? errorText : null;
}
