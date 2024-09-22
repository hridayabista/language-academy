package com.academy.registration;

import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirm_password = request.getParameter("confirm_password");

		Connection con = null;
		RequestDispatcher dispatcher = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", ""); // Corrected URL

			PreparedStatement pst = con.prepareStatement(
					"INSERT INTO user(username, email, password, confirm_password) VALUES (?, ?, ?, ?)");
			pst.setString(1, username);
			pst.setString(2, email);
			pst.setString(3, password);
			pst.setString(4, confirm_password);

			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("pages/auth/auth.jsp");
			if (rowCount > 0) {
				request.setAttribute("status", "success");
			} else {
				request.setAttribute("status", "failed");
			}

			dispatcher.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			// Handle exceptions properly, like sending an error response or logging
		} finally {
			if (con != null) { // Check if connection is not null
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
