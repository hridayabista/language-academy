<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/style.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/courses.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/students.css" />
<title>Academy Language Center - Staffs</title>
</head>
<body>
	<!-- Sidebar -->
	<div class="sidebar">
		<a href="#" class="logo"> <i class="bx bx-code-alt"></i>
			<div class="logo-name">
				<span>Academy</span>
			</div>
		</a>
		<ul class="side-menu">
			<li><a href="<%=request.getContextPath()%>/index.jsp"><i
					class="bx bxs-dashboard"></i>Dashboard</a></li>
			<li><a
				href="<%=request.getContextPath()%>/pages/courses/courses.jsp"><i
					class="bx bx-book"></i>Courses</a></li>
			<li><a
				href="<%=request.getContextPath()%>/pages/students/students.jsp"><i
					class="bx bx-user"></i>Students</a></li>
			<li class="active"><a href="#"><i
					class="bx bxs-user-rectangle"></i>Staffs</a></li>
			<li><a
				href="<%=request.getContextPath()%>/pages/contact/contact.jsp"><i
					class="bx bx-phone"></i>Contact</a></li>
			<li><a href="<%=request.getContextPath()%>/pages/user/user.jsp"><i
					class="bx bx-user-circle"></i>User</a></li>
		</ul>
		<ul class="side-menu">
			<li><a href="#" class="logout"><i
					class="bx bx-log-out-circle"></i> Logout</a></li>
		</ul>
	</div>

	<!-- Main Content -->
	<div class="content">
		<!-- Navbar -->
		<nav>
			<i class="bx bx-menu"></i>
			<form action="#">
				<div class="form-input">
					<input type="search" placeholder="Search..." />
					<button class="search-btn" type="submit">
						<i class="bx bx-search"></i>
					</button>
				</div>
			</form>
			<input type="checkbox" id="theme-toggle" hidden /> <label
				for="theme-toggle" class="theme-toggle"></label> <a href="#"
				class="profile"><img
				src="<%=request.getContextPath()%>/assets/img/logo.png" /></a>
		</nav>

		<!-- Add Staff Section -->
		<main>
			<div class="header">
				<div class="left">
					<h1>
						Dashboard <span>/ Staffs</span>
					</h1>
				</div>
				<a href="<%=request.getContextPath()%>/index.jsp" class="report">
					<span>Academy Language Center</span>
				</a>
			</div>

			<!-- Add Staff Form Modal -->
			<div class="add-course">
				<div class="add-left">
					<h3>Add Staff</h3>
				</div>
				<div class="add-right">
					<a href="#modal-opened" class="link-1" id="modal-closed"> <i
						class="bx bxs-user-plus"></i>Add Staff
					</a>

					<!-- Modal -->
					<div class="modal-container" id="modal-opened">
						<div class="modal">
							<div class="modal__details">
								<h1 class="modal__title">Add Staff</h1>
							</div>
							<div class="course-form">
								<form action="<%=request.getContextPath()%>/AddStaffServlet"
									method="POST">
									<input type="text" name="name" placeholder="Enter Staff Name"
										required /> <input type="text" name="title"
										placeholder="Enter Job Title" required /> <input
										type="number" name="salary" placeholder="Enter Salary"
										required />
									<button class="modal__btn" type="submit">Add Staff
										&rarr;</button>
								</form>
							</div>
							<a href="#modal-closed" class="link-2"></a>
						</div>
					</div>
				</div>
			</div>

			<!-- Staffs List -->
			<div class="table-container">
				<div class="table-filter">
					<div class="table-title">
						<h2>All Staffs</h2>
					</div>
					<div class="filter">
						<form
							action="<%=request.getContextPath()%>/pages/staffs/staffs.jsp"
							method="GET">
							<div class="table-input">
								<input type="text" name="search"
									placeholder="Search Staffs....."
									value="<%=request.getParameter("search")%>" />
								<button class="table-search-btn" type="submit">
									<i class="bx bx-search"></i>
								</button>
							</div>
						</form>
					</div>
				</div>

				<!-- Dynamic Table -->
				<ul class="responsive-table">
					<li class="table-header">
						<div class="col col-1">ID</div>
						<div class="col col-2">Staff Name</div>
						<div class="col col-3">Title</div>
						<div class="col col-4">Salary</div>
						<div class="col col-5">Action</div>
					</li>

					<!-- Fetch Staffs from Database -->
					<%
					Connection conn2 = null;
					Statement stmt2 = null;
					ResultSet rs2 = null;
					String searchQuery = request.getParameter("search");
					String sql2 = "SELECT * FROM staffs";

					if (searchQuery != null && !searchQuery.trim().isEmpty()) {
						sql2 += " WHERE name LIKE '%" + searchQuery + "%' OR title LIKE '%" + searchQuery + "%'";
					}

					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");
						stmt2 = conn2.createStatement();
						rs2 = stmt2.executeQuery(sql2);

						while (rs2.next()) {
							int id = rs2.getInt("id");
							String name = rs2.getString("name");
							String title = rs2.getString("title");
							double salary = rs2.getDouble("salary");
					%>
					<li class="table-row">
						<div class="col col-1" data-label="ID"><%=id%></div>
						<div class="col col-2" data-label="Staff Name"><%=name%></div>
						<div class="col col-3" data-label="Title"><%=title%></div>
						<div class="col col-4" data-label="Salary">
							$<%=salary%></div>
						<div class="col col-5" data-label="Action">
							<!-- Edit and Delete Icons -->
							<a href="#modal-opened-edit<%=id%>" class="edit-icon"> <i
								class="bx bx-pencil"></i></a> <a href="#" class="delete-icon"
								onclick="confirmDelete(<%=id%>)"><i class="bx bx-trash"></i></a>

							<!-- Modal for Editing Staff -->
							<div class="modal-container" id="modal-opened-edit<%=id%>">
								<div class="modal">
									<div class="modal__details">
										<h1 class="modal__title">Edit Staff</h1>
									</div>
									<div class="course-form">
										<form action="<%=request.getContextPath()%>/EditStaffServlet"
											method="POST">
											<input type="hidden" name="id" value="<%=id%>" /> <input
												type="text" name="name" value="<%=name%>" required /> <input
												type="text" name="title" value="<%=title%>" required /> <input
												type="number" name="salary" value="<%=salary%>" required />
											<button class="modal__btn" type="submit">Save
												Changes &rarr;</button>
										</form>
									</div>
									<a href="#modal-closed" class="link-2"></a>
								</div>
							</div>
						</div>
					</li>
					<%
					}
					} catch (Exception e) {
					e.printStackTrace();
					} finally {
					if (rs2 != null)
					try {
						rs2.close();
					} catch (SQLException ignore) {
					}
					if (stmt2 != null)
					try {
						stmt2.close();
					} catch (SQLException ignore) {
					}
					if (conn2 != null)
					try {
						conn2.close();
					} catch (SQLException ignore) {
					}
					}
					%>
				</ul>
			</div>
			<div class="print-container">
				<a href="#" class="print-btn" onclick="printStaffs()">Print</a>
			</div>
		</main>
	</div>

	<script>
        // Function to print the staff list
        function printStaffs() {
            // Open the print dialog to print the staffs list section
            var printContent = document.querySelector('.table-container').innerHTML;
            var originalContent = document.body.innerHTML;

            document.body.innerHTML = printContent; // Replace the body content with the table content
            window.print(); // Open the print dialog
            document.body.innerHTML = originalContent; // Restore the original content after printing
        }
    </script>

	<script>
        // Delete Confirmation
        function confirmDelete(id) {
            if (confirm('Are you sure you want to delete this staff member?')) {
                // Redirect to DeleteStaffServlet
                window.location.href = '<%=request.getContextPath()%>/DeleteStaffServlet?id=' + id;
            }
        }
    </script>
	<!-- Scripts -->
	<script src="<%=request.getContextPath()%>/assets/js/index.js"></script>

</body>
</html>
