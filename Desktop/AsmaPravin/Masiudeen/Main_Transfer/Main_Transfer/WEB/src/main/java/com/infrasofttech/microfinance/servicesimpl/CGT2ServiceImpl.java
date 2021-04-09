package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CGT2Entity;
import com.infrasofttech.microfinance.entityBeans.master.CheckListCGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.CheckListCGT2Entity;
import com.infrasofttech.microfinance.entityBeans.master.holder.Cgt2HolderBean;
import com.infrasofttech.microfinance.repository.CGT2Repository;
import com.infrasofttech.microfinance.repository.CheckListCGT1Repository;
import com.infrasofttech.microfinance.repository.CheckListCGT2Repository;
import com.infrasofttech.microfinance.services.CGT2Service;



@Service
@Transactional
public class CGT2ServiceImpl implements CGT2Service {
	

	@Autowired
	CGT2Repository repo;
	@Autowired
	CheckListCGT2Repository checkListCgt2Repository;

	@Override
	public ResponseEntity<?> getAllCGT2Data() {
		try {
			List<CGT2Entity> cgt2List=repo.findAll();
			if(cgt2List.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CGT2Entity>>(cgt2List,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public ResponseEntity<?> addList(List<CGT2Entity> cgt2) {
    try {	 
			
			return new ResponseEntity<Object>(repo.saveAll(cgt2),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> addCgt2ListByHolder(List<Cgt2HolderBean> cgt2list) {
		try { 		
			CGT2Entity entityBean ;			
			List<CheckListCGT2Entity> addCheckListCgt2EntityList;
			
			
			//List<CustomerHolderBean> customerReturnList = new ArrayList<CustomerHolderBean>();
			List<CGT2Entity> cgt2ReturnList = new ArrayList<CGT2Entity>();
			if(null != cgt2list) {
				for(Cgt2HolderBean bean :cgt2list) {
					
					entityBean = new CGT2Entity();
					addCheckListCgt2EntityList=new ArrayList<CheckListCGT2Entity>();
					
					  if(bean.getMrefno()>0) { 
						  entityBean.setMrefno(bean.getMrefno());
					      checkListCgt2Repository.deleteExistingRecords(bean.getMrefno());
					  }
					 
					entityBean.setTrefno(bean.getTrefno());
					entityBean.setLoanmrefno(bean.getLoanmrefno());
					entityBean.setLoantrefno(bean.getLoantrefno());
					//entityBean.setMrefno(bean.getMrefno());
					entityBean.setMleadsid(bean.getMleadsid());
					entityBean.setMcgt2doneby(bean.getMcgt2doneby());
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
					
					for(CheckListCGT2Entity chkListCgt2EntityBean :  bean.getCheckListCgt2Details()) {
						System.out.println("");
						chkListCgt2EntityBean.setCheckListCgt2Entity(entityBean);
						addCheckListCgt2EntityList.add(chkListCgt2EntityBean);						
					}
					entityBean.setCheckListCgt2Details(addCheckListCgt2EntityList);
					
					cgt2ReturnList.add(repo.save(entityBean));
					
				}
		}
			return new ResponseEntity<Object>(cgt2ReturnList,new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
