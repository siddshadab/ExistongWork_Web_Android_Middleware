package com.infrasofttech.microfinance.configurations;


import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.servicesimpl.LicenseMasterServiceImpl;

@Component
@Order(1)
public class CustomURLFilter implements Filter {

	
	@Autowired 
	LicenseMasterServiceImpl licenseMasterServiceImpl;
	
	 private static final Logger LOGGER = LoggerFactory.getLogger(CustomURLFilter.class);

	 @Override
	   public void destroy() {}

	   @Override
	   public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterchain) 
	      throws IOException, ServletException {
		   
		   System.out.println("yeh aya request Custom URL filter m ");
		   request = new AuthenticationRequestWrapper((HttpServletRequest) request);
		   
		   HttpServletRequest req = (HttpServletRequest) request;
	        HttpServletResponse res = (HttpServletResponse) response;
	        
	        try {

	        
	        String error ="No error" ; 
	        LocalDateTime currentDateTime = licenseMasterServiceImpl.getCurrentTime();
        	System.out.println("current date hai "+ currentDateTime);
	        
	        		
        	
        	
        	
        	
        	
        	//System.out.println(req.getRequestURI());
        	if((Constants.licenseUpdateURL).equals(req.getRequestURI())) {
        		filterchain.doFilter(request, response); 
        		
        	}
        	else if(Constants.allowedLicenseDate==null) {
	        	
	        			response.reset();
		 	        	((HttpServletResponse) response).setStatus(406);  
		 	        	return;
	        	}
        		else if(Constants.allowedNoOfUsers<Constants.currentNoOfUsers) {
	 	        	System.out.println("Exceeding Number of Users");
	 	        	response.reset();
	 	        	((HttpServletResponse) response).setStatus(402);  
	 	        	return;
	 	        	
	 	        	
	 	        }
	 	        else if(Constants.allowedNoOfBranches<Constants.currentNoOfBranches) {
	 	        	System.out.println("Exceeding Number of branches");
	 	        	response.reset();
	 	        	((HttpServletResponse) response).setStatus(403);  
	 	        	return;
	 	        	
	 	        }
	 	       else if(currentDateTime.isAfter(Constants.allowedLicenseDate)) {
	 	        	
	 	        	System.out.println("Exceeding License date");
	 	        	response.reset();
	 	        	((HttpServletResponse) response).setStatus(405);  
	 	        	return;
	 	        	
	 	        	
	 	        }
	 	       else if(("/userDetailsMaster/loginValidation").equals(req.getRequestURI())
	 	         ) {
	 	        	
	 	        	
	 	        	try {
	 	        		

	 	        		AuthenticationRequestWrapper authWrapper= (AuthenticationRequestWrapper)request;
	 	        		String reqToString =  authWrapper.getBody();
	 	     
		 	        	 System.out.println("reuwst puri aisi hai "+reqToString);
		 	        	String parsedApk = reqToString.substring(reqToString.indexOf(":")+2,
		 	        			reqToString.indexOf("\"", reqToString.indexOf(":")+2));
		 	        	System.out.println("aaya apk version "+ parsedApk);
		 	        	
		 	        	if(!Constants.apkversion.trim().equals(parsedApk.trim())&&!Constants.apkversion.trim().equals("Not needed") ) {
		 	        		System.out.println("Apk Version Mismatch");
			 	        	response.reset();
			 	        	((HttpServletResponse) response).setStatus(HttpServletResponse.SC_UNAUTHORIZED);  
			 	        	return;
		 	        		
		 	        	}
		 	        	else {
		 	        		
		 	        		System.out.println("aa gya hai filter chain k andar");
		 	        		filterchain.doFilter(request, response); 
		 	        		
		 	        	}
		 	        	System.out.println(parsedApk);
		 	        	
	 	        		
	 	        	
	 	        		
	 	        		
	 	        	}catch(Exception e) {
	 	        		
	 	        		System.out.println("apk parse krne m fta");
	 	        		e.printStackTrace();
	 	        		
	 	        		response.reset();
		 	        	((HttpServletResponse) response).setStatus(HttpServletResponse.SC_UNAUTHORIZED);  
		 	        	return;
	 	        		
	 	        	}
	 	        	
	 	        	
	 	        	
	 	        	//System.out.println(reader.readLine().to.indexOf(":"));
	 	        	//if(Double.parseDouble(reader.readLine().substring(4, 6))==apkversion)
	 	        	 
	 	        	
	 	        	
	 	        	
	 	        	
	 	       
	 	        }
	 	        else {
	 	        	System.out.println("sab badia chala");
	 	        	filterchain.doFilter(request, response); 	
	 	        	
	 	        }
	 	         	        
	        	
	        	
	        }catch(Exception e ) {
	        	
	        	e.printStackTrace();
	        }
	        
	        finally {

	        	System.out.println("Kuch Fat gya: ");
	        }
	   }

	   @Override
	   public void init(FilterConfig filterconfig) throws ServletException {
		   
		   System.out.println("Init chalu hua");
	   }
	}