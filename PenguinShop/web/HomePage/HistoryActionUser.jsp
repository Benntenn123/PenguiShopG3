<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp" />
        <style>
            .order-container {
                overflow: hidden;
                max-height: 130px;
                transition: max-height 0.6s ease-in-out;
                border-radius: 8px;
                margin: 10px 0;
            }

            .order-container.expanded {
                max-height: 1000px;
            }

            .hidden-detail {
                display: none;
            }

            .order-detail-item {
                background-color: white;
                padding: 15px;
                margin: 8px 0;
                border-radius: 6px;
                box-shadow: 0px 2px 4px rgba(0,0,0,0.05);
            }

            .order-detail-item p {
                margin: 5px 0;
                color: #333;
            }

            .view-more-btn {
                background-color: #AE1C9A;
                color: white;
                border: none;
                padding: 8px 20px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .view-more-btn:hover {
                background-color: #AE1C9A;
            }

            .order-wrapper {
                border: 1px solid #dee2e6;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                background-color: white;
                box-shadow: 0px 2px 6px rgba(0,0,0,0.1);
            }

            .order-date {
                color: #6c757d;
                font-size: 0.9em;
            }

            .order-info {
                margin: 15px 0;
                line-height: 1.6;
            }

            /* Date Filter Styles */
            .filter-section {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: 0px 2px 6px rgba(0,0,0,0.1);
                border: 1px solid #dee2e6;
            }

            .filter-row {
                display: flex;
                align-items: end;
                gap: 15px;
                flex-wrap: wrap;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                min-width: 200px;
            }

            .filter-group label {
                font-weight: 500;
                margin-bottom: 5px;
                color: #333;
                font-size: 14px;
            }

            .filter-group input[type="date"] {
                padding: 8px 12px;
                border: 1px solid #dee2e6;
                border-radius: 4px;
                font-size: 14px;
                transition: border-color 0.3s;
            }

            .filter-group input[type="date"]:focus {
                outline: none;
                border-color: #AE1C9A;
                box-shadow: 0 0 0 2px rgba(174, 28, 154, 0.1);
            }

            .filter-btn {
                background-color: #AE1C9A;
                color: white;
                border: none;
                padding: 10px 25px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
                height: fit-content;
            }

            .filter-btn:hover {
                background-color: #8e1680;
            }

            .reset-btn {
                background-color: #6c757d;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                transition: background-color 0.3s;
                height: fit-content;
            }

            .reset-btn:hover {
                background-color: #5a6268;
            }

            /* Pagination styles */
            .pagination-container {
                display: flex;
                justify-content: center;
                margin: 30px 0;
            }

            .pagination {
                display: flex;
                list-style: none;
                padding: 0;
                margin: 0;
                align-items: center;
            }

            .pagination li {
                margin: 0 3px;
            }

            .pagination li a {
                display: flex;
                align-items: center;
                justify-content: center;
                min-width: 40px;
                height: 40px;
                border: 1px solid #dee2e6;
                border-radius: 4px;
                text-decoration: none;
                color: #333;
                font-weight: 500;
                transition: all 0.3s ease;
                padding: 0 10px;
            }

            .pagination li.active a {
                background-color: #AE1C9A;
                color: white;
                border-color: #AE1C9A;
            }

            .pagination li a:hover:not(.active) {
                background-color: #f8f9fa;
                border-color: #AE1C9A;
            }

            .pagination .prev a, .pagination .next a {
                width: auto;
                padding: 0 15px;
            }

            .pagination .disabled a {
                color: #adb5bd;
                pointer-events: none;
                background-color: #f8f9fa;
                border-color: #e9ecef;
            }

            .pagination .dots {
                padding: 0 5px;
                color: #6c757d;
            }

            .order-wrapper {
                overflow: hidden;
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .filter-row {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-group {
                    min-width: auto;
                }

                .pagination {
                    flex-wrap: wrap;
                    gap: 5px;
                }
            }
        </style>
    </head>
    <body>
        <!--------------- header-section --------------->
        <jsp:include page="Common/Header.jsp" />

        <!---------------user-profile-section--------------->
        <section class="user-profile footer-padding">
            <div class="container">
                <div class="user-profile-section">
                    <div class="user-dashboard">

                        <jsp:include page="Common/CommonUser.jsp" />
                        <div class="nav-content" id="v-pills-tabContent" style="flex: 1 0%;">
                        <div class="tab-pane" id="v-pills-ticket" role="tabpanel"
                            aria-labelledby="v-pills-ticket-tab" tabindex="0">
                            <div class="support-ticket">
<!--                                <a href="#" class="shop-btn" onclick="modalAction('.ticket')">Add New Support</a>-->

                                <!-- Date Filter Section -->
                                <div class="filter-section">
                                    <form method="GET" action="logUser">
                                        <div class="filter-row">
                                            <div class="filter-group">
                                                <label for="from">Từ ngày:</label>
                                                <input type="date" id="from" name="from" value="${param.from != null ? param.from : ''}">
                                            </div>
                                            <div class="filter-group">
                                                <label for="to">Đến ngày:</label>
                                                <input type="date" id="to" name="to" value="${param.to != null ? param.to : ''}">
                                            </div>
                                            <button type="submit" class="filter-btn">Lọc</button>
                                            <button type="button" class="reset-btn" onclick="resetFilter()">Đặt lại</button>
                                        </div>
                                    </form>
                                </div>

                                <!-- ticket-modal -->
                                <div class="modal-wrapper ticket">
                                    <div onclick="modalAction('.ticket')" class="anywhere-away"></div>

                                    <!-- change this -->
                                    <div class="login-section account-section modal-main">
                                        <div class="review-form">
                                            <div class="review-content">
                                                <h5 class="comment-title">Add New Ticket</h5>
                                                <div class="close-btn">
                                                    <img src="./assets/images/homepage-one/close-btn.png"
                                                        onclick="modalAction('.ticket')" alt="close-btn">
                                                </div>
                                            </div>
                                            <div class="review-form-name address-form">
                                                <label for="ticket" class="form-label">First Name*</label>
                                                <input type="text" id="ticket" class="form-control" placeholder="Name">
                                            </div>
                                            <div class=" account-inner-form">
                                                <div class="review-form-name">
                                                    <label for="ticketaddress" class="form-label">Email Address*</label>
                                                    <input type="email" id="ticketaddress" class="form-control"
                                                        placeholder="email@gmail.com">
                                                </div>
                                                <div class="review-form-name">
                                                    <label for="ticketphone" class="form-label">Phone Number*</label>
                                                    <input type="tel" id="ticketphone" class="form-control"
                                                        placeholder="******">
                                                </div>
                                            </div>
                                            <div class="review-form-name address-form">
                                                <label for="ticketmassage" class="form-label">Description*</label>
                                                <textarea name="ticketmassage" id="ticketmassage" cols="10" rows="3"
                                                    class="form-control"
                                                    placeholder="Write Here your Description"></textarea>
                                            </div>
                                            <div class="login-btn text-center">
                                                <a href="#" onclick="modalAction('.ticket')" class="shop-btn">Add Ticekt
                                                    Now</a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- change this -->

                                </div>
                                <div class="ticket-section">
                                    <table>
                                        <tbody>

                                            <tr class="table-row table-top-row">
                                                <td class="table-wrapper">
                                                    <h5 class="table-heading">LOG ID</h5>
                                                </td>
                                                <td class="table-wrapper">
                                                    <div class="table-wrapper-center">
                                                        <h5 class="table-heading">THỜI GIAN</h5>
                                                    </div>
                                                </td>
                                                <td class="table-wrapper">
                                                    <div class="table-wrapper-center">
                                                        <h5 class="table-heading">HÀNH ĐỘNG</h5>
                                                    </div>
                                                </td>

                                            </tr>

                                            <c:forEach var="listLogs" items="${listLogs}">
                                            <tr class="table-row ticket-row">
                                                <td class="table-wrapper">
                                                    <p class="ticker-number">${listLogs.logID}</p>
                                                </td>
                                                <td class="table-wrapper">
                                                    <div class="table-wrapper-center">
                                                        <p class="ticket-date">${listLogs.logDate}</p>
                                                    </div>
                                                </td>
                                                <td class="table-wrapper">
                                                    <div class="table-wrapper-center">
                                                        <p class="ticket-info">${listLogs.action}</p>
                                                    </div>
                                                </td>

                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <div class="pagination-container">
                                    <ul class="pagination">

                                        <!-- Previous -->
                                        <li class="prev ${currentPage == 1 ? 'disabled' : ''}">
                                            <a href="?page=${currentPage - 1}&from=${param.from}&to=${param.to}" 
                                               ${currentPage == 1 ? 'onclick="return false;"' : ''}>
                                                ‹ Trước
                                            </a>
                                        </li>

                                        <!-- Page Numbers -->
                                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                            <li class="${i == currentPage ? 'active' : ''}">
                                                <a href="?page=${i}&from=${param.from}&to=${param.to}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- Next -->
                                        <li class="next ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a href="?page=${currentPage + 1}&from=${param.from}&to=${param.to}" 
                                               ${currentPage == totalPages ? 'onclick="return false;"' : ''}>
                                                Sau ›
                                            </a>
                                        </li>

                                    </ul>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--------------- footer-section --------------->
        <jsp:include page="Common/Footer.jsp" />

        <script>
            // Reset filter inputs and reload page without parameters
            function resetFilter() {
                document.getElementById('from').value = '';
                document.getElementById('to').value = '';
                window.location.href = window.location.pathname;
            }

            // Set max date = today for both date inputs
            document.addEventListener('DOMContentLoaded', function() {
                const today = new Date().toISOString().split('T')[0];
                document.getElementById('from').setAttribute('max', today);
                document.getElementById('to').setAttribute('max', today);
            });
        </script>

    </body>
</html>
