/*
 * Author : Kiran
 * Contains code for:
 * 1. Connect to DB.
 * 2. Retrieve password for entered student and verifies entered password. 
 * 3. Returns student profile document.
 */

package daos;

import java.util.ArrayList;
import java.util.List;

import org.bson.Document;

import HelperClasses.HelpingFunctions;

import com.mongodb.Block;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import static com.mongodb.client.model.Filters.*;
import pojos.LoginCredentials;



public class LoginDAO {

	


	private LoginCredentials logindata;
	private MongoClient mongoClient;
	private MongoDatabase db;
	private Document retrievedDocument=null;
	private String loginType="";   // to store login type is normal login or reset password login
	private String loginErrorMessage="";

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
		
		public String getloginErrorMessage() {
			return loginErrorMessage;
		}
		public void setloginErrorMessage(String loginErrorMessage) {
			this.loginErrorMessage = loginErrorMessage;
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
		public boolean validateCredentials(String loginUserType){
			
			try{   
				 String receivedPassword = logindata.getPassword();	
				MongoCollection<Document> collection = db.getCollection("usercredentials");
				retrievedDocument = collection.find(eq("_id",logindata.getStudent_id())).first();
				
				/* if(credentials.getString("password").equals(HelpingFunctions.getHash(receivedPassword)) && loginUserType.equals(credentials.getString("customedtype"))){
					loginType="normalLogin";
					return true;
				}
				else if(credentials.getString("temporarypassword").equals(HelpingFunctions.getHash(receivedPassword))){
					loginType="resetPassword";
					System.out.println(loginType);
					return true;
				}*/
				 
				 if(retrievedDocument.getString("password").equals(HelpingFunctions.getHash(receivedPassword))){
					  if(loginUserType.equals(retrievedDocument.getString("customedtype"))){
						  loginType="normalLogin";
							return true;
					  }else{
						  
						  loginErrorMessage="Customer ID and Password does not match with the selected account type.!!!";
					  }
					 
				 }else if(retrievedDocument.getString("temporarypassword").equals(HelpingFunctions.getHash(receivedPassword))){
					 
					 loginType="resetPassword";
						System.out.println(loginType);
						return true;
				 }
				 else{
					 loginErrorMessage="Customer ID and Password does not match.!!!";
				 }
					 
									 
				/* if(!loginUserType.equals(credentials.getString("customedtype"))){
					 loginErrorMessage="Credentials does not match with the selected account type";
				 }*/
			}catch(Exception e){
	   	     System.err.println( e.getClass().getName() + ": " + e.getMessage() );
	   	  }
			
			return false;
		}
		
		
		public String retrieveEmailID(){
			
			try{   
				
				MongoCollection<Document> collection = db.getCollection("studenprofile");
				retrievedDocument = collection.find(eq("_id",logindata.getStudent_id())).first();
				return retrievedDocument.getString("parentEmail");
			}catch(Exception e){
	   	     System.err.println( e.getClass().getName() + ": " + e.getMessage() );
	   	  }
			
			return null;
			
		}
		
	   public String retrieveCustomerId(String emailid){
		   
		   final List<String> customerIDList = new ArrayList<String>();
		   try{   
				
				MongoCollection<Document> collection = db.getCollection("studenprofile");
			/*	 FindIterable<Document> documentSet = collection.find(eq("parentEmail",emailid));*/
			//	return documentSet.getString("parentEmail");
				 FindIterable<Document> iterable = db.getCollection("studenprofile").find(
					        new Document("parentEmail", emailid));
				 
				 iterable.forEach(new Block<Document>() {
					    public void apply(final Document document) {
					        System.out.println(document);
					        String details=document.getString("_id")+" : "+((Document)document.get("studentName")).getString("firstName")+" "+((Document)document.get("studentName")).getString("lastName")+"\r\n";
					        customerIDList.add(details);
					    }
					});
			}catch(Exception e){
				
	   	     System.err.println( e.getClass().getName() + ": " + e.getMessage() );
	   	     return null;
	   	  }
			
			return customerIDList.toString();
	   }
	   
	   
		public Document getStudentRecord(){
			MongoCollection<Document> collection = db.getCollection("studenprofile");
			retrievedDocument = collection.find(eq("_id",logindata.getStudent_id())).first();
			return retrievedDocument;
		}
		
}
