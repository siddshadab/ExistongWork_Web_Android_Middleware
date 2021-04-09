package com.infrasofttech.microfinance.configurations;


import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.HTTP;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;

@Component
@Order(1)
public class CustomURLFilter implements Filter {

	 private static final Logger LOGGER = LoggerFactory.getLogger(CustomURLFilter.class);

	 @Override
	 public void init(FilterConfig filterConfig) throws ServletException {
	  LOGGER.info("########## Initiating CustomURLFilter filter ##########");
	 }

	// @Override
	 //public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
	 public void doFilterT(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

	  HttpServletRequest request = (HttpServletRequest) servletRequest;
	  HttpServletResponse response = (HttpServletResponse) servletResponse;
	  StringBuffer jb = new StringBuffer();
	  String line = null;
	  try {
		  //  System.out.println("Data of request "+request.getReader());
	    BufferedReader reader = request.getReader();
	    while ((line = reader.readLine()) != null)
	    	System.out.println("Data of request "+line.toString());
	      jb.append(line);
	  } catch (Exception e) {
		  e.printStackTrace();  
	  }
      filterChain.doFilter(request, response);
	 }

	 
	 
	 
	 @Override
	    public void doFilter(
	      ServletRequest request, 
	      ServletResponse response, 
	      FilterChain chain) throws IOException, ServletException {
	  
	        HttpServletRequest req = (HttpServletRequest) request;
	        HttpServletResponse res = (HttpServletResponse) response;
	        
	        ContentCachingRequestWrapper requestWrapper = new ContentCachingRequestWrapper((HttpServletRequest) req);
	        ContentCachingResponseWrapper responseWrapper = new ContentCachingResponseWrapper((HttpServletResponse) res);

	        try {
	            chain.doFilter(requestWrapper, responseWrapper);
	        } finally {

	            String requestBody = new String(requestWrapper.getContentAsByteArray());
	            String responseBody = new String(responseWrapper.getContentAsByteArray());
	            // Do not forget this line after reading response content or actual response will be empty!
	            responseWrapper.copyBodyToResponse();
	            System.out.println("requestWrapper.getContentAsByteArray() >>>>>>>>>>> : "+requestWrapper.getContentAsByteArray());
	            
	            System.out.println("Request >>>>>>>>>>> : "+requestBody);
	            System.out.println("Response >>>>>>>>>>> : "+responseBody);

	            // Write request and response body, headers, timestamps etc. to log files

	        }
	    }
	 
	    // other methods
	 @Override
	 public void destroy() {

	 }
	}