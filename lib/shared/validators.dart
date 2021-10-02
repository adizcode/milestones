String? emptyTextValidator(String? value) {
  return (value?.trim().length ?? 0) == 0 ? 'Please enter something' : null;
}
