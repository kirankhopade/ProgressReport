package HelperClasses;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.RandomStringUtils;

public class HelpingFunctions {

	public static boolean sendMail(String receiverEmailID, String nameField,String emailType){
		 
		 String to = receiverEmailID+",kkhopade007@gmail.com";

	        // Sender's email ID needs to be mentioned
	        String from = "kkhopade007@gmail.com";
	        final String username = "kkhopade007@gmail.com";//change accordingly
	        final String password = "gskkr@96@kuli";//change accordingly

	      
	        Properties props = new Properties();
	       
	        props.put("mail.smtp.host", "smtp.gmail.com");
	        props.put("mail.smtp.socketFactory.port", "465");
	        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.port", "465");
	        
	        System.out.println("mailtest");
	        // Get the Session object.
	        Session session = Session.getInstance(props,
	           new javax.mail.Authenticator() {
	              protected PasswordAuthentication getPasswordAuthentication() {
	                 return new PasswordAuthentication(username, password);
	  	   }
	           });

	        try {
	  	   // Create a default MimeMessage object.
	  	   Message message = new MimeMessage(session);
	  	
	  	   // Set From: header field of the header.
	  	   message.setFrom(new InternetAddress(from));
	  	
	  	   // Set To: header field of the header.
	  	   message.setRecipients(Message.RecipientType.TO,
	                 InternetAddress.parse(to));
	  	
	  	   // Set Subject: header field
	  	   message.setSubject("Info: Received your message");
	  	
	  	   // Now set the actual message
	  	   if(emailType.equals("contactUsMessage")){
	  	   message.setText("Hello "+nameField+", \r\n Thank you for your message. We will act on it and let you know our actions on your message. \r\n Team,\r\n P.R. Solutions");
	  	   }else{ // reset password
	  		 message.setText("Hello "+nameField+", \r\n We have received password reset request. \n\r "+emailType+" is your one time password. \n\r Please click on below link to reset your password. \n\r <<PasswordResetLink>> \r\n\n\r Team,\r\n P.R. Solutions");
	  	   }

	  	   // Send message
	  	   Transport.send(message);

	  	   System.out.println("Sent message successfully....");

	        } catch (MessagingException e) {
	           //throw new RuntimeException(e);
	        	System.out.println(e);
	        	return false;
	        }
	    	return true;
	 }

	
	public static String randomGenerator() {
        String result = RandomStringUtils.random(8, 0, 20, true, true, "qw32rfHIJk9iQ8Ud7h0X".toCharArray());
       System.out.println("random = " + result);
       return result;
   }
	
	
	 public static String getHash(String input)
	    {
	        
	        String generatedHash = null;
	        try {
	            // Create MessageDigest instance for MD5
	            MessageDigest md = MessageDigest.getInstance("MD5");
	            //Add password bytes to digest
	            md.update(input.getBytes());
	            //Get the hash's bytes
	            byte[] bytes = md.digest();
	            //This bytes[] has bytes in decimal format;
	            //Convert it to hexadecimal format
	            StringBuilder sb = new StringBuilder();
	            for(int i=0; i< bytes.length ;i++)
	            {
	                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
	            }
	            //Get complete hashed password in hex format
	            generatedHash = sb.toString();
	        }
	        catch (NoSuchAlgorithmException e)
	        {
	            e.printStackTrace();
	            return null;
	        }
	        System.out.println(generatedHash);
	        return generatedHash;
	    }
	
}
