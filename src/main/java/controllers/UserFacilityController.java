package controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import HelperClasses.HelpingFunctions;
import daos.LoginDAO;
import daos.UpdateDocument;
import pojos.LoginCredentials;


@Controller
@RequestMapping(value="/userfacility")
public class UserFacilityController {

	UpdateDocument updateDocumentObject = new UpdateDocument();
	
	
	@RequestMapping(value = "/retrievePassword", method = RequestMethod.POST)
	public ModelAndView generateNewPassword(HttpServletRequest request, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		modelnview.setViewName("index");
	
		
		String customerID = request.getParameter("customerid");
		
		String emailID =null;
		
		LoginCredentials logindata = new LoginCredentials();
		LoginDAO loginDAO=new LoginDAO(logindata );
		
		/*if(emailID.equals(dao.retrievEmailID(customerID))){
			model.addAttribute("success","Password reset link has been sent to "+emailID);
		}*/
		
		logindata.setStudent_id(customerID);
		
		  emailID=loginDAO.retrieveEmailID();
		  System.out.println(emailID);
		 if(emailID!=null)
		{
			 String tempraryPassword = HelpingFunctions.randomGenerator();
			 	if(tempraryPassword==null){
			 		model.addAttribute("error", "Some problem to generate random password. Please write us about it through Contact Us page");
			 		
			 	}
			 	
			 	String passwordHash = HelpingFunctions.getHash(tempraryPassword);
	 			if(passwordHash==null){
	 				model.addAttribute("error", "Some problem to generate password hash. Please write us about it through Contact Us page");
	 				return modelnview;
	 			}
	 			System.out.println(passwordHash);
	 			
	 			
	 			if( !updateDocumentObject.updateTemporaryPassword(customerID, passwordHash)){
	 				model.addAttribute("error", "Some problem to save temporary password. Please write us about it through Contact Us page");
	 				return modelnview;
	 			}
			 
			 	if(HelpingFunctions.sendMail(emailID, customerID,tempraryPassword,null )){
			
			 			model.addAttribute("success","Password reset link has been sent to "+emailID);
			 			return modelnview;
			 	}
			 	 else{
			 		 model.addAttribute("error", "Some Problem with MailBox");
			 		 return modelnview;
			 	 }
		}
		else{
			model.addAttribute("error", "Privded Customer ID is incorrect");
			return modelnview;
		}
		
	}
	
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	public ModelAndView updatePassword(HttpSession session,HttpServletRequest request, Model model){
		
	ModelAndView modelnview = new ModelAndView();
		try{
		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser");
		 System.out.println("from updatePassword"+logincredential.getStudent_id());
		
		String newPasswordHash = HelpingFunctions.getHash(request.getParameter("newpassword"));
		System.out.println(newPasswordHash);
		
		if(updateDocumentObject.updatePrimaryPassword(logincredential.getStudent_id(), newPasswordHash)){
			model.addAttribute("success", "Password reset successfully. Please Login");
		}else{
			model.addAttribute("error", "There is some technical problem to reset new password. Please write us about this to us on Contact Us Page");
		}
		}catch(Exception e){System.out.println(e);}
		modelnview.setViewName("index");
		return modelnview;
		
	   
	}
	
	
	@RequestMapping(value = "/retrieveCustomerId", method = RequestMethod.POST)
	public ModelAndView retrieveCustomerId(HttpSession session,HttpServletRequest request, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		modelnview.setViewName("index");
		
		String emailID = request.getParameter("emailid");
		
		LoginDAO logindao = new LoginDAO(null);
		
		String customerIDDetais = logindao.retrieveCustomerId(emailID);
		if(customerIDDetais != null){

			
			if(HelpingFunctions.sendMail(emailID, emailID,"retrieveCustomerID", customerIDDetais )){
				
	 			model.addAttribute("success","We have sent you details on "+emailID);
	 			return modelnview;
			} else{
				model.addAttribute("error", "Some Problem with MailBox");
				return modelnview;
			}
			
		}
		else{
			model.addAttribute("error", "Entered email id is not registered. Please verify email id. You can contact to us through Contact Us.(Select Subject: Application Access Problem)");
			 return modelnview;
		}
	}
	
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public ModelAndView terminateSession(HttpSession session, HttpServletRequest request, Model model){
	
		session.invalidate();
		
				model.addAttribute("success", "Logged Out Successfully...");
				ModelAndView modelnview = new ModelAndView();
				modelnview.setViewName("index");
				return modelnview;
		    }

		
	
	 
	}
	

