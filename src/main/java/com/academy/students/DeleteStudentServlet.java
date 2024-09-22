package com.academy.students;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the student ID from the request
        int id = Integer.parseInt(request.getParameter("id"));

        // Establish a connection and delete the student by their ID
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");

            // Prepare the SQL statement
            String sql = "DELETE FROM students WHERE id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            // Execute the query
            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                System.out.println("Student deleted successfully.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }

        // Redirect to the students list page after deletion
        response.sendRedirect(request.getContextPath() + "/pages/students/students.jsp");
    }
}


