package pojos;

import java.util.ArrayList;

public class ExamClassAssociation {
 private String exam_name="";
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
}
