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
import com.infrasofttech.microfinance.entityBeans.master.holder.ChartsMasterHolder;
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
	
	
	public ResponseEntity<?> getAll(){
		
		List<ChartsMasterEntity> list = repo.findAll();		
		return new ResponseEntity<Object>(list,new HttpHeaders(),HttpStatus.OK);
	}
	
	
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

	@Override
	public ResponseEntity<?> addChart(ChartsMasterEntity chartEntity) {
		try {
			ChartsMasterHolder hld= new ChartsMasterHolder();
			repo.save(chartEntity);
			hld.setMerror(200);
			hld.setMerrormsg("Record Added Successfully");
			
			return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.CREATED);
			
			
			
		}catch(Exception e) {
			
			
		}
		
		
		return null;
	}


//	@Override
//	public ResponseEntity<?> addCharts(ChartsMasterEntity chartsMasterEntity) {
//		try {
//			ChartsMasterEntity charts= repo.findByMrefno(chartsMasterEntity.getMrefno());
//			ChartsMasterHolder hld = new ChartsMasterHolder();
//			
//			if(charts == null) {
//			  repo.save(chartsMasterEntity);	
//			  hld.setMerror(200);
//			  hld.setMerrormsg("Record Added Succesfully");
//			  return new ResponseEntity<Object> (hld,new HttpHeaders(),HttpStatus.OK);
//			}else {
//				
//				hld.setMerror(200);
//				hld.setMerrormsg("Record Already Exists");
//				return new ResponseEntity<Object> (hld,new HttpHeaders(),HttpStatus.OK);
//			}
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			return new ResponseEntity<> (new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
//		}
//		
//	}
//
//
//
	@Override
	public ResponseEntity<?> editCharts(ChartsMasterEntity chartsMasterEntity) {
		try {
			
			ChartsMasterHolder hld = new ChartsMasterHolder();		
		
			repo.save(chartsMasterEntity);	
			hld.setMerror(200);
			hld.setMerrormsg("Record Updated Succesfully");
			return new ResponseEntity<Object> (hld,new HttpHeaders(),HttpStatus.OK);
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<> (new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}



	@Override
	public ResponseEntity<?> deleteCharts(List<Integer> mrefno) {

		try {
			
			ChartsMasterHolder hld = new ChartsMasterHolder();		
		
			if(mrefno != null) {
				repo.deleteByMrefno(mrefno);
				hld.setMerror(200);
				hld.setMerrormsg("Record Deleted Succesfully");
				return new ResponseEntity<Object> (hld,new HttpHeaders(),HttpStatus.OK);
			}else {
				hld.setMerror(200);
				hld.setMerrormsg("Something went wrong with Mref No");
				return new ResponseEntity<Object> (hld,new HttpHeaders(),HttpStatus.OK);
			}
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<> (new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	
	
	

}
