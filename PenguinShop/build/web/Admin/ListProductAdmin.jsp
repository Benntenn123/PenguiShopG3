<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
        
    <body>
        <div id="layout-wrapper">
            <jsp:include page="Common/Header.jsp"/>
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="Common/LeftSideBar.jsp"/>
        </div>
        
        
        
        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
    </body>
</html>
