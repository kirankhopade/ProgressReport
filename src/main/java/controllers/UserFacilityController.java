package controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import daos.LoginDAO;
import pojos.LoginCredentials;


@Controller
@RequestMapping(value="/userfacility")
public class UserFacilityController {

	
	
	@RequestMapping(value = "/retrievePassword", method = RequestMethod.POST)
	public ModelAndView getAttendenceReport(HttpServletRequest request, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		
	
		
		String customerID = request.getParameter("customerid");
		
		String emailID =null;
		
		LoginCredentials logindata = new LoginCredentials();
		LoginDAO dao=new LoginDAO(logindata );
		
		/*if(emailID.equals(dao.retrievEmailID(customerID))){
			model.addAttribute("success","Password reset link has been sent to "+emailID);
		}*/
		
		logindata.setStudent_id(customerID);
		
		  emailID=dao.retrievEmailID();
		  System.out.println(emailID);
		 if(emailID!=null)
		{
			 if(StudentServices.sendMail(emailID, customerID, "resetPassword"))
			model.addAttribute("success","Password reset link has been sent to "+emailID);
			 else
				 model.addAttribute("error", "Some Problem with MailBox");
		}
		else{
			model.addAttribute("error", "Privded Customer ID is incorrect");
		}
	
		modelnview.setViewName("index");
		return modelnview;
	}
	
	
}
