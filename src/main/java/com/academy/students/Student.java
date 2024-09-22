package com.academy.students;

public class Student {
    private int id;
    private String name;
    private String course;
    private double courseFee;
    private double paidAmount;
    private double dueAmount;
    private String contact;

    // Constructor, getters, and setters
    public Student(int id, String name, String course, double courseFee, double paidAmount, double dueAmount, String contact) {
        this.id = id;
        this.name = name;
        this.course = course;
        this.courseFee = courseFee;
        this.paidAmount = paidAmount;
        this.dueAmount = dueAmount;
        this.contact = contact;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }
    public double getCourseFee() { return courseFee; }
    public void setCourseFee(double courseFee) { this.courseFee = courseFee; }
    public double getPaidAmount() { return paidAmount; }
    public void setPaidAmount(double paidAmount) { this.paidAmount = paidAmount; }
    public double getDueAmount() { return dueAmount; }
    public void setDueAmount(double dueAmount) { this.dueAmount = dueAmount; }
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
}
