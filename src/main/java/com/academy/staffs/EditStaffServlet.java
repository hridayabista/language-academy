package com.academy.staffs;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditStaffServlet")
public class EditStaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String title = request.getParameter("title");
		double salary = Double.parseDouble(request.getParameter("salary"));

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");
			String sql = "UPDATE staffs SET name = ?, title = ?, salary = ? WHERE id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, title);
			pstmt.setDouble(3, salary);
			pstmt.setInt(4, id);
			pstmt.executeUpdate();
			response.sendRedirect("pages/staffs/staffs.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
