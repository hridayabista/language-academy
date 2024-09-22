<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
      rel="stylesheet"
    />
    <!-- Stylesheet -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/courses.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/students.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/contact.css" />

    <title>Academy Language Center</title>
  </head>

  <body>
    <!-- Sidebar -->
    <div class="sidebar">
      <a href="#" class="logo">
        <i class="bx bx-code-alt"></i>
        <div class="logo-name"><span>Academy</span></div>
      </a>
      <ul class="side-menu">
        <li>
          <a href="<%=request.getContextPath()%>/index.jsp"
            ><i class="bx bxs-dashboard"></i>Dashboard</a
          >
        </li>
        <li>
          <a href="<%=request.getContextPath()%>/pages/courses/courses.jsp"
            ><i class="bx bx-book"></i>Courses</a
          >
        </li>
        <li>
          <a href="<%=request.getContextPath()%>/pages/students/students.jsp"
            ><i class="bx bx-user"></i>Students</a
          >
        </li>
        <li>
          <a href="#"><i class="bx bxs-user-rectangle"></i>Staffs</a>
        </li>
        <li class="active">
          <a href="<%=request.getContextPath()%>/pages/contact/contact.jsp"
            ><i class="bx bx-phone"></i>Contact</a
          >
        </li>
        <li>
          <a href="<%=request.getContextPath()%>/pages/user/user.jsp"
            ><i class="bx bx-user-circle"></i>User</a
          >
        </li>
      </ul>
      <ul class="side-menu">
        <li>
          <a href="#" class="logout">
            <i class="bx bx-log-out-circle"></i>
            Logout
          </a>
        </li>
      </ul>
    </div>
    <!-- End of Sidebar -->

    <!-- Main Content -->
    <div class="content">
      <!-- Navbar -->
      <nav>
        <i class="bx bx-menu"></i>
        <form action="#">
          <div class="form-input">
            <input type="search" placeholder="Search..." />
            <button class="search-btn" type="submit">
              <i class="bx bx-search"></i>
            </button>
          </div>
        </form>
        <input type="checkbox" id="theme-toggle" hidden />
        <label for="theme-toggle" class="theme-toggle"></label>
        <a href="#" class="profile">
          <img src="<%=request.getContextPath()%>/assets/img/logo.png" />
        </a>
      </nav>
      <!-- End of Navbar -->

      <main>
        <div class="header">
          <div class="left">
            <h1>Dashboard / Contact</h1>
          </div>
          <a href="<%=request.getContextPath()%>/index.jsp" class="report">
            <span>Academy Language Center</span>
          </a>
        </div>

        <div class="developer-info">
          <div class="responsive-container-block container">
            <div class="info-section">
              <h2 class="info-title">Meet Our Developers</h2>
              <p class="info-description">
                <strong>John Doe</strong><br />
                Lead Developer<br />
                Email: john.doe@example.com<br />
                Phone: +1234567890
              </p>
              <p class="info-description">
                <strong>Jane Smith</strong><br />
                Frontend Developer<br />
                Email: jane.smith@example.com<br />
                Phone: +0987654321
              </p>
              <p class="info-description">
                <strong>Emily Johnson</strong><br />
                Backend Developer<br />
                Email: emily.johnson@example.com<br />
                Phone: +1122334455
              </p>
            </div>
          </div>
        </div>
      </main>
    </div>

    <script src="<%=request.getContextPath()%>/assets/js/index.js"></script>
  </body>
</html>
