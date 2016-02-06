package controllers;

import java.util.ArrayList;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pojos.InstSelectData;
import pojos.InstituteDetails;
import pojos.InstituteReport;
import pojos.LoginCredentials;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

import daos.InstituteReportDAO;
import daos.ProgressReportDAO;


@Controller

@RequestMapping(value="/instituteservices")
public class InstituteServices {
	
	
	
	
	@RequestMapping(value = "/getClassWiseReportPage", method = RequestMethod.GET)
	public ModelAndView getClassWiseReportPage(HttpSession session, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		
		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser");
		
		if(logincredential!=null){
			model.addAttribute("facultysignin", "Faculty Signed In");
			modelnview.setViewName("classreport");
		}
		else{
			model.addAttribute("error", "Please, Login to get this feature...");
			modelnview.setViewName("index");
			
		}
		return modelnview;
	}
	

	@RequestMapping(value = "/getInstitutewiseReportPage", method = RequestMethod.GET)
	public ModelAndView getInstitutewiseReportPage(HttpSession session, Model model){
		
		ModelAndView modelnview = new ModelAndView();
		
		LoginCredentials logincredential = (LoginCredentials) session.getAttribute("loggedInUser");
		
		if(logincredential!=null){
			model.addAttribute("facultysignin", "Faculty Signed In");
			modelnview.setViewName("institutereport");
		}
		else{
			model.addAttribute("error", "Please, Login to get this feature...");
			modelnview.setViewName("index");
			
		}
		return modelnview;
	}
	


@RequestMapping(value="/getClasswiseReport", method = RequestMethod.GET)
	
	public @ResponseBody InstituteReport showClassReport(HttpServletRequest request){
	
	InstituteReport datatoclient=null;
	System.out.println("@inst cont");
	String schoolid = request.getParameter("schoolid");
	System.out.println(schoolid);
	
	String classname= request.getParameter("classname");
	System.out.println(classname);
	String division = request.getParameter("division");
	System.out.println(division);
	String  examname = request.getParameter("examname");
	System.out.println(examname);
	
	if((request.getParameter("type").trim()).equals("examwise"))
		datatoclient = (new InstituteReportDAO()).getExamwiseReport(schoolid, classname, division, examname);
		
	if((request.getParameter("type").trim()).equals("ExamwiseAllExam"))
	    datatoclient = (new InstituteReportDAO()).getExamwiseReportForAllExams(schoolid, classname, division);
	
	if((request.getParameter("type").trim()).equals("subjectwise"))
		datatoclient = (new InstituteReportDAO()).getSubjectwiseReport(schoolid, classname, division, examname);
		
				System.out.println(datatoclient.getRecordList().get(1).getSubject());
				System.out.println(datatoclient.getRecordList().get(1).getTotalobtained());
				System.out.println(datatoclient.getRecordList().get(1).getTotaloutoff());
				System.out.println(datatoclient.getRecordList().get(1).getStudentsappeared());
				System.out.println(datatoclient.getRecordList().get(1).getStudentspassed());
				System.out.println(datatoclient.getRecordList().get(1).getStudentfailed());
				System.out.println(datatoclient.getRecordList().size());
				//System.out.println
		return datatoclient;
	}

@RequestMapping(value="/getInstitutewiseReport", method= RequestMethod.GET)
public @ResponseBody InstituteReport showInstitutewiseReport(HttpServletRequest request){
	InstituteReport datatoclient=null;
	//all examinations across entire school
	if((request.getParameter("type").trim()).equals("ForAllExaminations")){
		String schoolid = request.getParameter("schoolid");
		System.out.println(schoolid);
		datatoclient = (new InstituteReportDAO()).getAllExaminationsAccrossEntireInstitute(schoolid.trim());
	}
	//FOR SELECTED EXAMINATION ACCROSS ALL CLASSES
	if((request.getParameter("type").trim()).equals("ForSelectedExamination")){
		String schoolid = request.getParameter("schoolid");
		String exam = request.getParameter("examname");
		System.out.println(schoolid+exam);
		datatoclient = (new InstituteReportDAO()).getReportForSelectedExaminationAccrossAllClasses(schoolid, exam);
	}
	//FOR SELECTED SUBJECT ACCROSS ALL EXAMINATIONS
	if((request.getParameter("type").trim()).equals("ForSelectedSubject")){
		String schoolid = request.getParameter("schoolid");
		String subject = request.getParameter("subject");
		System.out.println(schoolid+subject);
		datatoclient = (new InstituteReportDAO()).getReportForSelectedSubjectAccrossAllExaminations(schoolid, subject);
	}
	//FOR SELECTED SUBJECT & EXAMINATION ACCROSS ALL CLASSES
	if((request.getParameter("type").trim()).equals("ForSelectedExamAndSubject")){
		String schoolid= request.getParameter("schoolid");
		String subject =request.getParameter("subject");
		String examname= request.getParameter("examname");
		System.out.println(schoolid+subject+examname);
		datatoclient = (new InstituteReportDAO()).getForSelectedSubjectAndExamination(schoolid, subject, examname);
	}
	//return null;
	System.out.println(datatoclient.getSubject());
	System.out.println(datatoclient.getRecordList().get(1).getStd_class());
	System.out.println(datatoclient.getRecordList().get(1).getDivision());
	System.out.println(datatoclient.getRecordList().get(1).getTotalobtained());
	System.out.println(datatoclient.getRecordList().get(1).getTotaloutoff());
	System.out.println(datatoclient.getRecordList().get(1).getStudentsappeared());
	System.out.println(datatoclient.getRecordList().get(1).getStudentspassed());
	System.out.println(datatoclient.getRecordList().get(1).getStudentfailed());
	System.out.println(datatoclient.getRecordList().size());
	return datatoclient;
}

