/*
 * Author:Kiran
 * This Controller handles all service related requests from the clients and sends corresponding results
 */

package controllers;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import pojos.Notifications;

import org.bson.Document;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;














import HelperClasses.HelpingFunctions;
import daos.InstituteReportDAO;
import daos.LoginDAO;
import daos.NotificationsDAO;
import daos.ProgressReportDAO;
import daos.StudentProfileDAO;
import pojos.ExamWiseReport;
import pojos.InstituteDetails;
import pojos.LoginCredentials;
import pojos.StudentProfile;








import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;



@Controller
@RequestMapping(value="/studentservices")
public class StudentServices {

	 /*@Autowired
	    private JavaMailSender mailSender;*/

	private Document studentRecord = null; // Document- holds entire student document from DB 
	StudentProfile studentprofile = null;  // Object- parses studentRecord document and stores data in object
	
	/*
	 * This method receives student_id and password, validates it and based on validation results,
	 *  returns success or error message
	 */
	
	@RequestMapping(value="/verifyLogin", method=RequestMethod.POST)
	public ModelAndView verifyLogin(@ModelAttribute ("logindata") LoginCredentials logindata, HttpSession session, Model model,HttpServletRequest request){
	
		ModelAndView modelnview = new ModelAndView();
		
		/* LoginDAO to perform CRUD operations on LoginCredentials object data */
		LoginDAO loginDAO=new LoginDAO(logindata); //contains student_id and password entered by user
		
		/* Validate Entered Student_ID and Password and return status*/
		if(request.getParameter("optradio")!=null){
				if(loginDAO.validateCredentials(request.getParameter("optradio"))){
					
				    session.setAttribute("logintype", request.getParameter("optradio"));
					session.setAttribute("loggedInUser", logindata);
					model.addAttribute("success", "Logged In Successfully...!!!!"); // set success message to display on successful login
					
					if(loginDAO.getLoginType().equals("resetPassword")){
						model.addAttribute("heading", "Reset Your Password");
						model.addAttribute("resetPassword","Enter New Password");
						modelnview.setViewName("reset-credentials");
						return modelnview;
					}
					
					
					if(session.getAttribute("logintype").equals("faculty")){
						session.setAttribute("loggedinUser", logindata.getStudent_id());
						model.addAttribute("facultysignin", "Faculty Signed In");
						InstituteDetails institutedetail = (new InstituteReportDAO()).getInstituteDetails(loginDAO.getAssociated_inst());
						session.setAttribute("institutedetails", institutedetail);
					}else{
						studentRecord= loginDAO.getStudentRecord(); // get student document from database
						studentprofile = (new StudentProfileDAO(studentRecord)).getStudentProfile(); // parse studentDocument and stores in studentprofile object
						
						session.setAttribute("loggedinUser", studentprofile.getStudentName().getFirstName());
						model.addAttribute("loggedinUser", (session.getAttribute("loggedinUser")).toString());
						model.addAttribute("parentsignin", "Parent/Student Signed In");
					}
									
					
				}
				else{
					model.addAttribute("error", loginDAO.getloginErrorMessage()); // set login failed message to display on wrong login credentials
				}
					
					
		}else{
			model.addAttribute("error", "Please Select Login Type!!!!"); // set login failed message to display on wrong login credentials
		}
		modelnview.setViewName("index"); // redirect the index page to client
		return modelnview;
	}
	
	
	/*
	 * This method returns student profile if user has signed in otherwise returns error message
	 */
	
	@RequestMapping(value = "/getStudentProfile", method = RequestMethod.GET)
	public ModelAndView getStudentProfile(HttpSession session, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		
		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser"); //capture login session to verify user has logged in
		
		if(logincredential!=null){
			
			model.addAttribute("loggedinUser", (session.getAttribute("loggedinUser")).toString());
			modelnview.addObject("studentprofile",studentprofile); // set StudentProfile on jsp
				String str = (String)session.getAttribute("updateRequestStatus");
			if(str!=null){
				System.out.println("Update Request Received");
				model.addAttribute("success", "Your Update Request will be processed soon. Thank You..");
				session.removeAttribute("updateRequestStatus");
			}
			
			modelnview.setViewName("std_profile"); // redirect to std_profile page 
		}
		else{
			model.addAttribute("error", "Please, Login to get this feature..."); // if user has not logged in then set "Please, Login to get this feature..." message
			modelnview.setViewName("index");  // if user has not logged in then redirect to login page			
		}
		return modelnview;
	}
	
	
	/*
	 * This method redirects user to Progress Report page from another page if logged in otherwise redirects to login page
	 */
	
	@RequestMapping(value = "/getProgressReport", method = RequestMethod.GET)
	public ModelAndView getProgressReport(HttpSession session, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		
		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser");
		
		if(logincredential!=null){
			model.addAttribute("loggedinUser", (session.getAttribute("loggedinUser")).toString());
			modelnview.setViewName("services");
		}
		else{
			model.addAttribute("error", "Please, Login to get this feature...");
			modelnview.setViewName("index");
			
		}
		return modelnview;
	}
	
	
	/*
	 * This method returns attendance data if user has signed in otherwise returns error message
	 */
	
