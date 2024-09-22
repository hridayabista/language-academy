<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- Style sheet -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/auth.css">

<title>Academy | User Authentication</title>
</head>
<body>
	<div id="container" class="container">
		<!-- FORM SECTION -->
		<div class="row">
			<!-- SIGN UP -->
			<div class="col align-items-center flex-col sign-up">
				<div class="form-wrapper align-items-center">
					<div class="form sign-up">
						<form action="${pageContext.request.contextPath}/register" method="post">
							<div class="input-group">
								<i class='bx bxs-user'></i> <input type="text" name="username"
									placeholder="Username" required>
							</div>
							<div class="input-group">
								<i class='bx bx-mail-send'></i> <input type="email" name="email"
									placeholder="Email" required>
							</div>
							<div class="input-group">
								<i class='bx bxs-lock-alt'></i> <input type="password"
									name="password" placeholder="Password" required>
							</div>
							<div class="input-group">
								<i class='bx bxs-lock-alt'></i> <input type="password"
									name="confirm_password" placeholder="Confirm password" required>
							</div>
							<button type="submit">Sign up</button>
						</form>
						<p>
							<span> Already have an account? </span> <b onclick="toggle()"
								class="pointer"> Sign in here </b>
						</p>
					</div>
				</div>
			</div>
			<!-- END SIGN UP -->
			<!-- SIGN IN -->
			<div class="col align-items-center flex-col sign-in">
				<div class="form-wrapper align-items-center">
					<div class="form sign-in">
						<form action="${pageContext.request.contextPath}/login"
							method="post">
							<div class="input-group">
								<i class='bx bxs-user'></i> <input type="text" name="username"
									placeholder="Username" required>
							</div>
							<div class="input-group">
								<i class='bx bxs-lock-alt'></i> <input type="password"
									name="password" placeholder="Password" required>
							</div>
							<button type="submit">Sign in</button>
						</form>
						<p>
							<span> Don't have an account? </span> <b onclick="toggle()"
								class="pointer"> Sign up here </b>
						</p>
					</div>
				</div>
			</div>
			<!-- END SIGN IN -->
		</div>
		<!-- END FORM SECTION -->
		<!-- CONTENT SECTION -->
		<div class="row content-row">
			<!-- SIGN IN CONTENT -->
			<div class="col align-items-center flex-col">
				<div class="text sign-in">
					<h2>
						Welcome To <span>Academy Learning Center</span>
					</h2>
				</div>
			</div>
			<!-- END SIGN IN CONTENT -->
			<!-- SIGN UP CONTENT -->
			<div class="col align-items-center flex-col">
				<div class="img sign-up"></div>
				<div class="text sign-up">
					<h2>Join with us</h2>
				</div>
			</div>
			<!-- END SIGN UP CONTENT -->
		</div>
		<!-- END CONTENT SECTION -->
	</div>

	<!-- JavaScript -->
	<script src="${pageContext.request.contextPath}/assets/js/auth.js"></script>
</body>

</html>
