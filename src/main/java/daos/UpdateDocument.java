package daos;

import static com.mongodb.client.model.Filters.eq;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

public class UpdateDocument {

	private MongoDatabase db;
	private MongoClient mongoClient;
	
	public UpdateDocument(){
		try{
			/*mongoClient = new MongoClient("localhost", 27017);
			db = mongoClient.getDatabase("progressreport");*/
			
			String textUri = "mongodb://admin:admin@ds011379.mlab.com:11379/progressreport";
 			MongoClientURI uri = new MongoClientURI(textUri);
 			MongoClient m = new MongoClient(uri);			
 			db = m.getDatabase(uri.getDatabase());
	
		}catch(Exception e){
			e.printStackTrace();
		}
	}


	
	public boolean updateTemporaryPassword(String customerid,String password){
		
		try{   
			System.out.println(customerid+"update temporary password"+password);
			MongoCollection<Document> collection = db.getCollection("usercredentials");
			// credentials = collection.find(eq("_id",logindata.getStudent_id())).first();
			  collection.updateOne(new Document("_id",customerid), new Document("$set",new Document("temporarypassword",password)));
			//return credentials.getString("password");
		}catch(Exception e){
   	     System.err.println( e.getClass().getName() + ": " + e.getMessage() );
   	     return false;
   	  }
		return true;
	}
	
public boolean updatePrimaryPassword(String customerid,String password){
		
		try{   
			System.out.println(customerid+"update temporary password"+password);
			MongoCollection<Document> collection = db.getCollection("usercredentials");
			// credentials = collection.find(eq("_id",logindata.getStudent_id())).first();
			  collection.updateOne(new Document("_id",customerid), new Document("$set",new Document("password",password)));
			//return credentials.getString("password");
		}catch(Exception e){
   	     System.err.println( e.getClass().getName() + ": " + e.getMessage() );
   	     return false;
   	  }
		return true;
	}
	
}

	

