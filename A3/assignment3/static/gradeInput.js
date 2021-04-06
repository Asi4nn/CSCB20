function validateGrade(form) {
    let mark = form.mark.value;
    if (isNaN(mark)) {
        alert("Must enter numeric value for marks!")
        return false;
    }
    if (mark < 0 || mark > 100) {
        alert("Invalid grade entered!");
        return false;
    }
    form.mark.value = mark + " " + form.getAttribute('student') + " " + form.getAttribute('asn')
    return true;
}