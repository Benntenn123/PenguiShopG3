<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="vertical-menu">

    <div data-simplebar class="h-100">

        <!--- Sidemenu -->
        <div id="sidebar-menu">
            <!-- Left Menu Start -->
            <ul class="metismenu list-unstyled" id="side-menu">
                <li class="menu-title" data-key="t-menu">Menu</li>
                <c:forEach var="entry" items="${sessionScope.menu}">
                    <li>
                        <a href="javascript:void(0);" class="has-arrow">
                            <i data-feather="${entry.key.icon}"></i>
                            <span>${entry.key.moduleName}</span>
                        </a>
                        <ul class="sub-menu" aria-expanded="false">
                            <c:forEach var="per" items="${entry.value}">
                                <c:if test="${per.isHide == 0}">
                                    <li>
                                        <a href="/PenguinShop${per.url_permisson}">
                                            <span>${per.permissionName}</span>
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <!-- Sidebar -->
    </div>
</div>
