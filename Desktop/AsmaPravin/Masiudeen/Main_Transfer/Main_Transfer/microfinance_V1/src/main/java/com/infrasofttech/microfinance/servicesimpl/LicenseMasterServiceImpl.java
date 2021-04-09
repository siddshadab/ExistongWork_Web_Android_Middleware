package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.LicenseMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.repository.BranchMasterRepository;
import com.infrasofttech.microfinance.repository.LicenseMasterRepository;
import com.infrasofttech.microfinance.repository.SystemParameterRepository;
import com.infrasofttech.microfinance.repository.UserMasterDetailsRepository;
import com.infrasofttech.microfinance.services.LicenseMasterService;

@Service
@Transactional
public class LicenseMasterServiceImpl implements LicenseMasterService {

	@Autowired
	BranchMasterRepository branchMasterRepo;
	
	@Autowired
	UserMasterDetailsRepository userMasterRepo;
	
	@Autowired
	LicenseMasterRepository licenseMasterRepo;
	
	@Autowired
	SystemParameterServicesImpl systemParamService;
	
	
	@Override
	public void updateLiceseValidation() {
		
		Constants.currentNoOfUsers = userMasterRepo.findDistinctUserCode()  ;
		
		Constants.currentNoOfBranches = branchMasterRepo.findDistinctLbrCodeCount();
		System.out.println("Actual No Of Users " + Constants.currentNoOfUsers);
		System.out.println("Actual No Of branches " + Constants.currentNoOfBranches);
		LicenseMasterEntity licenseEntity = getLicenseKey();
		try {
			String decodedString = deCode(licenseEntity.getMlicensekey(),Constants.licenseKey);
			
			//String decodedString = deCode("khka]cdfjiRQS",Constants.licenseKey);
			System.out.println(decodedString);
			String [] arr = decodedString.split("!");
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			int listSize = arr.length;
			if(listSize==1) {
				Constants.allowedNoOfBranches = 99999;
				Constants.allowedNoOfUsers = 99999;
				String apk = systemParamService.getCodeValue("APKVERSION");
				
				
				if(apk==null||"".equals(apk)) 
				{
					Constants.apkversion = "Not needed";
				}
				else {
					Constants.apkversion = apk;
				}
				
			}
			else if(listSize==2) {
				
				Constants.allowedNoOfUsers = 99999;
				String apk = systemParamService.getCodeValue("APKVERSION");
				
				
				if(apk==null||"".equals(apk)) 
				{
					Constants.apkversion = "Not needed";
				}
				else {
					Constants.apkversion = apk;
				}
				
			}else if(listSize==3) {
				
				String apk = systemParamService.getCodeValue("APKVERSION");
				
				
				if(apk==null||"".equals(apk)) 
				{
					Constants.apkversion = "Not needed";
				}
				else {
					Constants.apkversion = apk;
				}
				
			}
			for(int i= 0;i<arr.length;i++) {
				
				if(i==0) {
					Constants.allowedLicenseDate  = LocalDateTime.parse(arr[i]+" 00:00:00", formatter);
				}else if(i==1) {
					try {
						Constants.allowedNoOfBranches = Integer.parseInt(arr[i]);
					}catch(Exception e) {
						
						Constants.allowedNoOfBranches = 99999;
					}
					
					
				}else if(i==2) {
					try {
						Constants.allowedNoOfUsers = Integer.parseInt(arr[i]);	
					}
					catch(Exception e) {
						Constants.allowedNoOfUsers = 99999;
					}
					
				}	
				else if(i==3) {
					if(arr[i]!=null && !("").equals(arr[i].trim())) {
						Constants.apkversion = arr[i].trim();
						
					}
					else {
						String apk = systemParamService.getCodeValue("APKVERSION");
						
								
								if(apk==null||"".equals(apk)) 
								{
									Constants.apkversion = "Not needed";
								}
								else {
									Constants.apkversion = apk;
								}
						
					}
				}
			}
			
			
			
		}catch(Exception e) {
			Constants.allowedLicenseDate = null;
			Constants.apkversion= "";
			Constants.allowedNoOfBranches = 0;
			Constants.allowedNoOfUsers = 0;
			
		}
		
		System.out.println("allowed License date "+Constants.allowedLicenseDate);
		System.out.println("allowed apk version "+ Constants.apkversion);
		System.out.println("allowed number of branches "+Constants.allowedNoOfBranches);
		System.out.println("allowedNumber of users" + Constants.allowedNoOfUsers);
		
		
		
		
		
		
		// TODO Auto-generated method stub
		
	}


	@Override
	public LicenseMasterEntity getLicenseKey() {
		// TODO Auto-generated method stub
		
		return licenseMasterRepo.findLicenseKey();
	}
	
	
	public LocalDateTime getCurrentTime() {
		// TODO Auto-generated method stub
		
		return licenseMasterRepo.getCurrentTime();
	}
	
	
	
	
    
    public static String deCode(String EncodedString , String privatekey ) {
		
		String combinedKey= "";
		char[] c = privatekey.toCharArray();
	    char[] d = EncodedString.toCharArray(); 
	    
	    char hell ;
	    for(int i = 0;i<d.length;i++) {
	    	if(i==0) {
	    		hell = (char) (d[i] -  c[i]);
	    		
	    	}
	    	else {
	    		
	    		hell = (char)(d[i] - c[i%privatekey.length()]);
	    		
	    	}
	    	
	    	
	    	combinedKey = combinedKey+hell;	
	    	
	    }
	
		
		
		return combinedKey;
	}
	
	
	
	
	public static String encodeKey(String StringToEncode , String privatekey) {
		
		
		char[] c = privatekey.toCharArray();
	    char[] d = StringToEncode.toCharArray(); 
	    String combinedKey=  "";  
	    
	    
	    for(int i = 0;i<d.length;i++) {
	    	
	    char hell ;
	    if(i==0) {
	    	
	    	hell = (char) (d[i] + c[i]); 
	    }
	    else {
	    	hell = (char)(d[i] + c[i%privatekey.length()]);
	    	
	    }
	    
	    
	    combinedKey = combinedKey+hell;	    
	    	
	    }
	    
	    System.out.println(combinedKey);
		
	    return combinedKey;
		
	}


	@Override
	public ResponseEntity<?> add(LicenseMasterEntity licenseMasterntity) {
		// TODO Auto-generated method stub
		
		
		try {
			System.out.println(licenseMasterntity);
			return new ResponseEntity<Object>(licenseMasterRepo.save(licenseMasterntity),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
    
	
	

	
}
