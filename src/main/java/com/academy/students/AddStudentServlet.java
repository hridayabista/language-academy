package com.academy.students;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddStudentServlet")
public class AddStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String course = request.getParameter("course");
		double paidAmount = Double.parseDouble(request.getParameter("paid_amount"));
		String contact = request.getParameter("contact");
		
		double courseFee = 0.0;
		double dueAmount = 0.0;
		
		try {
			// Database connection
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");

			// Fetch course fee based on selected course
			String query = "SELECT course_fee FROM courses WHERE course_name=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, course);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				courseFee = rs.getDouble("course_fee");
			}
			
			// Calculate due amount
			dueAmount = courseFee - paidAmount;

			// Insert into students table
			String insertQuery = "INSERT INTO students (name, course, course_fee, paid_amount, due, contact) VALUES (?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = con.prepareStatement(insertQuery);
			stmt.setString(1, name);
			stmt.setString(2, course);
			stmt.setDouble(3, courseFee);
			stmt.setDouble(4, paidAmount);
			stmt.setDouble(5, dueAmount);
			stmt.setString(6, contact);
			
			stmt.executeUpdate();
			
			response.sendRedirect("pages/students/students.jsp"); // Redirect to the students page after adding
			
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

