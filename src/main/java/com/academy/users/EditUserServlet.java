package com.academy.users;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String username = request.getParameter("username");
		String email = request.getParameter("email");

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");
			String sql = "UPDATE user SET username = ?, email = ? WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, email);
			pstmt.setInt(3, id);
			pstmt.executeUpdate();

			response.sendRedirect(request.getContextPath() + "/pages/user/user.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/pages/user/user.jsp?error=edit");
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
	}
}
