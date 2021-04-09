package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.ReportFilterEntity;
import com.infrasofttech.microfinance.repository.ReportFilterMasterRepository;
import com.infrasofttech.microfinance.services.ReportFilterMasterService;

@Service
@Transactional
public class ReportFilterMasterServiceImpl implements ReportFilterMasterService {
	
	@Autowired
	ReportFilterMasterRepository reportRepo;

	@Override
	public ResponseEntity<?> getReportFilterData() {
		// TODO Auto-generated method stub
		
		//List<ReportFilterEntity> reportList;
		try {
			
			
			return new ResponseEntity <List<ReportFilterEntity>>(reportRepo.findAll(),new HttpHeaders(),HttpStatus.CREATED) ;
			
			  
		}catch(Exception e) {
			
			new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;
		}
		return null;
	}
	
	

}
