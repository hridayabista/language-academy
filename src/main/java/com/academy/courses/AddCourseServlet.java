package com.academy.courses;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addCourse") // Ensure this matches the action URL in the form
public class AddCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String courseName = request.getParameter("course_name");
		String courseFeeStr = request.getParameter("course_fee");

		try {
			double courseFee = Double.parseDouble(courseFeeStr);

			// Connect to MySQL database
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");

			// Prepare SQL statement to insert a new course
			String sql = "INSERT INTO courses (course_name, course_fee) VALUES (?, ?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, courseName);
			stmt.setDouble(2, courseFee);

			// Execute the insert operation
			int result = stmt.executeUpdate();

			if (result > 0) {
				response.sendRedirect("pages/courses/courses.jsp");
			} else {
				response.getWriter().print("Error adding course.");
			}

			// Close the connection
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("Error: " + e.getMessage());
		}
	}
}
