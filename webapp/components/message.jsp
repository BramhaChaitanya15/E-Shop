<%  /* calling message froms session created in servlets
    adn storing it in message string
    used for success message*/
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {

%>

<!-- bootstrap component for warning/success/danger or alert -->
<div class="alert alert-success alert-dismissible fade show" role="alert">
    <strong><%= successMessage%></strong>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%
        session.removeAttribute("successMessage");
    }
%>
<%    /* calling message froms session created in Servlet
    adn storing it in message string
    used for warning message*/
    String warMessage = (String) session.getAttribute("warMessage");
    if (warMessage != null) {

%>

<!-- bootstrap component for warning/success/danger or alert -->
<div class="alert alert-warning alert-dismissible fade show" role="alert">
    <strong><%= warMessage%></strong>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%
        session.removeAttribute("warMessage");
    }

%>

<%    /* calling message froms session created in Servlet
    adn storing it in message string
    used for danger message*/
    String errMessage = (String) session.getAttribute("errorMessage");
    if (errMessage != null) {

%>

<!-- bootstrap component for warning/success/danger or alert -->
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    <strong><%= errMessage%></strong>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%
        session.removeAttribute("errorMessage");
    }
%>