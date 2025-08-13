//js function to toggle between user editing and user view
$(document).ready(function () {
    let editStatus = false;
    $('#edit-profile-button').click(function () {

        if (editStatus === false) {
            $("#profile-details").hide();

            $("#profile-edit").show();
            editStatus = true;
            $(this).text("Back");
        } else {
            $("#profile-details").show();

            $("#profile-edit").hide();
            editStatus = false;
            $(this).text("Edit Profile");
        }

    });
});

