/*
 * Author: Kiran
 * This class handles initial page displaing request.
 * And Also redirects to index page from any other page
 */


package controllers;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import pojos.LoginCredentials;

@Controller

public class PageController {

	/*
	 * This function sends index page to the client on URL access 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView getDefaulltPage() {
  //System.out.println("reached");
		ModelAndView model = new ModelAndView("index");
	
		return model;

	}
	
	/*
	 *  Method to send index.jsp to the client if he/she choose to redirect Home page from any other page
	 */
	@RequestMapping(value = "/getIndex", method = RequestMethod.GET)
	public ModelAndView getIndexPage(HttpSession session, Model model) {

		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser");
		if(logincredential!=null){
		
		if(session.getAttribute("logintype").equals("faculty"))
			model.addAttribute("facultysignin", "Faculty Signed In");
		else
			model.addAttribute("parentsignin", "Parent/Student Signed In");
		ModelAndView modelnView = new ModelAndView("index");
	
		return modelnView;
		}
		else{
			ModelAndView model1 = new ModelAndView("index");
			return model1;
		}
	}
	
	@RequestMapping(value="/getFergotPasswordPage", method=RequestMethod.GET)
	public ModelAndView getFergotPasswordPage(HttpSession session, Model model){
		model.addAttribute("heading", "Reset Your Password");
		model.addAttribute("customerID", "Enter Customer ID");
		ModelAndView modelview = new ModelAndView("reset-credentials");
		
		return modelview;

	}
	
	@RequestMapping(value="/getFergotCustomerID", method=RequestMethod.GET)
	public ModelAndView getForgotPasswordPage(HttpSession session, Model model){
		model.addAttribute("heading", "Retrieve Your Student/Customer ID");
		model.addAttribute("emailid", "Enter Registered Email ID");
		ModelAndView modelview = new ModelAndView("reset-credentials");
		
		return modelview;

	}

}