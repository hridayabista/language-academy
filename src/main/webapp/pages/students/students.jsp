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
<title>Academy Language Center - Students</title>
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
			<li class="active"><a href="#"><i class="bx bx-user"></i>Students</a></li>
			<li><a
				href="<%=request.getContextPath()%>/pages/staffs/staffs.jsp"><i
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

		<!-- Add Student Section -->
		<main>
			<div class="header">
				<div class="left">
					<h1>
						Dashboard <span>/ Students</span>
					</h1>
				</div>
				<a href="<%=request.getContextPath()%>/index.jsp" class="report">
					<span>Academy Language Center</span>
				</a>
			</div>

			<!-- Add Student Form Modal -->
			<div class="add-course">
				<div class="add-left">
					<h3>Add Student</h3>
				</div>
				<div class="add-right">
					<a href="#modal-opened" class="link-1" id="modal-closed"> <i
						class="bx bxs-book-add"></i>Add Students
					</a>

					<!-- Modal -->
					<div class="modal-container" id="modal-opened">
						<div class="modal">
							<div class="modal__details">
								<h1 class="modal__title">Add Student</h1>
							</div>
							<div class="course-form">
								<form action="<%=request.getContextPath()%>/AddStudentServlet"
									method="POST">
									<input type="text" name="name" placeholder="Enter Student Name"
										required />

									<!-- Fetching courses and their fees from the database -->
									<select name="course" required>
										<%
										Connection conn = null;
										Statement stmt = null;
										ResultSet courses = null;

										try {
											Class.forName("com.mysql.cj.jdbc.Driver");
											conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");
											stmt = conn.createStatement();
											String sql = "SELECT course_name, course_fee FROM courses";
											courses = stmt.executeQuery(sql);
											while (courses.next()) {
												String courseName = courses.getString("course_name");
												double courseFee = courses.getDouble("course_fee");
										%>
										<option value="<%=courseName%>" data-fee="<%=courseFee%>"><%=courseName%>
											- $<%=courseFee%></option>
										<%
										}
										} catch (Exception e) {
										e.printStackTrace();
										} finally {
										try {
										if (courses != null)
											courses.close();
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
									</select> <input type="number" name="paid_amount"
										placeholder="Enter Paid Amount" required /> <input
										type="text" name="contact" placeholder="Enter Contact"
										required />
									<button class="modal__btn" type="submit">Add Student
										&rarr;</button>
								</form>
							</div>
							<a href="#modal-closed" class="link-2"></a>
						</div>
					</div>
				</div>
			</div>

			<!-- Students List -->
			<div class="table-container">
				<div class="table-filter">
					<div class="table-title">
						<h2>All Students</h2>
					</div>
					<div class="filter">
						<form action="<%=request.getContextPath()%>/pages/students/students.jsp"
							method="GET">
							<div class="table-input">
								<input type="text" name="search"
									placeholder="Search Students....."
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
						<div class="col col-2">Student Name</div>
						<div class="col col-3">Course</div>
						<div class="col col-4">Course Fee</div>
						<div class="col col-5">Paid Amount</div>
						<div class="col col-6">Due Amount</div>
						<div class="col col-7">Contact</div>
						<div class="col col-8">Action</div>
					</li>

					<!-- Fetch Students from Database -->
					<%
					Connection conn2 = null;
					Statement stmt2 = null;
					ResultSet rs2 = null;
					String searchQuery = request.getParameter("search");
					String sql2 = "SELECT * FROM students";

					if (searchQuery != null && !searchQuery.trim().isEmpty()) {
						sql2 += " WHERE name LIKE '%" + searchQuery + "%' OR course LIKE '%" + searchQuery + "%'";
					}

					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");
						stmt2 = conn2.createStatement();
						rs2 = stmt2.executeQuery(sql2);

						while (rs2.next()) {
							int id = rs2.getInt("id");
							String name = rs2.getString("name");
							String course = rs2.getString("course");
							double courseFee = rs2.getDouble("course_fee");
							double paidAmount = rs2.getDouble("paid_amount");
							double dueAmount = rs2.getDouble("due");
							String contact = rs2.getString("contact");
					%>
					<li class="table-row">
						<div class="col col-1" data-label="ID"><%=id%></div>
						<div class="col col-2" data-label="Student Name"><%=name%></div>
						<div class="col col-3" data-label="Course"><%=course%></div>
						<div class="col col-4" data-label="Course Fee">
							$<%=courseFee%></div>
						<div class="col col-5" data-label="Paid Amount">
							$<%=paidAmount%></div>
						<div class="col col-6" data-label="Due Amount">
							$<%=dueAmount%></div>
						<div class="col col-7" data-label="Contact"><%=contact%></div>
						<div class="col col-8" data-label="Action">
							<!-- Edit and Delete Icons -->
							<a href="#modal-opened-edit<%=id%>" class="edit-icon"> <i
								class="bx bx-pencil"></i></a> <a href="#" class="delete-icon"
								onclick="confirmDelete(<%=id%>)"><i class="bx bx-trash"></i></a>

							<!-- Modal for Editing Student -->
							<div class="modal-container" id="modal-opened-edit<%=id%>">
								<div class="modal">
									<div class="modal__details">
										<h1 class="modal__title">Edit Student</h1>
									</div>
									<div class="course-form">
										<form
											action="<%=request.getContextPath()%>/EditStudentServlet"
											method="POST">
											<input type="hidden" name="id" value="<%=id%>" /> <input
												type="text" name="name" value="<%=name%>" required /> <select
												name="course" required>
												<%
												try {
													conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");
													stmt = conn.createStatement();
													String sql = "SELECT course_name, course_fee FROM courses";
													courses = stmt.executeQuery(sql);
													while (courses.next()) {
														String courseName = courses.getString("course_name");
														courseFee = courses.getDouble("course_fee");
												%>
												<option value="<%=courseName%>"
													<%=course.equals(courseName) ? "selected" : ""%>>
													<%=courseName%> - $<%=courseFee%>
												</option>
												<%
												}
												} catch (Exception e) {
												e.printStackTrace();
												} finally {
												try {
												if (courses != null)
													courses.close();
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
											</select> <input type="number" name="paid_amount"
												value="<%=paidAmount%>" required /> <input type="text"
												name="contact" value="<%=contact%>" required />
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
					if (rs2 != null)
						rs2.close();
					} catch (Exception e) {
					}
					try {
					if (stmt2 != null)
						stmt2.close();
					} catch (Exception e) {
					}
					try {
					if (conn2 != null)
						conn2.close();
					} catch (Exception e) {
					}
					}
					%>
				</ul>
			</div>
			<div class="print-container">
				<a href="#" class="print-btn" onclick="printStudents()">Print</a>
			</div>
		</main>
	</div>

	<script>
	    // Function to print the student list
	    function printStudents() {
	        // Open the print dialog to print the students list section
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
			if (confirm('Are you sure you want to delete this student?')) {
				// Redirect to DeleteStudentServlet
				window.location.href = '<%=request.getContextPath()%>/DeleteStudentServlet?id=' + id;
			}
		}
	</script>
	<!-- Scripts -->
	<script>
		document
				.querySelectorAll('select[name="course"]')
				.forEach(
						function(select) {
							select
									.addEventListener(
											'change',
											function() {
												var selectedOption = select.options[select.selectedIndex];
												var courseFee = selectedOption
														.getAttribute('data-fee');
												console.log(
														"Selected Course Fee:",
														courseFee);
											});
						});
	</script>

	<script src="${pageContext.request.contextPath}/assets/js/index.js"></script>

</body>
</html>
