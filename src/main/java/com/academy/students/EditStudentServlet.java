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

@WebServlet("/EditStudentServlet")
public class EditStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String course = request.getParameter("course");
        String contact = request.getParameter("contact");
        double paidAmount = Double.parseDouble(request.getParameter("paid_amount"));

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");

            // Fetch the course fee based on selected course
            String courseFeeQuery = "SELECT course_fee FROM courses WHERE course_name = ?";
            pstmt = conn.prepareStatement(courseFeeQuery);
            pstmt.setString(1, course);
            rs = pstmt.executeQuery();
            double courseFee = 0;
            if (rs.next()) {
                courseFee = rs.getDouble("course_fee");
            }

            // Calculate the due amount
            double dueAmount = courseFee - paidAmount;

            // Update the student in the database
            String updateQuery = "UPDATE students SET name = ?, course = ?, course_fee = ?, paid_amount = ?, due = ?, contact = ? WHERE id = ?";
            pstmt = conn.prepareStatement(updateQuery);
            pstmt.setString(1, name);
            pstmt.setString(2, course);
            pstmt.setDouble(3, courseFee);
            pstmt.setDouble(4, paidAmount);
            pstmt.setDouble(5, dueAmount);
            pstmt.setString(6, contact);
            pstmt.setInt(7, Integer.parseInt(id));

            pstmt.executeUpdate();

            // Redirect to the students.jsp page after update
            response.sendRedirect("pages/students/students.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

