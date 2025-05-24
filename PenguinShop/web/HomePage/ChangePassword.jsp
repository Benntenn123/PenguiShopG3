
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <jsp:include page="Common/Css.jsp" />
    </head>
    <body>
        <jsp:include page="Common/Header.jsp" />
        <section class="user-profile footer-padding">
            <div class="container">
                <div class="user-profile-section">
                    <div class="user-dashboard">
                        <jsp:include page="Common/CommonUser.jsp"/>
                        <div class="nav-content" id="v-pills-tabContent" style="flex: 1 0%;">

                            <div class="tab-pane" id="v-pills-password" role="tabpanel"
                                 aria-labelledby="v-pills-password-tab">
                                <div class="row align-items-center">
                                    <div class="col-lg-6">
                                        <div class="form-section">
                                            <form action="changepassword" method="post">
                                                <div class="currentpass form-item">
                                                    <label for="currentpass" class="form-label">Current Password*</label>
                                                    <input type="password" name="currentpass" class="form-control" id="currentpass" placeholder="******">
                                                </div>

                                                <div class="password form-item">
                                                    <label for="pass" class="form-label">Password*</label>
                                                    <input type="password" name="pass" class="form-control" id="pass" placeholder="******">
                                                </div>

                                                <div class="re-password form-item">
                                                    <label for="repass" class="form-label">Re-enter Password*</label>
                                                    <input type="password" name="repass" class="form-control" id="repass" placeholder="******">
                                                </div>

                                                <!-- Google reCAPTCHA -->
                                                <div class="g-recaptcha" data-sitekey="6LexoiArAAAAAAknmJMBGgZ0a1zuLa03LmsjDfov"></div>

                                                <div class="form-btn">
                                                    <button type="submit" class="shop-btn">Update Password</button>
                                                    <a href="#" class="shop-btn cancel-btn">Cancel</a>
                                                </div>
                                            </form>

                                            <!-- Google reCAPTCHA script -->
                                            <script src="https://www.google.com/recaptcha/api.js" async defer></script>


                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="reset-img text-end">
                                            <img src="./assets/images/homepage-one/reset.webp" alt="reset">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <jsp:include page="Common/Message.jsp" />
        <jsp:include page="Common/Footer.jsp" />
        <jsp:include page="Common/Js.jsp" />
    </body>
</html>