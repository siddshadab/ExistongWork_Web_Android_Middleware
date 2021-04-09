package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CheckListGRTEntity;
import com.infrasofttech.microfinance.entityBeans.master.GRTEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.GrtHolderBean;
import com.infrasofttech.microfinance.repository.CheckListGRTRepository;
import com.infrasofttech.microfinance.repository.GRTRepository;
import com.infrasofttech.microfinance.services.GRTService;



@Service
@Transactional
public class GRTServiceImpl implements GRTService {
	

	@Autowired
	GRTRepository repo;
	@Autowired
	CheckListGRTRepository checkListGrtRepository;

	@Override
	public ResponseEntity<?>  getAllGRTData() {
		try {
			List<GRTEntity> grtList=repo.findAll();
			if(grtList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<GRTEntity>>(grtList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Transactional
	@Override
	public ResponseEntity<?> addList(List<GRTEntity> grt) {
    try {	 
			
			return new ResponseEntity<Object>(repo.saveAll(grt),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> addGrtListByHolder(List<GrtHolderBean> grtlist) {
		try { 		
			GRTEntity entityBean ;			
			List<CheckListGRTEntity> addCheckListGrtEntityList;
			
			
			//List<CustomerHolderBean> customerReturnList = new ArrayList<CustomerHolderBean>();
			List<GRTEntity> grtReturnList = new ArrayList<GRTEntity>();
			if(null != grtlist) {
				for(GrtHolderBean bean :grtlist) {
					
					entityBean = new GRTEntity();
					addCheckListGrtEntityList=new ArrayList<CheckListGRTEntity>();
					
					 if(bean.getMrefno()>0) {
						 entityBean.setMrefno(bean.getMrefno());
						 checkListGrtRepository.deleteExistingRecords(bean.getMrefno());
					  }
					 
					entityBean.setTrefno(bean.getTrefno());
					//entityBean.setMrefno(bean.getMrefno());
					entityBean.setLoanmrefno(bean.getLoanmrefno());
					entityBean.setLoantrefno(bean.getLoantrefno());
					entityBean.setMleadsid(bean.getMleadsid());
					entityBean.setMgrtdoneby(bean.getMgrtdoneby());
					entityBean.setMstarttime(bean.getMstarttime());
					entityBean.setMendtime(bean.getMendtime());					
					entityBean.setMroutefrom(bean.getMroutefrom());
					entityBean.setMrouteto(bean.getMrouteto());
					entityBean.setMremark(bean.getMremark());
					entityBean.setMidtype1status(bean.getMidtype1status());
					entityBean.setMidtype2status(bean.getMidtype2status());
					entityBean.setMidtype3status(bean.getMidtype3status());
					entityBean.setMcreateddt(bean.getMcreateddt());
					entityBean.setMcreatedby(bean.getMcreatedby());
					entityBean.setMlastupdatedt(bean.getMlastupdatedt());		
					entityBean.setMlastupdateby(bean.getMlastupdateby());		
					entityBean.setMgeolocation(bean.getMgeolocation());	
					entityBean.setMgeolatd(bean.getMgeolatd());	
					entityBean.setMgeologd(bean.getMgeologd());	
					entityBean.setMissynctocoresys(bean.getMissynctocoresys());
					entityBean.setMlastsynsdate(bean.getMlastsynsdate());
					
					for(CheckListGRTEntity chkListGrtEntityBean :  bean.getCheckListGrtDetails()) {
						System.out.println("");
						chkListGrtEntityBean.setCheckListGrtEntity(entityBean);
						addCheckListGrtEntityList.add(chkListGrtEntityBean);						
					}
					entityBean.setCheckListGrtDetails(addCheckListGrtEntityList);
					
					grtReturnList.add(repo.save(entityBean));
				}
		}
			return new ResponseEntity<Object>(grtReturnList,new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

}
