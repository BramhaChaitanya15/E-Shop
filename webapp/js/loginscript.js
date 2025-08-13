//function to get element by id
function _id(name) {
    return document.getElementById(name);
}
//function to get element by class
function _class(name) {
    return document.getElementsByClassName(name);
}
//form validation function
function validate() {
    var userName = _id("email").value;
    var password = _id("password").value;
    var valid = true;
    
    //validations
    if (userName === null || userName === "") {
        nameError = "Username cannot be blank...!";
        setError(_id("email"), nameError);
        valid = false;
    } else if (!isEmail(userName)) {
        emailFormatError = "E-mail isn not valid...!";
        setError(_id("email"), emailFormatError);
        valid = false;
    } else {
        setSuccess(_id("email"));
    }

    if (password === null || password === "") {
        passwordError = "Password cannot be blank...!";
        setError(_id("password"), passwordError);
        valid = false;
    } else {
        setSuccess(_id("password"));
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

//event handling for toggling password
_class("toggle-password")[0].addEventListener("click", function () {
    _class("toggle-password")[0].classList.toggle("active");
    if (_id("password").getAttribute("type") === "password") {
        _id("password").setAttribute("type", "text");
    } else {
        _id("password").setAttribute("type", "password");
    }
});
