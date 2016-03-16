package daos;

import static java.util.Arrays.asList;

import java.util.ArrayList;

import org.bson.Document;

import pojos.Notifications;

import com.mongodb.Block;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoDatabase;

public class NotificationsDAO {

	private MongoDatabase db;
	private MongoClient mongoClient;
	
	public NotificationsDAO(){
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
	
	
	public ArrayList<Notifications> getNotifications_parentsAndStudents(String institute_id, String std_class, String division, String notificationType){
		
		System.out.println("Notification DAO");
		
		final ArrayList <Notifications> list = new ArrayList<Notifications>();
		try{
			 AggregateIterable<Document> iterable = db.getCollection("notifications").aggregate(asList(
		    			//new Document("$match", new Document("inst_id" , "INST-A001").append("std_class" , "all").append("division","V"))));
					 new Document("$match", new Document("inst_id" , institute_id).append("std_class" , std_class).append("division",division).append("type", notificationType))));
		      
	         
		       iterable.forEach(new Block<Document>() {
		    	    @Override
		    	    public void apply(final Document document) {
		    	    		Notifications notificationObject = new Notifications();
		    	    		notificationObject.setSubject(document.getString("subject"));
		    	    		notificationObject.setMessage(document.getString("message"));
		    	    		notificationObject.setDate((document.getDate("date")).toString());
		    	    		list.add(notificationObject);
		    	        System.out.println(document.toJson());
		    	    }
		    	});
			
		       list.addAll(getNotifications_institute(institute_id,"institute_common"));
		       
		}catch(Exception e){System.out.println("NotificationsDAO :: getNotifications_parentsAndStudents(...)"+e);}
		
		return list;
	}
	
	public ArrayList<Notifications> getNotifications_institute(String institute_id, String notificationType){

		System.out.println("Notification DAO");
		
		final ArrayList <Notifications> list = new ArrayList<Notifications>();
		try{
			 AggregateIterable<Document> iterable = db.getCollection("notifications").aggregate(asList(
		    			//new Document("$match", new Document("inst_id" , "INST-A001").append("std_class" , "all").append("division","V"))));
					 new Document("$match", new Document("inst_id" , institute_id).append("type" , notificationType))));
		      
	         
		       iterable.forEach(new Block<Document>() {
		    	    @Override
		    	    public void apply(final Document document) {
		    	    		Notifications notificationObject = new Notifications();
		    	    		notificationObject.setSubject(document.getString("subject"));
		    	    		notificationObject.setMessage(document.getString("message"));
		    	    		notificationObject.setDate((document.getDate("date")).toString());
		    	    		list.add(notificationObject);
		    	        System.out.println(document.toJson());
		    	    }
		    	});
			
		}catch(Exception e){System.out.println("NotificationsDAO :: getNotifications_institute(.)"+e);}
		return list;
	}
}
