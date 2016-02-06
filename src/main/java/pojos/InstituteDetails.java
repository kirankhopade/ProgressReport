package pojos;

import java.util.ArrayList;

public class InstituteDetails {

	private String _id="";
	public String get_id() {
		return _id;
	}
	public void set_id(String _id) {
		this._id = _id;
	}
	public SchoolDetails getInstitute_details() {
		return institute_details;
	}
	public void setInstitute_details(SchoolDetails institute_details) {
		this.institute_details = institute_details;
	}
	public ArrayList<ExamDetails> getExam_details() {
		return exam_details;
	}
	public void setExam_details(ArrayList<ExamDetails> exam_details) {
		this.exam_details = exam_details;
	}
	public ArrayList<ClassDetails> getClass_list() {
		return class_list;
	}
	public void setClass_list(ArrayList<ClassDetails> class_list) {
		this.class_list = class_list;
	}
	private SchoolDetails institute_details = new SchoolDetails();
    private ArrayList<ExamDetails> exam_details = new ArrayList<ExamDetails> ();	
    private ArrayList<ClassDetails> class_list = new ArrayList<ClassDetails> ();
}


