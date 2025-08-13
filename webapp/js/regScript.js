//function to get element by id
function _id(name) {
    return document.getElementById(name);
}
//function to get element by class
function _class(name) {
    return document.getElementsByClassName(name);
}
//form validation function
function checkData() {
    var fuserValue = _id("fname").value;
    var luserValue = _id("lname").value;
    var emailValue = _id("email").value;
    var passwordValue = _id("password").value;
    var cpasswordValue = _id("passwordconfirm").value;
    var phoneValue = _id("phone").value;
    var addressValue = _id("address").value;
    var valid = true;
    
    //validations
    if (fuserValue === null || fuserValue === "") {
        nameError = "First Name cannot be blank...!";
        setError(_id("fname"), nameError);
        valid = false;
    } else {
        setSuccess(_id("fname"));
    }
    if (luserValue === null || luserValue === "") {
        nameError = "Last Name cannot be blank...!";
        setError(_id("lname"), nameError);
        valid = false;
    } else {
        setSuccess(_id("lname"));
    }

    if (emailValue === null || emailValue === "") {
        emailError = "Please enter your Email...!";
        setError(_id("email"), emailError);
        valid = false;
    } else if (!isEmail(emailValue)) {
        emailFormatError = "E-mail isn not valid...!";
        setError(_id("email"), emailFormatError);
        valid = false;
    } else {
        setSuccess(_id("email"));
    }

    if (passwordValue === null || passwordValue === "") {
        passwordError = "Password cannot be blank...!";
        setError(_id("password"), passwordError);
        valid = false;
    } else if (!is8Digit(passwordValue)) {
        passError1 = "Password must have at least 8 characters...!";
        setError(_id("password"), passError1);
        valid = false;
    } else if (!isUpper(passwordValue)) {
        passError2 = "Password must have an Uppercase character...!";
        setError(_id("password"), passError2);
        valid = false;
    } else if (!isSpecial(passwordValue)) {
        passError3 = "Password must have an Special character...!";
        setError(_id("password"), passError3);
        valid = false;
    } else if (!isNumber(passwordValue)) {
        passError4 = "Password must have a Number...!";
        setError(_id("password"), passError4);
        valid = false;
    } else {
        setSuccess(_id("password"));
    }

    if (cpasswordValue === null || cpasswordValue === "") {
        cpasswordError = "Please reenter your password...!";
        setError(_id("passwordconfirm"), cpasswordError);
        valid = false;
    } else if (passwordValue !== cpasswordValue) {
        cpassError = "Password does not match...!";
        setError(_id("passwordconfirm"), cpassError);
        valid = false;
    } else {
        setSuccess(_id("passwordconfirm"));
    }

    if (phoneValue === null || phoneValue === "") {
        phoneError = "Please enter your Phone number...!";
        setError(_id("phone"), phoneError);
        valid = false;
    } else {
        setSuccess(_id("phone"));
    }

    if (addressValue === null || addressValue === "") {
        addressError = "Please enter your Address...!";
        setError(_id("address"), addressError);
        valid = false;
    } else {
        setSuccess(_id("address"));
    }

    return valid;
}

//function to set error message and icon
function setError(x, msg) {
    var parentBox = x.parentElement;
    parentBox.className = "form-group error";
    var span = parentBox.querySelector("span");
    var icon = parentBox.querySelector(".fa-solid");
    span.innerText = msg;
    icon.className = "fa-solid fa-circle-exclamation";
}

//function to set success icon
function setSuccess(x) {
    var parentBox = x.parentElement;
    parentBox.className = "form-group success";
    var span = parentBox.querySelector("span");
    var icon = parentBox.querySelector(".fa-solid");
    span.innerText = null;
    icon.className = "fa-solid fa-circle-check";
}

//function to validate email
function isEmail(e) {
    var reg = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return reg.test(e);
}
//functions to validate password
function isUpper(e) {
    var reg = /[A-Z]/;
    return reg.test(e);
}
function isSpecial(e) {
    var reg = /[^A-Za-z0-9]/;
    return reg.test(e);
}
function isNumber(e) {
    var reg = /[0-9]/;
    return reg.test(e);
}
function is8Digit(e) {
    if (e.length > 7) {
        return true;
    } else {
        return false;
    }
}

//event handling for toggling password
_class("toggle-password")[0].addEventListener("click", function () {
    _class("toggle-password")[0].classList.toggle("active");
    if (_id("password").getAttribute("type") === "password") {
        _id("password").setAttribute("type", "text");
    } else {
        _id("password").setAttribute("type", "password");
    }
});

//event handling for password validation policies
_id("password").addEventListener("focus", function () {
    _class("password-policies")[0].classList.add("active");
});

_id("password").addEventListener("blur", function () {
    _class("password-policies")[0].classList.remove("active");
});

_id("password").addEventListener("keyup", function () {
    let pass = _id("password").value;

    if (/[A-Z]/.test(pass)) {
        _class("policy-uppercase")[0].classList.add("active");
    } else {
        _class("policy-uppercase")[0].classList.remove("active");
    }
});

_id("password").addEventListener("keyup", function () {
    let pass = _id("password").value;

    if (/[0-9]/.test(pass)) {
        _class("policy-number")[0].classList.add("active");
    } else {
        _class("policy-number")[0].classList.remove("active");
    }
});

_id("password").addEventListener("keyup", function () {
    let pass = _id("password").value;

    if (/[^A-Za-z0-9]/.test(pass)) {
        _class("policy-special")[0].classList.add("active");
    } else {
        _class("policy-special")[0].classList.remove("active");
    }
});

_id("password").addEventListener("keyup", function () {
    let pass = _id("password").value;

    if (pass.length > 7) {
        _class("policy-length")[0].classList.add("active");
    } else {
        _class("policy-length")[0].classList.remove("active");
    }
});