	@RequestMapping(value = "/getAttendenceReport", method = RequestMethod.GET)
	public ModelAndView getAttendenceReport(HttpSession session, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		
		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser");
		
		if(logincredential!=null){
		
			/*
			 * Business Logic to get Attendance Report Data
			 */
				
			model.addAttribute("loggedinUser", (session.getAttribute("loggedinUser")).toString());
			if(session.getAttribute("logintype").equals("faculty"))
				model.addAttribute("facultysignin", "Faculty Signed In");
			else
				model.addAttribute("parentsignin", "Parent/Student Signed In");
			modelnview.setViewName("attendence");
			
		}
		else{
			model.addAttribute("error", "Please, Login to get this feature...");
			modelnview.setViewName("index");
			
		}
		return modelnview;
	}
	
	/*
	 * This method returns notifications if user has signed in otherwise returns error message
	 */
	
	@RequestMapping(value = "/getNotifications", method = RequestMethod.GET)
	public ModelAndView getNotifications(HttpSession session, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		
		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser");
		
		if(logincredential!=null){
		
			/*
			 * Business Logic to get Attendance Report Data
			 */
			
			NotificationsDAO notificationObject = new NotificationsDAO();
			ArrayList <Notifications> notification_list = new ArrayList<Notifications>();
			
			if(session.getAttribute("logintype").equals("faculty")){
				/* in case of institute administrator login */
				 notification_list = notificationObject.getNotifications_institute(((InstituteDetails)session.getAttribute("institutedetails")).get_id(),"institute_administration");
			}else{
				/*  in case of student/parent login */ 
				System.out.println("logged in notifications");
				//String institute_id = logincredential.
				//notification_list = notificationObject.getNotifications_parentsAndStudents(((StudentProfile)session.getAttribute("studentprofile")).get_id(), ((StudentProfile)session.getAttribute("studentprofile")).getStd_class(), ((StudentProfile)session.getAttribute("studentprofile")).getDivision(),"institute_specific");
				notification_list = notificationObject.getNotifications_parentsAndStudents(studentprofile.getSchoolDetails().getSchoolID(), studentprofile.getStd_class(), studentprofile.getDivision(), "institute_specific");
			}
			
			
			model.addAttribute("notifications", notification_list);
			
			model.addAttribute("loggedinUser", (session.getAttribute("loggedinUser")).toString());
			if(session.getAttribute("logintype").equals("faculty"))    /* used to show menu items on notification page based on user type*/
				model.addAttribute("facultysignin", "Faculty Signed In");
			else
				model.addAttribute("parentsignin", "Parent/Student Signed In");
			modelnview.setViewName("notification");
			
		}
		else{
			model.addAttribute("error", "Please, Login to get this feature...");
			modelnview.setViewName("index");
			
		}
		return modelnview;
	}
	
	/*
	 * This method collects data from Contact Us page and stored into the database
	 */
	
	@RequestMapping(value = "/getContactUs", method = RequestMethod.GET)
	public ModelAndView getContactUs(HttpSession session, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		
		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser");
		
		if(logincredential!=null){
		
			/*
			 * Business Logic to get Attendance Report Data
			 */
			model.addAttribute("loggedinUser", (session.getAttribute("loggedinUser")).toString());
			if(session.getAttribute("logintype").equals("faculty"))
				model.addAttribute("facultysignin", "Faculty Signed In");
			else
				model.addAttribute("parentsignin", "Parent/Student Signed In");
			modelnview.setViewName("notification");
			//modelnview.setViewName("attendence");
			modelnview.setViewName("contact-us");
			
		}
		else{
			//model.addAttribute("error", "Please, Login to get this feature...");
		//	modelnview.setViewName("index");
			modelnview.setViewName("contact-us");
			
		}
		return modelnview;
	}
	
	
	/*
	 * This method is called from Progress Report Page (AJAX CALL). This ajax call will get the list of exams or List of subjects 
	 * based on input parameter "type". 
	 * If type="exam" : The list of exams attained by student will be returned to user.
	 * If type="subject" : The list of subjects for which student has written the exam will be returned. 
	 */
	
	@RequestMapping(value="/getSelectDropDownList", method = RequestMethod.GET)
	
	public @ResponseBody ArrayList <String> showSubjectWiseReport(HttpServletRequest request){
		
		System.out.println("reached***");
		ArrayList <String> list =null;
				
		if(request.getParameter("type").equals("exam"))
			 list= ( new ProgressReportDAO(studentprofile)).getExamList(); 
		if(request.getParameter("type").equals("subject"))
			list = (new ProgressReportDAO(studentprofile)).getSubjectList();

		if(list==null){
			System.out.println("Its empty subject list");
		}else{
			System.out.println("Not empty");
		}
		System.out.println(list.toString());
		return list;
	}
	
	
	/*
	 * This method is called from Progress Report Page (AJAX CALL) on "Get Me Report" button click
	 * This method collects data to draw a graph on browser.
	 * If type="exam" : The data for a selected exam (variable 'value') will be sent to browser.
	 * If type="subject" : The data  for a selected subject (variable 'value') across entire academic year will be sent to user.
	 * If type="academicYear" : The percentage data of all examinations for the current academic years will be sent to user.
	 */
	
@RequestMapping(value="/getGraphData", method = RequestMethod.GET)
	
