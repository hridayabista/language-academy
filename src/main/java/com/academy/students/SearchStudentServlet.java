package com.academy.students;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SearchStudentServlet")
public class SearchStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("search");

        List<Student> students = new ArrayList<>();
        String jdbcURL = "jdbc:mysql://localhost:3306/academy";
        String jdbcUsername = "root";
        String jdbcPassword = "";

        String sql = "SELECT * FROM students WHERE name LIKE ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + searchQuery + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String course = rs.getString("course");
                double courseFee = rs.getDouble("course_fee");
                double paidAmount = rs.getDouble("paid_amount");
                double dueAmount = rs.getDouble("due");
                String contact = rs.getString("contact");

                Student student = new Student(id, name, course, courseFee, paidAmount, dueAmount, contact);
                students.add(student);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("students", students);
        request.getRequestDispatcher("students.jsp").forward(request, response);
    }
}
