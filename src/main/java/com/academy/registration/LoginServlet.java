package com.academy.registration;

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
import javax.servlet.http.HttpSession;

           
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		HttpSession session = request.getSession();

		try {
			// Load MySQL JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Establish a connection to the database
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");

			// Prepare SQL query to check user credentials
			PreparedStatement pst = con.prepareStatement("SELECT * FROM user WHERE username = ? AND password = ?");
			pst.setString(1, username);
			pst.setString(2, password);

			// Execute query
			ResultSet rs = pst.executeQuery();

			// Check if user credentials match
			if (rs.next()) {
				System.out.println("Login successful for user: " + username);
				session.setAttribute("username", rs.getString("username")); // Set "username" attribute
				response.sendRedirect(request.getContextPath() + "/index.jsp"); // Redirect to index.jsp
			} else {
				System.out.println("Login failed for user: " + username);
				request.setAttribute("status", "failed");
				request.getRequestDispatcher("pages/auth/auth.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
