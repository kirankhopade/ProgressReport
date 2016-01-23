package pojos;

public class Subject {
	
	private String subjectName=null;
	private float maxNumbers=0;
	private float obtainedNumbers=0;
	private float passingNumbers=0;;
	
	/*
	 * Getters and Setters
	 */
	
	public String getSubjectName() {
		return subjectName;
	}
	public float getPassingNumbers() {
		return passingNumbers;
	}
	public void setPassingNumbers(float passingNumbers) {
		this.passingNumbers = passingNumbers;
	}
	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}
	public float getMaxNumbers() {
		return maxNumbers;
	}
	public void setMaxNumbers(float maxNumbers) {
		this.maxNumbers = maxNumbers;
	}
	public float getObtainedNumbers() {
		return obtainedNumbers;
	}
	public void setObtainedNumbers(float obtainedNumbers) {
		this.obtainedNumbers = obtainedNumbers;
	}
	

}
