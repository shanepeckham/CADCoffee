<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Coffee Shop - Order Status!</title>
<link href="Content/Site.css" rel="stylesheet" />
<link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
<script src="Scripts/modernizr-2.5.3.js"></script>
<script src="Scripts/jquery-1.7.1.min.js"></script>

</head>
<body>
	<%@ page import="com.coffeeshop.ProductManager"%>
	<%@ page import="com.coffeeshop.Product"%>
	<%@ page import="com.coffeeshop.OrderManager"%>
	<%@ page import="com.coffeeshop.Order"%>
	<%@ page import="java.util.Random"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.util.Properties"%>
	<%@ page import="javax.mail.*"%>
	<%@ page import="javax.mail.internet.*"%>

	<%
		//
		// Enter the following values so we can send order confirmation email !
		// if these fields are not set, you will see an error/warning page.
		//
		final String userName = "shairanadiasmith@gmail.com";
		final String password = "Nestle123";
		final String fromEmailId = "order@coffeeshop.com";
	%>
	<div id="page">
		<header>
			<p class="site-title">
				<a href="">Coffee Shop</a>
			</p>
			<nav>
				<ul>
					<li><a href="index.jsp">Home</a></li>
					<li><a href="about.jsp">About Us</a></li>
				</ul>
			</nav>
		</header>
		<div id="body">
			<img alt="Welcome to Coffee Shop!" src="Images/banner_coffee.png"
				height="200" />
			<ol id="orderProcess">
				<li><span class="step-number">1</span>Choose Item</li>
				<li><span class="step-number">2</span>Details &amp; Submit</li>
				<li class="current"><span class="step-number">3</span>Receipt</li>
			</ol>

			<%
				if (userName.isEmpty() || password.isEmpty()
						|| fromEmailId.isEmpty()) {
			%>

			<h1>Order Status</h1>

			<div class="message info">
				<h2>Please set up Mail!</h2>
				<p>Please set your Hotmail Username, Password, and From Address
					in orderconfirmation.jsp to send mail</p>
			</div>

			<%
				} else {

					try {
						String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
						Random rnd = new Random();

						StringBuilder sb = new StringBuilder(5);
						for (int i = 0; i < 5; i++)
							sb.append(AB.charAt(rnd.nextInt(AB.length())));

						String shippingAddress = request
								.getParameter("orderShipping");
						String email = request.getParameter("orderEmail");
						int productId = Integer.parseInt(request
								.getParameter("ProductId"));
						int orderQty = Integer.parseInt(request
								.getParameter("orderQty"));

						
						OrderManager orderManager = new OrderManager();
						ProductManager productManager = new ProductManager();
						Product product = productManager.getProduct(productId);
						Order order = new Order();
						order.setCustomerAddress(shippingAddress);
						order.setCustomerEmail(email);
						order.setDeliveryDate(new Date());
						order.setProductId(product);
						order.setQuantity(orderQty);
						order.setCode(sb.toString());
						order.setFinalPrice(product.getPrice() * orderQty);
						
						/* add to orders table if you need 
						orderManager.addOrder(order);
						 */

						// send email confirmation

						Properties props = new Properties();
						props.put("mail.smtp.auth", "true");
						props.put("mail.smtp.starttls.enable", "true");
						props.put("mail.smtp.host", "smtp.gmail.com");
						props.put("mail.smtp.port", "587");

						Session mailSession = Session.getInstance(props,
								new javax.mail.Authenticator() {
									protected PasswordAuthentication getPasswordAuthentication() {
										return new PasswordAuthentication(userName,
												password);
									}
								});

						Message message = new MimeMessage(mailSession);
						message.setFrom(new InternetAddress(fromEmailId));
						message.setRecipients(Message.RecipientType.TO,
								InternetAddress.parse(email));
						message.setSubject("You order has been processed!");
						message.setText("Dear Customer,"
		                        + "\n\n Thank you for ordering from Coffee Shop! "
		                        + "\n\n Your order details: \n\n"
		                        + " Confirmation number: " + order.getCode() 
		                        + "\n Product: " + product.getName() 
		                        + "\n Quantity: " + order.getQuantity()
		                        + "\n Total Price: " + order.getFinalPrice()
		                        + "\n\n Your order will be delivered to the following address: \n\n " + shippingAddress
		                        + "\n\n Thank you!");

						Transport.send(message);

						out.println("<h1>Order Confirmation</h1>");
						out.println("<div class=\"message info\">");
						out.println("<p>Thank you for placing the order. You will receive a confirmation email shortly.</p>");
						out.println("</div>");

					} catch (MessagingException e) {
						out.println("Error occurred ! :( " + e.getMessage());
					}
				}
			%>

		</div>
		<footer> &copy;2016 - Coffee Shop </footer>
	</div>
</body>
</html>