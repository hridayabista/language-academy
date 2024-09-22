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

@WebServlet("/deleteCourse")
public class DeleteCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseId = request.getParameter("course_id");

        try {
            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");

            // Prepare SQL statement for deleting the course
            String sql = "DELETE FROM courses WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(courseId));  // Set course ID for deletion

            // Execute the delete operation
            int result = stmt.executeUpdate();

            if (result > 0) {
            	response.sendRedirect("pages/courses/courses.jsp");  // Redirect to courses page after deletion
            } else {
                response.getWriter().print("Error deleting course.");
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
