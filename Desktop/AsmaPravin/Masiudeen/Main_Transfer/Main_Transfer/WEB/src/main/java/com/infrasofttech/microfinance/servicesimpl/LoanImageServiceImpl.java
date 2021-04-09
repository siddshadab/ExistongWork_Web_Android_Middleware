package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.LoanImageEntity;
import com.infrasofttech.microfinance.repository.GroupsFoundationsRepository;
import com.infrasofttech.microfinance.repository.LoanImageRepository;
import com.infrasofttech.microfinance.services.CGT1Service;
import com.infrasofttech.microfinance.services.LoanImageService;


@Service
@Transactional
public class LoanImageServiceImpl implements LoanImageService {
	
	@Autowired
	LoanImageRepository loanImageRepo;

	@Override
	public ResponseEntity<?> getAllLoanImageData() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity<?> addList(List<LoanImageEntity> loanImageEntity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Transactional
	@Override
	public ResponseEntity<?> addLoanImageBuHolder(List<LoanImageEntity> loanImageEntity) {
		// TODO Auto-generated method stub

		try {
			return new ResponseEntity<Object>(loanImageRepo.saveAll(loanImageEntity),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
