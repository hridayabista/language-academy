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
<title>Academy Language Center - Users</title>
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
			<li><a
				href="<%=request.getContextPath()%>/pages/staffs/staffs.jsp"><i
					class="bx bxs-user-rectangle"></i>Staffs</a></li>
			<li><a
				href="<%=request.getContextPath()%>/pages/contact/contact.jsp"><i
					class="bx bx-phone"></i>Contact</a></li>
			<li class="active"><a href="#"><i class="bx bx-user-circle"></i>User</a></li>
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

		<!-- Add User Section -->
		<main>
			<div class="header">
				<div class="left">
					<h1>
						Dashboard <span>/ Users</span>
					</h1>
				</div>
				<a href="<%=request.getContextPath()%>/index.jsp" class="report">
					<span>Academy Language Center</span>
				</a>
			</div>

			<!-- Add User Form -->
			<div class="add-user-container">
				<h2>Add New User</h2>
				<form action="<%=request.getContextPath()%>/AddUserServlet"
					method="POST">
					<label for="username">Username:</label> <input type="text"
						id="username" name="username" required /> <label for="email">Email:</label>
					<input type="email" id="email" name="email" required /> <label
						for="password">Password:</label> <input type="password"
						id="password" name="password" required />

					<button type="submit">Add User</button>
				</form>
			</div>

			<!-- Users List -->
			<div class="table-container">
				<div class="table-filter">
					<div class="table-title">
						<h2>All Users</h2>
					</div>
					<div class="filter">
						<form action="<%=request.getContextPath()%>/pages/user/user.jsp"
							method="GET">
							<div class="table-input">
								<input type="text" name="search" placeholder="Search Users....."
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
						<div class="col col-2">Username</div>
						<div class="col col-3">Email</div>
						<div class="col col-4">Action</div>
					</li>

					<!-- Fetch Users from Database -->
					<%
					Connection conn = null;
					Statement stmt = null;
					ResultSet rs = null;
					String searchQuery = request.getParameter("search");
					String sql = "SELECT * FROM user";

					if (searchQuery != null && !searchQuery.trim().isEmpty()) {
						sql += " WHERE username LIKE '%" + searchQuery + "%' OR email LIKE '%" + searchQuery + "%'";
					}

					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql);

						while (rs.next()) {
							int id = rs.getInt("id");
							String username = rs.getString("username");
							String email = rs.getString("email");
					%>
					<li class="table-row">
						<div class="col col-1" data-label="ID"><%=id%></div>
						<div class="col col-2" data-label="Username"><%=username%></div>
						<div class="col col-3" data-label="Email"><%=email%></div>
						<div class="col col-4" data-label="Action">
							<!-- Edit and Delete Icons -->
							<a href="#modal-opened-edit<%=id%>" class="edit-icon"><i
								class="bx bx-pencil"></i></a> <a href="#" class="delete-icon"
								onclick="confirmDelete(<%=id%>)"><i class="bx bx-trash"></i></a>

							<!-- Modal for Editing User -->
							<div class="modal-container" id="modal-opened-edit<%=id%>">
								<div class="modal">
									<div class="modal__details">
										<h1 class="modal__title">Edit User</h1>
									</div>
									<div class="user-form">
										<form action="<%=request.getContextPath()%>/EditUserServlet"
											method="POST">
											<input type="hidden" name="id" value="<%=id%>" /> <input
												type="text" name="username" value="<%=username%>" required />
											<input type="email" name="email" value="<%=email%>" required />
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
					try {
					if (rs != null)
						rs.close();
					} catch (Exception e) {
					}
					try {
					if (stmt != null)
						stmt.close();
					} catch (Exception e) {
					}
					try {
					if (conn != null)
						conn.close();
					} catch (Exception e) {
					}
					}
					%>
				</ul>
			</div>
			<div class="print-container">
				<a href="#" class="print-btn" onclick="printUsers()">Print</a>
			</div>
		</main>
	</div>

	<script>
		// Function to print the user list
		function printUsers() {
			var printContent = document.querySelector('.table-container').innerHTML;
			var originalContent = document.body.innerHTML;

			document.body.innerHTML = printContent;
			window.print();
			document.body.innerHTML = originalContent;
		}

		// Delete Confirmation
		function confirmDelete(id) {
			if (confirm('Are you sure you want to delete this user?')) {
				window.location.href = '<%=request.getContextPath()%>/DeleteUserServlet?id=' + id;
			}
		}
	</script>
</body>
</html>
