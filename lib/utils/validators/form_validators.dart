class FormValidators {

  FormValidators._();
 static String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
    return 'Enter a valid 10-digit phone number';
  }
  return null;
}
static String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}
static String? textValidator(String? value,String label) {
  if (value == null || value.trim().isEmpty) {
    return label;
  }
  return null;
}

static String? ageValidator(value){
 
                        if (value == null || value.isEmpty) {
                          return 'Please enter age';
                        } else if (int.tryParse(value) == null) {
                          return 'Enter a valid number';
                        }
                        return null;


}

}

