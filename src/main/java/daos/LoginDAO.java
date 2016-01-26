/*
 * Author : Kiran
 * Contains code for:
 * 1. Connect to DB.
 * 2. Retrieve password for entered student and verifies entered password. 
 * 3. Returns student profile document.
 */

package daos;

import org.bson.Document;

import HelperClasses.HelpingFunctions;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import static com.mongodb.client.model.Filters.*;
import pojos.LoginCredentials;



public class LoginDAO {

	


	private LoginCredentials logindata;
	private MongoClient mongoClient;
	private MongoDatabase db;
	private Document credentials=null;
	private String loginType="";   // to store login type is normal login or reset password login

	/*
	 * Constructor
	 */
	public LoginDAO(LoginCredentials logindata){
	
			this.logindata=logindata;
			try{
				mongoClient = new MongoClient("localhost", 27017);
				db = mongoClient.getDatabase("progressreport");
				
				/*String textUri = "mongodb://admin:admin@ds039125.mongolab.com:39125/progressreport";
	 			MongoClientURI uri = new MongoClientURI(textUri);
	 			MongoClient m = new MongoClient(uri);			
	 			db = m.getDatabase(uri.getDatabase());*/
		
			}catch(Exception e){
				e.printStackTrace();
			}
 
	}
		/* getter method */
		public LoginCredentials getLogindata() {
			return logindata;
		}
		/* setter method */
		public void setLogindata(LoginCredentials logindata) {
			this.logindata = logindata;
		}	
		
		public String getLoginType() {
			return loginType;
		}
		public void setLoginType(String loginType) {
			this.loginType = loginType;
		}
		
		/*
		 * This method validates given password against password from database
		 */
		/* public boolean validateCredentials(){
	
		  String retrievedPassword = this.retrievedPassword(logindata.getPassword());
		   if(retrievedPassword!=null && retrievedPassword.equals(logindata.getPassword()))
		    	return true;
		    else
			   return false;
		   }*/
		
		
		
		/*
		 * This method gets a password from database and compares it with password given by an user.
		 */
		public boolean validateCredentials(){
			
			try{   
				 String receivedPassword = logindata.getPassword();	
				MongoCollection<Document> collection = db.getCollection("usercredentials");
				 credentials = collection.find(eq("_id",logindata.getStudent_id())).first();
				//if(credentials.getString("password").equals(HelpingFunctions.getHash(receivedPassword))){
				 if(credentials.getString("password").equals(receivedPassword)){
					loginType="normalLogin";
					return true;
				}
				else if(credentials.getString("temporarypassword").equals(HelpingFunctions.getHash(receivedPassword))){
					loginType="resetPassword";
					System.out.println(loginType);
					return true;
				}
			}catch(Exception e){
	   	     System.err.println( e.getClass().getName() + ": " + e.getMessage() );
	   	  }
			
			return false;
		}
		
		
		public String retrievEmailID(){
			
			try{   
				
				MongoCollection<Document> collection = db.getCollection("studenprofile");
				 credentials = collection.find(eq("_id",logindata.getStudent_id())).first();
				return credentials.getString("parentEmail");
			}catch(Exception e){
	   	     System.err.println( e.getClass().getName() + ": " + e.getMessage() );
	   	  }
			
			return null;
			
		}
		
	
		public Document getStudentRecord(){
			MongoCollection<Document> collection = db.getCollection("studenprofile");
			 credentials = collection.find(eq("_id",logindata.getStudent_id())).first();
			return credentials;
		}
		
}
