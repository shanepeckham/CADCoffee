<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Coffee Shop - Place Your Order</title>
<link href="Content/Site.css" rel="stylesheet" />
<link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
<script src="Scripts/modernizr-2.5.3.js"></script>
<script src="Scripts/jquery-1.7.1.min.js"></script>

<script src="Scripts/jquery.validate.min.js"></script>
<script src="Scripts/jquery.validate.unobtrusive.min.js"></script>

</head>
<body>
	<%@ page import="com.coffeeshop.ProductManager"%>
	<%@ page import="com.coffeeshop.Product"%>
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
		<img alt="Welcome to Coffee Shop!" src="Images/banner_coffee.png" height="200" />
			<ol id="orderProcess">
				<li><span class="step-number">1</span>Choose Item</li>
				<li class="current"><span class="step-number">2</span>Details
					&amp; Submit</li>
				<li><span class="step-number">3</span>Receipt</li>
			</ol>
			<%
				int productId = Integer.parseInt(request.getParameter("id"));
				ProductManager productManager = new ProductManager();
				Product product = productManager.getProduct(productId);
			%>
			
			<h1>Place Your Order: <%=product.getName()%></h1>
			<form action="orderconfirmation.jsp" method="post">
				<fieldset class="no-legend">
					<legend>Place Your Order</legend>
					<img class="product-image order-image"
						src="Images/<%=product.getImageName()%>"
						alt="Image of Carrot Cake" />
					<ul class="orderPageList" data-role="listview">
						<li>
							<div>
								<p class="description"><%= product.getDescription() %></p>
							</div>
						</li>
						<li class="email">
							<div class="fieldcontainer" data-role="fieldcontain">
								<label for="orderEmail">Your Email Address</label> <input
									type="text" id="orderEmail" name="orderEmail"
									data-val-required="You must specify an email address."
									data-val="true" />
								<div>
									<span class="field-validation-valid"
										data-valmsg-for="orderEmail" data-valmsg-replace="true"></span>
								</div>
							</div>
						</li>
						<li class="shiping">
							<div class="fieldcontainer" data-role="fieldcontain">
								<label for="orderShipping">Shipping Address</label>
								<textarea rows="4" id="orderShipping" name="orderShipping"
									data-val-required="You must specify a shipping address."
									data-val="true"></textarea>
								<div>
									<span class="field-validation-valid"
										data-valmsg-for="orderShipping" data-valmsg-replace="true"></span>
								</div>
							</div>
						</li>
						<li class="quantity">
							<div class="fieldcontainer" data-role="fieldcontain">
								<label for="orderQty">Quantity</label> <input type="text"
									id="orderQty" name="orderQty" value="1" /> x <span
									id="orderPrice"><%= product.getPrice() %></span> = <span id="orderTotal"> <%=product.getPrice()%></span>
							</div>
						</li>
					</ul>
					<p class="actions">
						<input type="hidden" name="ProductId" value="<%=product.getId()%>" /> <input
							type="submit" value="Place Order" data-role="none"
							data-inline="true" />
					</p>
				</fieldset>
			</form>

			<script type="text/javascript">
				$(function() {
					var price = parseFloat($("#orderPrice").text()).toFixed(2), total = $("#orderTotal"), orderQty = $("#orderQty");

					orderQty.change(function() {
						var quantity = parseInt(orderQty.val());
						if (!quantity || quantity < 1) {
							orderQty.val(1);
							quantity = 1;
						} else if (quantity.toString() !== orderQty.val()) {
							orderQty.val(quantity);
						}
						total.text("$" + (price * quantity).toFixed(2));
					});
				});
			</script>

		</div>
		<footer> &copy;2014 - Coffee Shop </footer>
	</div>
</body>
</html>