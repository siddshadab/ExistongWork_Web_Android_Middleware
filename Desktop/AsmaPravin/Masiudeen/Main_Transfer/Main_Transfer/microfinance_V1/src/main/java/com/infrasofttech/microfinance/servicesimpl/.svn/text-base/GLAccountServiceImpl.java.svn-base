package com.infrasofttech.microfinance.servicesimpl;
import java.util.List;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.GLAccountEntity;
import com.infrasofttech.microfinance.repository.GLAccountRepository;
import com.infrasofttech.microfinance.services.GLAccountService;


@Service
@Transactional
public class GLAccountServiceImpl implements GLAccountService{

	@Autowired
	GLAccountRepository repo;
	
	
	@Transactional
	@Override
	public ResponseEntity<?> getDataByMlbrcode(int mLbrcode) {
		try {
			List<GLAccountEntity> glAccountList=repo.findByMlbrCode(mLbrcode);
			if(glAccountList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<GLAccountEntity>>(glAccountList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	
	

}
