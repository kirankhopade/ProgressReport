package pojos;

import java.util.ArrayList;
import java.util.List;

public class DivisionDetails {

	private String division="";
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public ArrayList<ExamClassAssociation> getAssociated_exams() {
		return associated_exams;
	}
	public void setAssociated_exams(ArrayList<ExamClassAssociation> associated_exams) {
		this.associated_exams = associated_exams;
	}
	private ArrayList<ExamClassAssociation> associated_exams = new ArrayList<ExamClassAssociation>();
	
}
