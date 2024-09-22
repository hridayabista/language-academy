<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>

<%
    // Database connection
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Variables for counts and financials
    int totalStudents = 0, totalCourses = 0, totalStaffs = 0;
    double totalIncome = 0, totalExpenses = 0, totalProfit = 0;

    try {
        // Load and register the driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish the connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");

        // Get total number of students
        String studentQuery = "SELECT COUNT(*) FROM students";
        ps = conn.prepareStatement(studentQuery);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalStudents = rs.getInt(1);
        }

        // Get total number of courses
        String courseQuery = "SELECT COUNT(*) FROM courses";
        ps = conn.prepareStatement(courseQuery);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalCourses = rs.getInt(1);
        }

        // Get total number of staff
        String staffQuery = "SELECT COUNT(*) FROM staffs";
        ps = conn.prepareStatement(staffQuery);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalStaffs = rs.getInt(1);
        }

        // Calculate total income (sum of paid_amount)
        String incomeQuery = "SELECT SUM(paid_amount) FROM students";
        ps = conn.prepareStatement(incomeQuery);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalIncome = rs.getDouble(1);
        }

        // Calculate total expenses (sum of due)
        String expenseQuery = "SELECT SUM(due) FROM students";
        ps = conn.prepareStatement(expenseQuery);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalExpenses = rs.getDouble(1);
        }

        // Calculate profit/loss (income - expenses)
        totalProfit = totalIncome - totalExpenses;

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css" />
    <title>Academy Language Center</title>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
            <i class="bx bx-code-alt"></i>
            <div class="logo-name">
                <span>Academy</span>
            </div>
        </a>
        <ul class="side-menu">
            <li class="active"><a href="${pageContext.request.contextPath}/index.jsp"><i class="bx bxs-dashboard"></i>Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/courses/courses.jsp"><i class="bx bx-book"></i>Courses</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/students/students.jsp"><i class="bx bx-user"></i>Students</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/staffs/staffs.jsp"><i class="bx bxs-user-rectangle"></i>Staffs</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/contact/contact.jsp"><i class="bx bx-phone"></i>Contact</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/user/user.jsp"><i class="bx bx-user-circle"></i>User</a></li>
        </ul>
        <ul class="side-menu">
            <li><a href="${pageContext.request.contextPath}/pages/auth/auth.jsp" class="logout"> <i class="bx bx-log-out-circle"></i> Logout </a></li>
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
            <input type="checkbox" id="theme-toggle" hidden /> 
            <label for="theme-toggle" class="theme-toggle"></label> 
            <a href="#" class="profile"> 
                <img src="${pageContext.request.contextPath}/assets/img/logo.png" />
            </a>
        </nav>
        <!-- End of Navbar -->

        <main>
            <div class="header">
                <div class="left">
                    <h1>Dashboard</h1>
                </div>
                <a href="${pageContext.request.contextPath}/index.jsp" class="report"> <span>Academy Language Center</span> </a>
            </div>

            <!-- Insights -->
            <ul class="insights">
                <li><i class="bx bx-user"></i> 
                    <span class="info">
                        <h3><%= totalStudents %></h3>
                        <p>Total Students</p>
                    </span>
                </li>
                <li><i class="bx bx-book"></i> 
                    <span class="info">
                        <h3><%= totalCourses %></h3>
                        <p>Total Courses</p>
                    </span>
                </li>
                <li><i class="bx bxs-user-rectangle"></i> 
                    <span class="info">
                        <h3><%= totalStaffs %></h3>
                        <p>Total Staffs</p>
                    </span>
                </li>
            </ul>

            <h2>Daily Income, Expenses, and Profit/Loss</h2>
            <ul class="insights">
                <li><i class="bx bx-money"></i> 
                    <span class="info">
                        <h3><%= totalIncome %></h3>
                        <p>Income</p>
                    </span>
                </li>
                <li><i class="bx bx-money-withdraw"></i> 
                    <span class="info">
                        <h3><%= totalExpenses %></h3>
                        <p>Expenses</p>
                    </span>
                </li>
                <li><i class="bx bx-line-chart"></i> 
                    <span class="info">
                        <h3><%= totalProfit %></h3>
                        <p>Profit / Loss</p>
                    </span>
                </li>
            </ul>

            <!-- End of Insights -->
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/index.js"></script>
</body>
</html>