	public @ResponseBody ArrayList <ExamWiseReport> getGraphData(HttpServletRequest request){
		
			
		ArrayList <ExamWiseReport> list =null;
		if(request.getParameter("type").equals("exam")){
			list = (new ProgressReportDAO(studentprofile)).getExamWiseReport(request.getParameter("value"));
			return (list);
		}
		
		if(request.getParameter("type").equals("subject")){
			 list = (new ProgressReportDAO(studentprofile)).getSubjectWiseReport(request.getParameter("value"));
			return list;
		}
		if(request.getParameter("type").equals("academicYear")){
			list = (new ProgressReportDAO(studentprofile)).getAcademicYearWiseReport();
			return (list);
		}
		return null;
		
	}

	/*
	 * This method receives a request to update profile data and sends a current data to user.
	 */

	@RequestMapping(value="getProfileToUpdate", method= RequestMethod.GET)
	public ModelAndView getProfileToUpdate(HttpSession session, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		
		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser");
		
		if(logincredential!=null){
			model.addAttribute("loggedinUser", (session.getAttribute("loggedinUser")).toString());
			modelnview.addObject("studentprofile",studentprofile);
				
			modelnview.setViewName("EnterRecord");
			
		}
		else{
			model.addAttribute("error", "Please, Login to get this feature...");
			modelnview.setViewName("index");
			
		}
		return modelnview;
	}
	
	
	@RequestMapping(value="getDataToUpdate", method= RequestMethod.POST)
	public String getDataToUpdate(HttpSession session, HttpServletRequest request){
		
		System.out.println("reached @getDataToUpdate()");
	
		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser");
		
		System.out.println("from get data to update : "+request.getParameter("firstname"));
		System.out.println(request.getContentLength());
		//System.out.println(request.getAttributeNames().);
		//System.out.println(request.);
		if(logincredential!=null){
			
			
			String value=null;
			
			if(!(value=request.getParameter("firstname")).isEmpty()){
			System.out.println("changed"+value);
			}
			if(!(value=request.getParameter("middlename")).isEmpty()){
				System.out.println("changed"+value);
			}
			if(!(value=request.getParameter("lastname")).isEmpty()){
				System.out.println("changed"+value);
			}
			if(!(value=request.getParameter("schoolname")).isEmpty()){
				System.out.println("changed"+value);
			}
			if(!(value=request.getParameter("firstline")).isEmpty()){	
				System.out.println("changed"+value);
				}
			if(!(value=request.getParameter("secondline")).isEmpty()){	
				System.out.println("changed"+value);
				}
			if(!(value=request.getParameter("city")).isEmpty()){
				System.out.println("changed"+value);
				}
			if(!(value=request.getParameter("state")).isEmpty()){	System.out.println("changed"+value);}
			if(!(value=request.getParameter("country")).isEmpty()){	System.out.println("changed"+value);}
			if(!(value=request.getParameter("pincode")).isEmpty()){	System.out.println("changed"+value);}
			if(!(value=request.getParameter("std_class")).isEmpty()){	System.out.println("changed"+value);}
			if(!(value=request.getParameter("division")).isEmpty()){	System.out.println("changed"+value);}
			if(!(value=request.getParameter("rollno")).isEmpty()){	System.out.println("changed"+value);}
			if(!(value=request.getParameter("contactno")).isEmpty()){	System.out.println("changed"+value);}
			if(!(value=request.getParameter("email")).isEmpty()){	System.out.println("changed"+value);}
			
			
			
		}
		
		//getStudentProfile(session, null);
		session.setAttribute("updateRequestStatus", "true");
		return "redirect:/studentservices/getStudentProfile";
}
	
	
	 @RequestMapping(value="/sendmail" , method = RequestMethod.POST)
	    public ModelAndView getMessageDetails(HttpServletRequest request,Model model,String fergotPwdLink) {
	        // takes input from e-mail form
			
			ModelAndView modelnview = new ModelAndView();
	    	String name = request.getParameter("name");
	        String snederEmailID = request.getParameter("email");
	        String phoneNumber = request.getParameter("number");
	        
	        String subject = request.getParameter("subject");
	        //String message = request.getParameter("message");
	         
	       // Recipient's email ID needs to be mentioned.
	        
	        boolean flag = HelpingFunctions.sendMail(snederEmailID,name,"contactUsMessage",null);
	        if(flag==true){
	        	//return "Result";
	        	model.addAttribute("success", "Your message has been received succesfully.");
	        }
	        else{
	        	model.addAttribute("error", "There is some technical problem with the mailbox, please contact us on aur tollfree number: XXXXXX");
	        }
	        
	        modelnview.setViewName("contact-us");
	        return modelnview;
	        	
	    }
	 
	 	

}
