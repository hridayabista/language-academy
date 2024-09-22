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

@WebServlet("/editCourse")
public class EditCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String courseId = request.getParameter("course_id");
        String courseName = request.getParameter("course_name");
        String courseFeeStr = request.getParameter("course_fee");

        try {
            double courseFee = Double.parseDouble(courseFeeStr);

            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/academy", "root", "");

            // Prepare SQL statement for updating the course
            String sql = "UPDATE courses SET course_name = ?, course_fee = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, courseName);
            stmt.setDouble(2, courseFee);
            stmt.setInt(3, Integer.parseInt(courseId));  // Set course ID for updating the correct record

            // Execute the update operation
            int result = stmt.executeUpdate();

            if (result > 0) {
            	response.sendRedirect("pages/courses/courses.jsp");  // Redirect to the courses page after successful update
            } else {
                response.getWriter().print("Error editing course.");
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

