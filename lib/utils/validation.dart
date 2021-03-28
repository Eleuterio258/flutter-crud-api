String emailValidation(String value) {
  if (value.isEmpty) {
    return "*Campo Required";
  }
  if (value.length < 5) {
    return "O Valor minimo e de 5 letras";
  }
  if (value.contains("@") || value.contains(".")) {
    return "O Valor minimo e de 5 letras";
  }

  return null;
}

String fistNameValidation(String value) {
  if (value.isEmpty) {
    return "*Campo Required";
  }

  if (value.length < 5) {
    return "O Valor minimo e de 5 letras";
  }

  return null;
}

String lastNameValidation(String value) {
  if (value.isEmpty) {
    return "*Campo Required";
  }
  if (value.length < 5) {
    return "O Valor minimo e de 5 letras";
  }
  return null;
}
