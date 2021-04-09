package com.infrasofttech.microfinance;

import java.util.List;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.jpa.convert.threeten.Jsr310JpaConverters;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.infrasofttech.microfinance.entityBeans.master.JsonMenuEntity;
import com.infrasofttech.microfinance.services.JsonMasterService;
import com.infrasofttech.microfinance.services.MenuMasterService;
import com.infrasofttech.microfinance.servicesimpl.JsonMasterServiceImp;
import com.infrasofttech.microfinance.servicesimpl.MenuMasterServiceImpl;

@EntityScan(basePackageClasses = { MicrofinanceV1Application.class, Jsr310JpaConverters.class }

)

@SpringBootApplication(exclude = { SecurityAutoConfiguration.class })
@EnableScheduling
@PropertySource(value = "classpath:application.properties")
public class MicrofinanceV1Application {
	
	
	public static void main(String[] args) {
		SpringApplication.run(MicrofinanceV1Application.class, args);
	
	}


	
}