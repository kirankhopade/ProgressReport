package pojos;

import java.util.ArrayList;
import java.util.List;

public class InstSelectData {

	private String institute ="";
	private List<String> exam = new ArrayList<String>();
	private List<String> std_class = new ArrayList<String>();
	private List<String> subjects = new ArrayList<String>();
	
	public String getInstitute() {
		return institute;
	}
	public void setInstitute(String institute) {
		this.institute = institute;
	}
	public List<String> getExam() {
		return exam;
	}
	public void setExam(List<String> exam) {
		this.exam = exam;
	}
	public List<String> getStd_class() {
		return std_class;
	}
	public void setStd_class(List<String> std_class) {
		this.std_class = std_class;
	}
	public List<String> getSubjects() {
		return subjects;
	}
	public void setSubjects(List<String> subjects) {
		this.subjects = subjects;
	}
	
}
