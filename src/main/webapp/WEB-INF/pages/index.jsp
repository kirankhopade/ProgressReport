<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Home | Get Me Progress Report</title>
	
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
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="/images/ico/apple-touch-icon-57-precomposed.png">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery-form-validator/2.2.43/jquery.form-validator.min.js"></script>
    <script type="text/javascript">
	</script>

    
</head><!--/head-->

<body class="homepage">

                                                                                    <!-- Login Modal -->
                                                                                
                                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                                              <div class="modal-dialog" role="document">
                                                   <div class="modal-content">
                                                      <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                             <h4 class="modal-title" id="exampleModalLabel">Please, Login to your account...</h4> 
                                                      </div>
                                                      <div class="modal-body">
                                                            <form id="loginForm"  method="post" action="${contextPath}/studentservices/verifyLogin" >
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <div class="form-group">
                                                                            <label  for="recipient-name" class="control-label" >Student ID</label>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                      <div class="form-group">
                                                                        <input type="text" class="form-control" id="recipient-name"  name="student_id" placeholder="Student ID / Customer ID" required="required">
                                                                      </div>
                                                                    </div>
                                                                </div>

                                                                <div class="row">
                                                                   <div class="col-sm-12">
                                                                       <div class="form-group">
                                                                            <label   for="message-text" class="control-label">Password</label>
                                                                       </div>
                                                                   </div>
                                                                </div>

                                                               <div class="row">
                                                                    <div class="col-sm-12">
                                                                      <div class="form-group">
                                                                        <input  type="password" class="form-control" id="exampleInputPassword3" name="password" placeholder="Password" required="required">
                                                                     </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-sm-4">
                                                                        <label class="radio-inline">
                                                                         <input type="radio" name="optradio" value="parent" required>Student Sign In
                                                                        </label>
                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                        <label class="radio-inline">
                                                                        <input type="radio" name="optradio" value="parent">Parent Sign In
                                                                        </label>
                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                        <label class="radio-inline">
                                                                        <input type="radio" name="optradio" value="faculty">Faculty Sign In
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                                 
                                                                 <div class="row">
                                                                      <div class="col-sm-2">
                                                                      </div>                                                    
                                                                         <div class="form-group">
                                                                              <div class="col-sm-8">
                                                                              
                                                                                <button  type="submit" class="btn btn-success btn-block">User Sign In</button>                                                         
                                                                              </div>
                                                                        </div>
                                                                  </div>
                                                                 
                                                     
                                                                 <div class="row">
                                                                    <div class="col-sm-2">
                                                                    </div>
                                                                    <div class="col-sm-4">
                                                                          <div class="form-group">
                                                                                <a href="${contextPath}/getFergotCustomerID" class="btn btn-primary" role="button" style="color:white">Forgot Customer ID ??</a> 
                                                                          </div>
                                                                     </div>
                                                                     <div class="col-sm-4"> 
                                                                         <div class="form-group"> 
                                                                            
                                                                             <a href="${contextPath}/getFergotPasswordPage" class="btn btn-primary" role="button" style="color:white">Forgot Password ??</a>
                                                                            
                                                                         </div> 
                                                                     </div> 
                                                                  </div>
                                                
                                                        </form>  
                                                 </div>
                                            </div>
                                    </div>
                              </div>

     <!-- Modal For Success Message -->
     <div class="modal fade  bs-example-modal-lg" id="SuccessMessage" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header modal-header-success">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Message...!!!</h4>
                        </div>
                        <div class="modal-body">
                                <h4><i class="glyphicon glyphicon-ok" >  </i> ${success}</h4>
                        </div>
                        <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
    </div>

        <!-- Modal For Error Message -->
     <div class="modal fade bs-example-modal-lg" id="ErrorMessage" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header modal-header-danger">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Message...!!!</h4>
                        </div>
                        <div class="modal-body">
                                <h4><i class="glyphicon glyphicon-warning-sign">  </i> ${error}</h4>
                        </div>
                        <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
        </div>

    <header id="header">
        <!--  <div class="top-bar">
            <div class="container">
                <div class="row">
                    <div class="col-sm-10 col-xs-4">                  
                    </div>

                     <div class="col-sm-2 col-xs-8">
                        <div class="social"> 
 							<c:if test="${not empty loggedinUser}">
								<div class="top-number"><p><a href="${contextPath}/userfacility/logout" ><i class="glyphicon glyphicon-user"></i>  <b>${loggedinUser}   SignOut</b></a></p></div>
							</c:if>
							<c:if test="${ empty loggedinUser}">
								<div  class="top-number" data-toggle="modal" data-target="#myModal"><p><a id ="test1" href="#"><i class="glyphicon glyphicon-user" ></i><b> Login</b></a></p></div>
							</c:if>
						</div>
					</div> 

                    
                </div>
            </div>
        </div> -->
        
   

        <nav class="navbar navbar-inverse" role="banner">
            <div class="container">
               <!--  <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button> -->
                   <!--  <a class="navbar-brand" href="index.html"><img src="<c:url value="/resources/images/logo.png" />" alt="logo"></a> -->
                <!-- </div> -->
				
                <div class="collapse navbar-collapse navbar-right">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="${contextPath}/getIndex">Home</a></li>
                        <c:if test="${not empty parentsignin}">
                            <li ><a href="${contextPath}/studentservices/getStudentProfile">Student Profile</a></li>
                            <li><a href="${contextPath}/studentservices/getProgressReport">Progress Reports</a></li>
                            <li><a href="${contextPath}/studentservices/getAttendenceReport">Attendence Reports</a></li>
                        <li><a href="${contextPath}/studentservices/getNotifications">Notifications</a></li>
                        </c:if>
                         <c:if test="${not empty facultysignin}">
                            <li><a href="${contextPath}/instituteservices/getClassWiseReportPage">Class Reports</a></li>
                            <li><a href="${contextPath}/instituteservices/getInstitutewiseReportPage">School Reports</a></li>
                            <li><a href="${contextPath}/studentservices/getAttendenceReport">Attendence Reports</a></li>
                            <li><a href="${contextPath}/studentservices/getNotifications">Notifications</a></li>
                         </c:if>
                        
                        <li><a href="${contextPath}/studentservices/getContactUs">Contact Us</a></li> 
                         
                      
                        

                            <c:if test="${not empty loggedinUser}">
                                <li>
                                    <a href="${contextPath}/userfacility/logout" ><i class="glyphicon glyphicon-user"></i>  <b>${loggedinUser}   Log Out</b></a>
                                </li>
                            </c:if>
                            <c:if test="${ empty loggedinUser}">
                                <li>
                                   <!--  <div  class="top-number" data-toggle="modal" data-target="#myModal"><p><a id ="test1" href="#"><i class="glyphicon glyphicon-user" ></i><b> Login</b></a></p></div> -->
                                    <a data-toggle="modal" data-target="#myModal" href="#" ><i class="glyphicon glyphicon-user" ></i><b> Login</b></a>
                                </li>
                            </c:if>

                                              
                    </ul>
                </div>
            </div><!--/.container-->
        </nav><!--/nav-->
	</header><!--/header-->

           
    <section id="main-slider" class="no-margin">
        <div class="carousel slide">
            <ol class="carousel-indicators">
                <li data-target="#main-slider" data-slide-to="0" class="active"></li>
                <li data-target="#main-slider" data-slide-to="1"></li>
                <li data-target="#main-slider" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">

                <div class="item active" style="background-image: url(<c:url value="/resources/images/slider/bg1.jpg" />)">
                    <div class="container">
                        <div class="row slide-margin">
                            <div class="col-sm-6">
                                <div class="carousel-content">
                                    <h1 class="animation animated-item-1">Lorem ipsum dolor sit amet consectetur adipisicing elit</h1>
                                    <h2 class="animation animated-item-2">Accusantium doloremque laudantium totam rem aperiam, eaque ipsa...</h2>
                                    <a class="btn-slide animation animated-item-3" href="#">Read More</a>
                                </div>
                            </div>

                            <div class="col-sm-6 hidden-xs animation animated-item-4">
                                <div class="slider-img">
                                    <img src="<c:url value="/resources/images/slider/img1.png" />"class="img-responsive">
                                </div>
                            </div>

                        </div>
                    </div>
                </div><!--/.item-->

                <div class="item" style="background-image: url(<c:url value="/resources/images/slider/bg2.jpg" />)">
                    <div class="container">
                        <div class="row slide-margin">
                            <div class="col-sm-6">
                                <div class="carousel-content">
                                    <h1 class="animation animated-item-1">Lorem ipsum dolor sit amet consectetur adipisicing elit</h1>
                                    <h2 class="animation animated-item-2">Accusantium doloremque laudantium totam rem aperiam, eaque ipsa...</h2>
                                    <a class="btn-slide animation animated-item-3" href="#">Read More</a>
                                </div>
                            </div>

                            <div class="col-sm-6 hidden-xs animation animated-item-4">
                                <div class="slider-img">
                                    <img src="<c:url value="/resources/images/slider/img2.png" />"  class="img-responsive">
                                </div>
                            </div>

                        </div>
                    </div>
                </div><!--/.item-->

                <div class="item" style="background-image: url(<c:url value="/resources/images/slider/bg3.jpg" />)">
                    <div class="container">
                        <div class="row slide-margin">
                            <div class="col-sm-6">
                                <div class="carousel-content">
                                    <h1 class="animation animated-item-1">Lorem ipsum dolor sit amet consectetur adipisicing elit</h1>
                                    <h2 class="animation animated-item-2">Accusantium doloremque laudantium totam rem aperiam, eaque ipsa...</h2>
                                    <a class="btn-slide animation animated-item-3" href="#">Read More</a>
                                </div>
                            </div>
                            <div class="col-sm-6 hidden-xs animation animated-item-4">
                                <div class="slider-img">
                                    <img src="<c:url value="/resources/images/slider/img3.png" />" class="img-responsive">
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!--/.item-->
            </div><!--/.carousel-inner-->
        </div><!--/.carousel-->
        <a class="prev hidden-xs" href="#main-slider" data-slide="prev">
            <i class="fa fa-chevron-left"></i>
        </a>
        <a class="next hidden-xs" href="#main-slider" data-slide="next">
            <i class="fa fa-chevron-right"></i>
        </a>
    </section><!--/#main-slider-->
    <footer id="footer" class="midnight-blue">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    &copy; 2016 <a target="_blank" href="http://shapebootstrap.net/" title="Free Twitter Bootstrap WordPress Themes and HTML templates">Get Me Progress Report</a>. All Rights Reserved.
                </div>
                <div class="col-sm-6">
                    <ul class="pull-right">
                       <!--  <li><a href="#">Home</a></li> -->
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Faq</a></li>
                        <li><a href="#">Contact Us</a></li>
                        <li><i class="fa fa-phone-square"></i>  +91 8297411200</li>
                    </ul>
                </div>
            </div>
        </div>
    </footer><!--/#footer-->
<!-- Always add .js at the last so that your html content gets loaded fast -->

    <script src="<c:url value="/resources/js/jquery.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.prettyPhoto.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.isotope.min.js" />"></script>
    <script src="<c:url value="/resources/js/main.js" />"></script>
    <script src="<c:url value="/resources/js/wow.min.js" />"></script>
    <script>//$("#popupModal").modal('show');</script>
                          <c:if test="${not empty error}">
                                                          
                                    <script>
                                        $("#ErrorMessage").modal('show');
                                    </script>
                           
                          </c:if>
                         
                          <c:if test="${not empty success}">
                         
                                    <script>
                                         $("#SuccessMessage").modal('show');
                                    </script>
                          </c:if>
</body>
</html>