	@RequestMapping(value="/getSelectDropDownList", method = RequestMethod.GET)
	public @ResponseBody InstSelectData getSelectDropDownList(HttpServletRequest request,HttpSession session){
		InstituteDetails institutedetail = (InstituteDetails)session.getAttribute("institutedetails");
		InstSelectData selectDataObj = new InstSelectData();
		//ArrayList <String> instituteSelectDetails =null;
		try{
		if(request.getParameter("type").equals("ForAllExaminations")){
			//list = new ArrayList<String>();
			//String instituteid = (new InstituteReportDAO()).getAssociatedInstituteID(((LoginCredentials)session.getAttribute("loggedInUser")).getStudent_id());
			
			//institutedetail = (new InstituteReportDAO()).getInstituteDetails(instituteid);
			System.out.println("from inst get select drop down"+institutedetail.get_id()+" "+institutedetail.getInstitute_details().getAddress().getFirstLine()+" "+institutedetail.getExam_details().get(0).getExam_name()+" "+institutedetail.getClass_list().get(0).getDivision_details().get(0).getDivision());
			System.out.println(institutedetail.getClass_list().get(0).getDivision_details().get(0).getAssociated_exams().get(0).getExam_name());
			selectDataObj.setInstitute(institutedetail.get_id());
		}
		
		if(request.getParameter("type").equals("ForSelectedExamination")){
			
			selectDataObj.setInstitute(institutedetail.get_id());
	
			for(int i=0;i<institutedetail.getExam_details().size();i++){
				 if(institutedetail.getExam_details().get(i).getExam_type().equals("common_accross_institute")){
					  selectDataObj.getExam().add(institutedetail.getExam_details().get(i).getExam_name());
				 }
			}
			
		}
		
		if(request.getParameter("type").equals("ForSelectedSubject")){
			selectDataObj.setInstitute(institutedetail.get_id());
			
			for(int i=0;i<institutedetail.getExam_details().size();i++){
				
				if(institutedetail.getExam_details().get(i).getExam_type().equals("common_accross_institute")){
				    
					for(int j=0;j<institutedetail.getExam_details().get(i).getSubject_list().size();j++){
						if(!selectDataObj.getSubjects().contains(institutedetail.getExam_details().get(i).getSubject_list().get(j).getSubjectName()))
							selectDataObj.getSubjects().add(institutedetail.getExam_details().get(i).getSubject_list().get(j).getSubjectName());
					}
				}
			}
			
		} 
		
		if(request.getParameter("type").equals("ForSelectedExamAndSubject")){
			selectDataObj.setInstitute(institutedetail.get_id());
			
			for(int i=0;i<institutedetail.getExam_details().size();i++){
				
				if(institutedetail.getExam_details().get(i).getExam_type().equals("common_accross_institute")){
					  selectDataObj.getExam().add(institutedetail.getExam_details().get(i).getExam_name());
				 }
			}
			
		} 
		
		if(request.getParameter("type").equals("selectCorrespondingSubjects")){
			
			String examName = request.getParameter("selectedExam");
			System.out.println("receicved exam : "+examName);
				selectDataObj.setInstitute(institutedetail.get_id());
			
			for(int i=0;i<institutedetail.getExam_details().size();i++){
				
				if(institutedetail.getExam_details().get(i).getExam_type().equals("common_accross_institute") && institutedetail.getExam_details().get(i).getExam_name().equals(examName)){
				    
					for(int j=0;j<institutedetail.getExam_details().get(i).getSubject_list().size();j++){
						if(!selectDataObj.getSubjects().contains(institutedetail.getExam_details().get(i).getSubject_list().get(j).getSubjectName()))
							selectDataObj.getSubjects().add(institutedetail.getExam_details().get(i).getSubject_list().get(j).getSubjectName());
					}
				}
			}
		}
		
		}catch(Exception e){ System.out.println(e);}
		
		return selectDataObj;
	}


	
}
