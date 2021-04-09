package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.LoanUtilizationEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanUtilizationEntity;
import com.infrasofttech.microfinance.repository.LoanUtilizationRepository;
import com.infrasofttech.microfinance.services.LoanUtilizationService;



@Service
@Transactional
public class LoanUtilizationServiceImpl implements LoanUtilizationService {
	
	@Autowired
	LoanUtilizationRepository lurepo;
	@Transactional
	@Override
	public ResponseEntity<?> addList(List<LoanUtilizationEntity> lnutil) {

		System.out.println("lnutil::::::::::::::::::::::::::"+lnutil.toString());
	
			return new ResponseEntity<Object>(lurepo.saveAll(lnutil), new HttpHeaders(), HttpStatus.CREATED);
	

	}

}
