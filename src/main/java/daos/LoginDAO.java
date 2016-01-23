/*
 * Author : Kiran
 * Contains code for:
 * 1. Connect to DB.
 * 2. Retrieve password for entered student and verifies entered password. 
 * 3. Returns student profile document.
 */

package daos;

import org.bson.Document;

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

	/*
	 * Constructor
	 */
	public LoginDAO(LoginCredentials logindata){
	
			this.logindata=logindata;
			try{
				//mongoClient = new MongoClient("localhost", 27017);
				//mongoClient = new MongoClient("mongodb://admin:admin@ds039125.mongolab.com:39125/progressreport");
				String textUri = "mongodb://admin:admin@ds039125.mongolab.com:39125/progressreport";
	 			MongoClientURI uri = new MongoClientURI(textUri);
	 			MongoClient m = new MongoClient(uri);
				//db = mongoClient.getDatabase("progressreport");
	 			db = m.getDatabase(uri.getDatabase());
		
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
		
		
		/*
		 * This method validates given password against password from database
		 */
		 public boolean validateCredentials(){
	
		  String retrievedPassword = this.retrievedPassword();
		   if(retrievedPassword!=null && retrievedPassword.equals(logindata.getPassword()))
		    	return true;
		    else
			   return false;
		   }
		
		
		
		/*
		 * This method gets a password from database and compares it with password given by an user.
		 */
		public String retrievedPassword(){
			
			try{   
						
				MongoCollection<Document> collection = db.getCollection("studenprofile");
				 credentials = collection.find(eq("_id",logindata.getStudent_id())).first();
				return credentials.getString("password");
			}catch(Exception e){
	   	     System.err.println( e.getClass().getName() + ": " + e.getMessage() );
	   	  }
			
			return null;
		}
		
	
		public Document getStudentRecord(){
			return credentials;
		}
		
}
