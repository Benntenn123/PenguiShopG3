<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="Common/Css.jsp"/>
    </head>
    <body>
        <div id="layout-wrapper">
            <fmt:setLocale value="vi_VN"/>
            <jsp:include page="Common/Header.jsp"/>
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="Common/LeftSideBar.jsp"/>
            <div class="main-content">

                <div class="page-content">
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0 font-size-18">Danh sách hóa đơn</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Hóa đơn</a></li>
                                            <li class="breadcrumb-item active">Danh sách hóa đơn</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- end page title -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Tìm kiếm hóa đơn</h5>
                                        <form method="get" action="">
                                            <div class="row g-3">
                                                <div class="col-md-4">
                                                    <label for="productName" class="form-label">Mã hóa đơn</label>
                                                    <input type="text" class="form-control" id="orderID" name="orderID" 
                                                           placeholder="Nhập mã hóa đơn..." value="${param.orderID}">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="from" class="form-label">Từ ngày</label>
                                                    <input type="date" class="form-control" id="from" name="from" 
                                                           value="${param.from}">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="to" class="form-label">Đến ngày</label>
                                                    <input type="date" class="form-control" id="to" name="to" 
                                                           value="${param.to}">
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="status" class="form-label">Trạng thái hóa đơn</label>
                                                    <select class="form-select" name="status">
                                                        <option value="">Tất cả trạng thái</option>
                                                        <option value="0" ${param.status == '0' ? 'selected' : ''}>Đã Hủy</option>
                                                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Giao hàng thành công</option>
                                                        <option value="2" ${param.status == '2' ? 'selected' : ''}>Đang Giao</option>
                                                        <option value="3" ${param.status == '3' ? 'selected' : ''}>Hoàn Hàng</option>
                                                        <option value="4" ${param.status == '4' ? 'selected' : ''}>Đang Chờ Xử Lí</option>
                                                        <option value="5" ${param.status == '5' ? 'selected' : ''}>Đã Xác Nhận</option>
                                                        
                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <label for="user" class="form-label">Người dùng</label>
                                                    <input type="number" class="form-control" id="user" name="user" 
                                                           placeholder="Nhập email..." value="${param.email}" min="0">
                                                </div>
                                            </div>
                                            <div class="row mt-3">
                                                <div class="col-12">
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="bx bx-search me-1"></i>Tìm kiếm
                                                    </button>
                                                    <button type="button" class="btn btn-light ms-2" onclick="clearForm()">
                                                        <i class="bx bx-refresh me-1"></i>Xóa bộ lọc
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-body">

                                        <!-- end row -->

                                        <div class="table-responsive">
                                            <table class="table align-middle datatable dt-responsive table-check nowrap" style="border-collapse: collapse; border-spacing: 0 8px; width: 100%;">
                                                <thead>
                                                    <tr class="bg-transparent">
                                                        <th style="width: 30px;">
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" name="check" class="form-check-input" id="checkAll">
                                                                <label class="form-check-label" for="checkAll"></label>
                                                            </div>
                                                        </th>
                                                        <th style="width: 120px;">Invoice ID</th>
                                                        <th>Date</th>
                                                        <th>Billing Name</th>
                                                        <th>Amount</th>
                                                        <th>Status</th>
                                                        <th style="width: 150px;">Download Pdf</th>
                                                        <th style="width: 90px;">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-label"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0215</a> </td>
                                                        <td>
                                                            12 Oct, 2020
                                                        </td>
                                                        <td>Connie Franco</td>

                                                        <td>
                                                            $26.30
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-success font-size-12">Paid</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>

                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-label"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0214</a> </td>
                                                        <td>
                                                            11 Oct, 2020
                                                        </td>
                                                        <td>Paul Reynolds</td>

                                                        <td>
                                                            $24.20
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-success font-size-12">Paid</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-label"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0213</a> </td>
                                                        <td>
                                                            10 Oct, 2020
                                                        </td>
                                                        <td>Ronald Patterson</td>

                                                        <td>
                                                            $20.20
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-warning font-size-12">Pending</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-label"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0212</a> </td>
                                                        <td>
                                                            09 Oct, 2020
                                                        </td>
                                                        <td>Adella Perez</td>

                                                        <td>
                                                            $16.80
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-success font-size-12">Paid</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-label"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0211</a> </td>
                                                        <td>
                                                            08 Oct, 2020
                                                        </td>
                                                        <td>Theresa Mayers</td>

                                                        <td>
                                                            $22.00
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-success font-size-12">Paid</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-label"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0210</a> </td>
                                                        <td>
                                                            07 Oct, 2020
                                                        </td>
                                                        <td>Michael Wallace</td>

                                                        <td>
                                                            $15.60
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-success font-size-12">Paid</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-label"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0209</a> </td>
                                                        <td>
                                                            06 Oct, 2020
                                                        </td>
                                                        <td>Oliver Gonzales</td>

                                                        <td>
                                                            $26.50
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-warning font-size-12">Pending</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-label"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0208</a> </td>
                                                        <td>
                                                            05 Oct, 2020
                                                        </td>
                                                        <td>David Burke</td>

                                                        <td>
                                                            $24.20
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-success font-size-12">Paid</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-label"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0207</a> </td>
                                                        <td>
                                                            04 Oct, 2020
                                                        </td>
                                                        <td>Willie Verner</td>

                                                        <td>
                                                            $21.30
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-warning font-size-12">Pending</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-labe10"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0206</a> </td>
                                                        <td>
                                                            03 Oct, 2020
                                                        </td>
                                                        <td>Felix Perry</td>

                                                        <td>
                                                            $22.60
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-success font-size-12">Paid</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-labe11"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0205</a> </td>
                                                        <td>
                                                            02 Oct, 2020
                                                        </td>
                                                        <td>Virgil Kelley</td>

                                                        <td>
                                                            $18.20
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-success font-size-12">Paid</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check font-size-16">
                                                                <input type="checkbox" class="form-check-input">
                                                                <label class="form-check-labe12"></label>
                                                            </div>
                                                        </td>

                                                        <td><a href="javascript: void(0);" class="text-body fw-medium">#MN0204</a> </td>
                                                        <td>
                                                            01 Oct, 2020
                                                        </td>
                                                        <td>Matthew Lawler</td>

                                                        <td>
                                                            $15.80
                                                        </td>
                                                        <td>
                                                            <div class="badge badge-soft-warning font-size-12">Pending</div>
                                                        </td>
                                                        <td>
                                                            <div>
                                                                <button type="button" class="btn btn-soft-light btn-sm w-xs waves-effect btn-label waves-light"><i class="bx bx-download label-icon"></i> Pdf</button>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="dropdown">
                                                                <button class="btn btn-link font-size-16 shadow-none py-0 text-muted dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                                    <i class="bx bx-dots-horizontal-rounded"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li><a class="dropdown-item" href="#">Edit</a></li>
                                                                    <li><a class="dropdown-item" href="#">Print</a></li>
                                                                    <li><a class="dropdown-item" href="#">Delete</a></li>
                                                                </ul>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- end table responsive -->
                                    </div>
                                    <!-- end card body -->
                                </div>
                                <!-- end card -->
                            </div>
                            <!-- end col -->
                        </div>
                        <!-- end row -->
                    </div> <!-- container-fluid -->
                </div>
                <!-- End Page-content -->


                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-6">
                                <script>document.write(new Date().getFullYear())</script> © Minia.
                            </div>
                            <div class="col-sm-6">
                                <div class="text-sm-end d-none d-sm-block">
                                    Design & Develop by <a href="#!" class="text-decoration-underline">Themesbrand</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>

        </div>
        <jsp:include page="Common/RightSideBar.jsp"/>
        <jsp:include page="Common/Js.jsp"/>
        <jsp:include page="Common/Message.jsp"/>
    </body>
</html>
