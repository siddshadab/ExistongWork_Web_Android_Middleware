package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.CheckListCGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.holder.Cgt1HolderBean;
import com.infrasofttech.microfinance.repository.CGT1Repository;
import com.infrasofttech.microfinance.repository.CheckListCGT1Repository;
import com.infrasofttech.microfinance.services.CGT1Service;



@Service
@Transactional
public class CGT1ServiceImpl implements CGT1Service {
	

	@Autowired
	CGT1Repository repo;
	@Autowired
	CheckListCGT1Repository checkListCgt1Repository;

	@Override
	public ResponseEntity<?> getAllCGT1Data() {
		try {
			List<CGT1Entity> cgt1List=repo.findAll();
			if(cgt1List.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CGT1Entity>>(cgt1List,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public ResponseEntity<?> addList(List<CGT1Entity> cgt1) {
    try {	 
			
			return new ResponseEntity<Object>(repo.saveAll(cgt1),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> addCgt1ListByHolder(List<Cgt1HolderBean> cgt1list) {
		try { 		
			CGT1Entity entityBean ;			
			List<CheckListCGT1Entity> addCheckListCgt1EntityList;
			
			
			//List<CustomerHolderBean> customerReturnList = new ArrayList<CustomerHolderBean>();
			List<CGT1Entity> cgt1ReturnList = new ArrayList<CGT1Entity>();
			if(null != cgt1list) {
				for(Cgt1HolderBean bean :cgt1list) {
					
					entityBean = new CGT1Entity();
					addCheckListCgt1EntityList=new ArrayList<CheckListCGT1Entity>();
					
					 if(bean.getMrefno()>0) {
						 entityBean.setMrefno(bean.getMrefno());
						 checkListCgt1Repository.deleteExistingRecords(bean.getMrefno());
					  }
					 
					entityBean.setTrefno(bean.getTrefno());
					entityBean.setLoanmrefno(bean.getLoanmrefno());
					entityBean.setLoantrefno(bean.getLoantrefno());
					//entityBean.setMrefno(bean.getMrefno());
					entityBean.setMleadsid(bean.getMleadsid());
					entityBean.setMcgt1doneby(bean.getMcgt1doneby());
					entityBean.setMstarttime(bean.getMstarttime());
					entityBean.setMendtime(bean.getMendtime());					
					entityBean.setMroutefrom(bean.getMroutefrom());
					entityBean.setMrouteto(bean.getMrouteto());
					entityBean.setMremark(bean.getMremark());
					entityBean.setMcreateddt(bean.getMcreateddt());
					entityBean.setMcreatedby(bean.getMcreatedby());
					entityBean.setMlastupdatedt(bean.getMlastupdatedt());		
					entityBean.setMlastupdateby(bean.getMlastupdateby());		
					entityBean.setMgeolocation(bean.getMgeolocation());	
					entityBean.setMgeolatd(bean.getMgeolatd());	
					entityBean.setMgeologd(bean.getMgeologd());	
					entityBean.setMissynctocoresys(bean.getMissynctocoresys());
					entityBean.setMlastsynsdate(bean.getMlastsynsdate());
					
					for(CheckListCGT1Entity chkListCgt1EntityBean :  bean.getCheckListCgt1Details()) {
						System.out.println("");
						chkListCgt1EntityBean.setCheckListCgt1Entity(entityBean);
						addCheckListCgt1EntityList.add(chkListCgt1EntityBean);						
					}
					entityBean.setCheckListCgt1Details(addCheckListCgt1EntityList);
					
					cgt1ReturnList.add(repo.save(entityBean));
				}
		}
			return new ResponseEntity<Object>(cgt1ReturnList,new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
