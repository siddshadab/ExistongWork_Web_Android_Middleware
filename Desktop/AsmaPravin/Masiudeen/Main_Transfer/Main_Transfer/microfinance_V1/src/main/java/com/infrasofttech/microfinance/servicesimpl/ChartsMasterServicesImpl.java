package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.ChartsMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.MenuMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuAndAccessRightsHolderBean;
import com.infrasofttech.microfinance.repository.ChartsMasterRepository;
import com.infrasofttech.microfinance.services.ChartsMasterService;


@Service
@Transactional
public class ChartsMasterServicesImpl  implements ChartsMasterService {
	
	
	@Autowired
	UserAccessRightsServicesImpl userAccessRightsServicesImpl;
	
	@Autowired
	ChartsMasterRepository repo;
	

	@Autowired
	MenuMasterServiceImpl menuMasterServiceImpl;
	
	
	@Transactional
	@Override
	public ResponseEntity<?> getChartsDataByAccessRightAndChartsMaster(String musrcode,int mgrpcd) {	
		
		try {			
			List<ChartsMasterEntity> retListBean = null; 			
			
			List<MenuAndAccessRightsHolderBean> menuAndAccessRightsHolderBean=userAccessRightsServicesImpl.getChartsIdOnMenuAndAccessJoin(musrcode,mgrpcd);
			
			if(menuAndAccessRightsHolderBean!=null) {
                retListBean = new ArrayList<ChartsMasterEntity>();
			}			
			
			//TODO Later Join on charts table as well intead call inidividuall call(Shadab)			
			for(MenuAndAccessRightsHolderBean bean :menuAndAccessRightsHolderBean) {
				ChartsMasterEntity addBean = repo.findByMchartid(bean.getMchartid());
				retListBean.add(addBean);
				
			}
			
			if(retListBean.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<ChartsMasterEntity>>(retListBean,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}
	
	
	
	@Transactional
	@Override
	public ResponseEntity<?> getJoinAllthreeTables(String musrcode,int mgrpcd) {	
		
	try {			
			
			//List<MenuAndAccessRightsHolderBean> menuAndAccessRightsHolderBean=repo.getJoinAllthreeTables(musrcode,mgrpcd);
		List<ChartsMasterEntity> menuAndAccessRightsHolderBean=repo.getJoinAllthreeTables(musrcode,mgrpcd);
						
			if(menuAndAccessRightsHolderBean.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<ChartsMasterEntity>>(menuAndAccessRightsHolderBean,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	
	
	

}
