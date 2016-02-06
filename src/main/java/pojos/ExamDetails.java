package pojos;

import java.util.ArrayList;

public class ExamDetails {

	private String exam_name="";
	private String exam_type="";
	private String exam_Date = "";
	private ArrayList<Subject> subject_list = new ArrayList<Subject>();
	
	public ArrayList<Subject> getSubject_list() {
		return subject_list;
	}
	public void setSubject_list(ArrayList<Subject> subject_list) {
		this.subject_list = subject_list;
	}
	public String getExam_name() {
		return exam_name;
	}
	public void setExam_name(String exam_name) {
		this.exam_name = exam_name;
	}
	public String getExam_type() {
		return exam_type;
	}
	public void setExam_type(String exam_type) {
		this.exam_type = exam_type;
	}
	public String getExam_Date() {
		return exam_Date;
	}
	public void setExam_Date(String exam_Date) {
		this.exam_Date = exam_Date;
	}
	
}
