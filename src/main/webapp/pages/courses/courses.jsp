<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/courses.css" />
<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
	rel="stylesheet" />
<title>Academy Language Center</title>
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
			<li><a href="${pageContext.request.contextPath}/index.jsp"><i
					class="bx bxs-dashboard"></i>Dashboard</a></li>
			<li class="active"><a
				href="${pageContext.request.contextPath}/pages/courses/courses.jsp"><i
					class="bx bx-book"></i>Courses</a></li>
			<li><a
				href="${pageContext.request.contextPath}/pages/students/students.jsp"><i
					class="bx bx-user"></i>Students</a></li>
			<li><a
				href="${pageContext.request.contextPath}/pages/staffs/staffs.jsp"><i
					class="bx bxs-user-rectangle"></i>Staffs</a></li>
			<li><a
				href="${pageContext.request.contextPath}/pages/contact/contact.jsp"><i
					class="bx bx-phone"></i>Contact</a></li>
			<li><a
				href="${pageContext.request.contextPath}/pages/user/user.jsp"><i
					class="bx bx-user-circle"></i>User</a></li>
		</ul>
		<ul class="side-menu">
			<li><a href="#" class="logout"> <i
					class="bx bx-log-out-circle"></i> Logout
			</a></li>
		</ul>
	</div>
	<!-- End of Sidebar -->

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
				class="profile"> <img
				src="${pageContext.request.contextPath}/assets/img/logo.png" />
			</a>
		</nav>

		<!-- End of Navbar -->

		<main>
			<div class="header">
				<div class="left">
					<h1>
						Dashboard <span>/ Courses</span>
					</h1>
				</div>
				<a href="${pageContext.request.contextPath}/index.jsp"
					class="report"> <span>Academy Language Center</span>
				</a>
			</div>

			<!-- Add Courses -->
			<div class="add-course">
				<div class="add-left">
					<h3>Add Course</h3>
				</div>
				<div class="add-right">
					<a href="#modal-opened" class="link-1" id="modal-closed"> <i
						class="bx bxs-book-add"></i>Add Course
					</a>

					<div class="modal-container" id="modal-opened">
						<div class="modal">
							<div class="modal__details">
								<h1 class="modal__title">Add Course</h1>
							</div>

							<div class="course-form">
								<!-- Correct form submission to servlet -->
								<form action="<%=request.getContextPath()%>/addCourse"
									method="POST">
									<input type="text" name="course_name"
										placeholder="Enter Course Name" required> <input
										type="number" name="course_fee" placeholder="Enter Course Fee"
										required>
									<!-- Button to submit the form -->
									<button type="submit" class="modal__btn">Add Course</button>
								</form>
							</div>

							<a href="#modal-closed" class="link-2"></a>
						</div>
					</div>
				</div>
			</div>

			<!-- End of Add Courses -->

			<!-- Course Card -->
			<%@ page import="java.sql.*, java.util.*"%>
			<%
			// Database connection setup
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");

			// Query to fetch all courses
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM courses");
			%>

			<div class="ag-format-container">
				<div class="ag-courses_box">
					<%
					while (rs.next()) {
						String courseId = rs.getString("id");
						String courseName = rs.getString("course_name");
						double courseFee = rs.getDouble("course_fee");
					%>
					<div class="ag-courses_item">
						<a href="#" class="ag-courses-item_link">
							<div class="ag-courses-item_bg"></div>
							<div class="ag-courses-item_title">
								<h3><%=courseName%></h3>
							</div>
							<div class="ag-courses-item_date-box">
								Fee:
								<%=courseFee%>
								<span class="ag-courses-item_date"></span>
							</div>
						</a>

						<div class="students-info">
							<a href="#modal-opened-<%=courseId%>" class="link-1 btn"
								id="modal-closed-<%=courseId%>"> <i class="bx bxs-edit"></i>Edit
								Course
							</a>
							<div class="modal-container" id="modal-opened-<%=courseId%>">
								<div class="modal">
									<div class="modal__details">
										<h1 class="modal__title">Edit Course</h1>
									</div>

									<div class="course-form">
										<form action="<%=request.getContextPath()%>/editCourse"
											method="POST">
											<input type="hidden" name="course_id" value="<%=courseId%>" />
											<input type="text" name="course_name" value="<%=courseName%>"
												placeholder="Enter Course Name" required /> <input
												type="number" name="course_fee" value="<%=courseFee%>"
												placeholder="Enter Course Fee" required />
											<button type="submit" class="modal__btn">Edit Course</button>
										</form>
									</div>

									<a href="#modal-closed-<%=courseId%>" class="link-2"></a>
								</div>
							</div>

							<a
								href="<%=request.getContextPath()%>/deleteCourse?course_id=<%=courseId%>"
								class="delete-course btn"> <i class="bx bxs-trash"></i>Delete
								Course
							</a>

						</div>
					</div>
					<%
					}
					rs.close();
					stmt.close();
					conn.close();
					%>
				</div>
			</div>



			<!-- End of Course Card -->
		</main>
	</div>

	<script src="${pageContext.request.contextPath}/assets/js/index.js"></script>
</body>
</html>
