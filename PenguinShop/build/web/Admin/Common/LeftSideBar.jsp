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



                <!--                <li>
                                    <a href="javascript: void(0);" class="has-arrow">
                                        <i data-feather="user"></i>
                                        <span data-key="t-apps">Người dùng</span>
                                    </a>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="listCustomerAdmin">
                                                <span data-key="t-calendar">Danh sách người dùng</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                </li>
                                <li>
                                    <a href="javascript: void(0);" class="has-arrow">
                                        <i data-feather="shield"></i>
                                        <span data-key="t-apps">Quyền truy cập</span>
                                    </a>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="listRoleAdmin">
                                                <span data-key="t-calendar">Danh sách nhóm quyền</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="listPermission">
                                                <span data-key="t-calendar">Danh sách quyền</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                     <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="manage_role_permissions">
                                                <span data-key="t-calendar">Quản lí quyền</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                </li>
                                <li>
                                    <a href="javascript: void(0);" class="has-arrow">
                                        <i data-feather="box"></i>
                                        <span data-key="t-apps">Sản phẩm</span>
                                    </a>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="listProductAdmin">
                                                <span data-key="t-calendar">Danh sách sản phẩm</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="managevariant">
                                                <span data-key="t-calendar">Quản lí thuộc tính sản phẩm</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="listGroupProduct">
                                                <span data-key="t-calendar">Danh sách nhóm sản phẩm</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                </li>
                                <li>
                                    <a href="javascript: void(0);" class="has-arrow">
                                        <i data-feather="tag"></i>
                                        <span data-key="t-apps">Khuyến Mãi</span>
                                    </a>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="listPromotion">
                                                <span data-key="t-calendar">Danh sách khuyến mãi</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                    
                                </li>
                                <li>
                                    <a href="javascript: void(0);" class="has-arrow">
                                        <i data-feather="file"></i>
                                        <span data-key="t-apps">Hóa đơn</span>
                                    </a>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="listOrderAdmin">
                                                <span data-key="t-calendar">Danh sách hóa đơn</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                </li>
                                <li>
                                    <a href="javascript: void(0);" class="has-arrow">
                                        <i data-feather="send"></i>
                                        <span data-key="t-apps">Yêu cầu người dùng</span>
                                    </a>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="listRequestSupport">
                                                <span data-key="t-calendar">Danh sách yêu cầu người dùng</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                </li>
                                <li>
                                    <a href="javascript: void(0);" class="has-arrow">
                                        <i data-feather="clock"></i>
                                        <span data-key="t-apps">Lịch sử</span>
                                    </a>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="listProductAdmin">
                                                <span data-key="t-calendar">Lịch sử họat động</span>
                                            </a>
                                        </li>
                
                                    </ul>
                                </li>
                                <li>
                                    <a href="javascript: void(0);" class="has-arrow">
                                        <i data-feather="clock"></i>
                                        <span data-key="t-apps">Nhân sự</span>
                                    </a>
                                    <ul class="sub-menu" aria-expanded="false">
                                        <li>
                                            <a href="listSales">
                                                <span data-key="t-calendar">Danh sách nhân sự</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="addSales">
                                                <span data-key="t-calendar">Thêm nhân sự</span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>-->

            </ul>


        </div>
        <!-- Sidebar -->
    </div>
</div>
