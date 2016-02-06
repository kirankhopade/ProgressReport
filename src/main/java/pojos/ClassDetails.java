package pojos;

import java.util.ArrayList;

public class ClassDetails {

	private String class_name="";
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}
	public ArrayList<DivisionDetails> getDivision_details() {
		return division_details;
	}
	public void setDivision_details(ArrayList<DivisionDetails> division_details) {
		this.division_details = division_details;
	}
	private ArrayList<DivisionDetails> division_details = new ArrayList<DivisionDetails> ();
}
