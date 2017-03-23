<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Coffee Shop</title>
<link href="Content/Site.css" rel="stylesheet" />
<link href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
<script src="Scripts/modernizr-2.5.3.js"></script>
<script src="Scripts/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="Scripts/javascript/main.js"></script>
<script type="text/javascript" src="Scripts/javascript/azure-engagement.js"></script>
</head>
<body onload="engagement.agent.startActivity('Home Web')">

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
		</nav> </header>
		<div id="body">
			<%
				int randomFeaturedProductId = (int) (Math.random() * 3);
			%>

			<img alt="Welcome to Coffee Shop!" src="Images/banner_coffee.png"
				height="200" />
			<%
				ProductManager productManager = new ProductManager();
				int index = 0;
				int firstTime = 0;
				java.util.ArrayList<Product> productList = productManager
						.getProducts();

				try {
					/**
					 * Display a featured item.
					 */

					Product featuredProduct = productList
							.get(randomFeaturedProductId);
					out.println("<div id=\"featuredProduct\">");
					out.println("<img alt=\"Featured Product\" src=\"Images/"
							+ featuredProduct.getImageName()
							+ "\" height=\"300\"/>");
					out.println("<div id=\"featuredProductInfo\">");
					out.println("<div id=\"productInfo\">");
					out.println("<h2>" + featuredProduct.getName() + " </h2>");
					out.println("<p class=\"price\">$" + featuredProduct.getPrice()
							+ "</p>");
					out.println("<p class=\"description\">"
							+ featuredProduct.getDescription() + "</p>");
					out.println("</div>");
					out.println("<div id=\"callToAction\">");
					out.println("<a class=\"order-button\" href=\"placeorder.jsp?id="
							+ featuredProduct.getId()
							+ "\" title=\""
							+ featuredProduct.getName() + "\">Order Now</a>");
					out.println("</div>");
					out.println("</div>");
					out.println("</div>");
				} catch (Exception e) {
					out.println("Database does not have any products..." + e.getMessage());
				}
			%>

			<div id="productsWrapper">
				<ul id="products" data-role="listview" data-inset="true">

					<%
						try {
							/**
							 * Display all products available in the database.
							 */
							for (Product product : productList) {
								out.println("<li class=\"product\"><a href=\"placeorder.jsp?id="
										+ product.getId() + "\"");
								out.println("title=\""
										+ product.getName()
										+ "\"> <img class=\"hide-from-desktop\" src=\"Images/"
										+ product.getImageName() + "\" alt=\"Image of "
										+ product.getName() + "\" />");
								out.println("<div class=\"productInfo\">");
								out.println("<h3>" + product.getName() + "</h3>");
								out.println("<img class=\"product-image hide-from-mobile\" src=\"Images/"
										+ product.getImageName()
										+ "\" alt=\"Image of "
										+ product.getName() + "\" />");
								out.println("<p class=\"description\"> "
										+ product.getDescription() + "</p>");
								out.println("<p class=\"price hide-from-desktop\">$"
										+ product.getPrice() + "</p>");
								out.println("</div>");
								out.println("</a>");
								out.println("<div class=\"action  hide-from-mobile\">");
								out.println("<p class=\"price\">$" + product.getPrice()
										+ "</p>");
								out.println("<a class=\"order-button\" href=\"placeorder.jsp?id="
										+ product.getId()
										+ "\" title=\"Order "
										+ product.getName() + "\">Order Now</a>");
								out.println("</div></li>");
							}
						} catch (Exception e) {
							out.println("Database does not have any products..." + e.getMessage());
						}
					%>
				</ul>
			</div>
		</div>
		<footer> &copy;2014 - Coffee Shop </footer>
	</div>
            <!--
To collect end-user usage analytics about your application,
insert the following script into each page you want to track.
Place this code immediately before the closing </head> tag,
and before any other scripts. Your first data will appear
automatically in just a few seconds.
-->
    <script type="text/javascript">
        var appInsights=window.appInsights||function(config){
            function r(config){t[config]=function(){var i=arguments;t.queue.push(function(){t[config].apply(t,i)})}}var t={config:config},u=document,e=window,o="script",s=u.createElement(o),i,f;for(s.src=config.url||"//az416426.vo.msecnd.net/scripts/a/ai.0.js",u.getElementsByTagName(o)[0].parentNode.appendChild(s),t.cookie=u.cookie,t.queue=[],i=["Event","Exception","Metric","PageView","Trace"];i.length;)r("track"+i.pop());return r("setAuthenticatedUserContext"),r("clearAuthenticatedUserContext"),config.disableExceptionTracking||(i="onerror",r("_"+i),f=e[i],e[i]=function(config,r,u,e,o){var s=f&&f(config,r,u,e,o);return s!==!0&&t["_"+i](config,r,u,e,o),s}),t
        }({
            instrumentationKey:"14d0422b-d48f-4c41-8f23-b44b3c6e55eb"
        });
        
        window.appInsights=appInsights;
        appInsights.trackPageView();
    </script>

</body>
</html>