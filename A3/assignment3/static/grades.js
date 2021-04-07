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
    return true;
}

function submitRemarkRequest(form) {
    if (jQuery.trim(form.reason.value)) {
        alert("Remark request submitted for " + form.reason.id);
        return true;
    }
    alert("Must provide reason for remark!");
    return false;
}