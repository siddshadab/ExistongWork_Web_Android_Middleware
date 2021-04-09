package com.infrasofttech.microfinance.configurations;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.servicesimpl.SystemParameterServicesImpl;

@Component
@Order(1)
public class ServerStartup implements CommandLineRunner {
	
	@Autowired
	SystemParameterServicesImpl systemParamServiceImpl;

	@Override
	public void run(String... args) throws Exception {
		String checkVar = "";
		Constants.getImages = systemParamServiceImpl.getCodeValue("GETIMAGES");
		Constants.getFingerPrint = systemParamServiceImpl.getCodeValue("GETFINGERPRINT");
		Constants.prospectValidityDays = systemParamServiceImpl.getCodeValue("PROSPECTVALIDITYDAYS");
		try {
			
			checkVar = systemParamServiceImpl.getCodeValue("LEADVALIDITYDAYS");
			Constants.leadValidityDays = checkVar==null?0:
				Integer.parseInt(checkVar);
				;
		}catch(Exception e ) {
			Constants.leadValidityDays = 60;
		}
		//System.out.println("XXXXXXX validity days are" + Constants.prospectValidityDays);
		
		
		System.out.println("get images  = " + Constants.getImages);
		System.out.println("get fingerprint  = " + Constants.getFingerPrint);			
		System.out.println("get prospect Validity  = " + Constants.prospectValidityDays);	
		System.out.println("lead Validity Days  = " + Constants.leadValidityDays);		
		
	}
	
	
	

	
}
