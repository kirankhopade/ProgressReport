<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Notifications | Get Me Progress Report</title>
    
    <!-- core CSS -->

    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/font-awesome.min.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/animate.min.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/prettyPhoto.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/main.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/responsive.css" />" rel="stylesheet">


    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
</head><!--/head-->

<body>

    <header id="header">
         <!-- <div class="top-bar">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6 col-xs-4">
                     
                    </div>
                    <div class="col-sm-6 col-xs-8">
                       <div class="social">
                           
                           <div class="top-number"><p><a href="${contextPath}/userfacility/logout" ><i class="glyphicon glyphicon-user"></i>  <b>${loggedinUser}   SignOut</b></a></p></div>
                            
                       </div>
                    </div>
                </div>
            </div>
        </div>
     -->

        <nav class="navbar navbar-inverse" role="banner">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                     <!--   <a class="navbar-brand" href="index.html"><img src="<c:url value="/resources/images/logo.png" />" alt="logo"></a> -->
                </div>
                
                <div class="collapse navbar-collapse navbar-right">
                    <ul class="nav navbar-nav">
                        <li><a href="${contextPath}/getIndex">Home</a></li>
                        <!-- <li><a href="${contextPath}/studentservices/getStudentProfile">Student Profile</a></li>
                        <li><a href="${contextPath}/studentservices/getProgressReport">Progress Report</a></li>
                         -->
                        <c:if test="${not empty parentsignin}">
                            <li ><a href="${contextPath}/studentservices/getStudentProfile">Student Profile</a></li>
                            <li><a href="${contextPath}/studentservices/getProgressReport">Progress Reports</a></li>
                        </c:if>
                         <c:if test="${not empty facultysignin}">
                            <li><a href="${contextPath}/instituteservices/getClassWiseReportPage">Class Reports</a></li>
                            <li><a href="${contextPath}/instituteservices/getInstitutewiseReportPage">School Reports</a></li>
                         </c:if>
                        
                        <li><a href="${contextPath}/studentservices/getAttendenceReport">Attendence Reports</a></li>
                        <li  class="active"><a href="${contextPath}/studentservices/getNotifications">Notifications</a></li>
                        <li><a href="${contextPath}/studentservices/getContactUs">Contact Us</a></li> 
                        <li>
                                    <a href="${contextPath}/userfacility/logout" ><i class="glyphicon glyphicon-user"></i>  <b>${loggedinUser}   Log Out</b></a>
                        </li>  
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
        
    </header><!--/header-->

    <section id="blog" class="container wow fadeInDown  ">
        <!-- <div class="center">
            <h2>Notifications</h2>
            <p class="lead">Here, you will receive notifications from the School Authority or Portal Management Team </p>
        </div> -->

        <div class="blog">
            <div class="row">
                <c:forEach items="${notifications}" var="notification">
                 <div class="col-md-12 ">
                    <div class="blog-item">
                        <div class="row">
                            <div class="col-xs-12 col-sm-2 text-center ">
                                <div class="entry-meta">
                                    <span id="publish_date">${notification.date}</span>
                                    <!-- <span><i class="fa fa-user"></i> <a href="#">John Doe</a></span>
                                    <span><i class="fa fa-comment"></i> <a href="blog-item.html#comments">2 Comments</a></span>
                                    <span><i class="fa fa-heart"></i><a href="#">56 Likes</a></span> -->
                                </div>
                            </div>
                                
                            <div class="col-xs-12 col-sm-10 blog-content ">
                                <!-- <a href="#"><img class="img-responsive img-blog" src="images/blog/blog1.jpg" width="100%" alt="" /></a> -->
                                <h2><a href="#">${notification.subject}</a></h2>
                                <h3>${notification.message}</h3>
                               <!--  <a class="btn btn-primary readmore" href="blog-item.html">Read More <i class="fa fa-angle-right"></i></a> -->
                            </div>
                        </div>    
                    </div><!--/.blog-item-->
                </div><!--/.col-md-8-->
                </c:forEach>

             		<!-- </aside>  --> 
                <div class="center">
                    <div class="col-sm-12 blog-content ">
                        <ul class="pagination pagination-lg">
                            <li><a href="#"><i class="fa fa-long-arrow-left" ></i>Previous Page</a></li>
                            <li><a href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                            <li><a href="#">5</a></li>
                            <li><a href="#">Next Page<i class="fa fa-long-arrow-right" ></i></a></li>
                        </ul><!--/.pagination-->
                    </div>        
                </div>
            </div><!--/.row-->
        </div>
    </section><!--/#blog-->

      <!--  <section id="bottom">
        <div class="container wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="600ms">
            <div class="row">
                <div class="col-md-3 col-sm-6">
                    <div class="widget">
                        <h3>Company</h3>
                        <ul>
                            <li><a href="#">About us</a></li>
                            <li><a href="#">We are hiring</a></li>
                            <li><a href="#">Meet the team</a></li>
                            <li><a href="#">Copyright</a></li>
                            <li><a href="#">Terms of use</a></li>
                            <li><a href="#">Privacy policy</a></li>
                            <li><a href="#">Contact us</a></li>
                        </ul>
                    </div>    
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="widget">
                        <h3>Support</h3>
                        <ul>
                            <li><a href="#">Faq</a></li>
                            <li><a href="#">Blog</a></li>
                            <li><a href="#">Forum</a></li>
                            <li><a href="#">Documentation</a></li>
                            <li><a href="#">Refund policy</a></li>
                            <li><a href="#">Ticket system</a></li>
                            <li><a href="#">Billing system</a></li>
                        </ul>
                    </div>    
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="widget">
                        <h3>Developers</h3>
                        <ul>
                            <li><a href="#">Web Development</a></li>
                            <li><a href="#">SEO Marketing</a></li>
                            <li><a href="#">Theme</a></li>
                            <li><a href="#">Development</a></li>
                            <li><a href="#">Email Marketing</a></li>
                            <li><a href="#">Plugin Development</a></li>
                            <li><a href="#">Article Writing</a></li>
                        </ul>
                    </div>    
                </div>

                <div class="col-md-3 col-sm-6">
                    <div class="widget">
                        <h3>Our Partners</h3>
                        <ul>
                            <li><a href="#">Adipisicing Elit</a></li>
                            <li><a href="#">Eiusmod</a></li>
                            <li><a href="#">Tempor</a></li>
                            <li><a href="#">Veniam</a></li>
                            <li><a href="#">Exercitation</a></li>
                            <li><a href="#">Ullamco</a></li>
                            <li><a href="#">Laboris</a></li>
                        </ul>
                    </div>    
                </div>
            </div>
        </div>
    </section> -->

    <footer id="footer" class="midnight-blue">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    &copy; 2016 <a target="_blank" href="http://shapebootstrap.net/" title="Free Twitter Bootstrap WordPress Themes and HTML templates">Get Me Progress Report</a>. All Rights Reserved.
                </div>
                <div class="col-sm-6">
                    <ul class="pull-right">
                        <!-- <li><a href="#">Home</a></li> -->
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Faq</a></li>
                        <li><a href="#">Contact Us</a></li>
                        <li><i class="fa fa-phone-square"></i>  +91 8297411200</li>
                    </ul>
                </div>
            </div>
        </div>
    </footer><!--/#footer-->


    <script src="<c:url value="/resources/js/jquery.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.prettyPhoto.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.isotope.min.js" />"></script>
    <script src="<c:url value="/resources/js/main.js" />"></script>
    <script src="<c:url value="/resources/js/wow.min.js" />"></script>
    
    </body>
</html>