package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.CurrentLocationMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.PathTrackerMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SecondaryUserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CurrentLocationHolderBean;
import com.infrasofttech.microfinance.repository.CentersFoundationsRepository;
import com.infrasofttech.microfinance.repository.CurrentLocationMasterRepository;
import com.infrasofttech.microfinance.repository.PathTrackerMasterRepository;
import com.infrasofttech.microfinance.repository.SecondaryUserMasterRepository;
import com.infrasofttech.microfinance.services.CurrentLocationMasterService;

	
	@Service
	@Transactional
	public class CurrentLocationMasterServiceImpl implements CurrentLocationMasterService{

		@Autowired
		CurrentLocationMasterRepository currentLocationMasterRepository;
		@Autowired
		SecondaryUserMasterRepository secondaryUserMasterRepository;
		@Autowired
		CentersFoundationsRepository centerFoundationRepo;
		@Autowired
		PathTrackerMasterRepository pathTrackerMasterRepository;
		
		@Transactional
		@Override
		public ResponseEntity<?> add(CurrentLocationMasterEntity currentLocationMasterEntity) {
			try {
				return new ResponseEntity<Object>(currentLocationMasterRepository.save(currentLocationMasterEntity),new HttpHeaders(),HttpStatus.CREATED);
			} catch (Exception e) {
				//logger.error("Error While Persisting Object"+e.getMessage());
				return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}
		
		@Transactional
		@Override
		public ResponseEntity<?> addPathTracker(PathTrackerMasterEntity pathTrackerMasterEntity) {
			try {
				return new ResponseEntity<Object>(pathTrackerMasterRepository.save(pathTrackerMasterEntity),new HttpHeaders(),HttpStatus.CREATED);
			} catch (Exception e) {
				//logger.error("Error While Persisting Object"+e.getMessage());
				return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}
		
		
		
		@Transactional		
		public ResponseEntity<?> getPathTrackerDataFromUserId(String mCreatedBy) {
			try {
				List<PathTrackerMasterEntity> pathTrackerMasterEntity =pathTrackerMasterRepository.findBymusrcodeByLOcationNotNull(mCreatedBy);
				if(pathTrackerMasterEntity.isEmpty()) 
					return ResponseEntity.notFound().build();				
				
				return new ResponseEntity<List<PathTrackerMasterEntity>>(pathTrackerMasterEntity,new HttpHeaders(),HttpStatus.OK);
			}catch(Exception e) {
				//logger.error("No Record Found."+e.getMessage());
				return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}
		
		
		@Transactional	
		public List<CurrentLocationHolderBean> findBySuperUser(String SuperUuser) {
			
			List<CurrentLocationHolderBean> returnBeanList = new ArrayList<CurrentLocationHolderBean>();
			try {
				List<CurrentLocationMasterEntity> location  = currentLocationMasterRepository.findBySuperUser(SuperUuser);				
				for(CurrentLocationMasterEntity bean :location) {
					SecondaryUserMasterEntity profileImageBean = secondaryUserMasterRepository.findDataByUsrCode(bean.getMusrcode());
					CurrentLocationHolderBean returnBean = new CurrentLocationHolderBean();
					setBean(bean,profileImageBean,returnBean);
					returnBeanList.add(returnBean);
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			return returnBeanList;
		}
		
		
		@Transactional		
		public ResponseEntity<?> getDataByCreatedBy(String mCreatedBy) {
			try {
				List<CentersFoundationEntity> centerList=centerFoundationRepo.findByMcreatedByLOcationNotNull(mCreatedBy);
				if(centerList.isEmpty()) 
					return ResponseEntity.notFound().build();
				List<CurrentLocationMasterEntity> returnBeanList = new ArrayList<CurrentLocationMasterEntity>();
				for(CentersFoundationEntity bean :centerList) {					
					CurrentLocationMasterEntity returnBean = new CurrentLocationMasterEntity();
					setCenterBeanToLocationBean(bean,returnBean);
					returnBeanList.add(returnBean);
				}
				return new ResponseEntity<List<CurrentLocationMasterEntity>>(returnBeanList,new HttpHeaders(),HttpStatus.OK);
			}catch(Exception e) {
				//logger.error("No Record Found."+e.getMessage());
				return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
			}
		}


		private void setCenterBeanToLocationBean(CentersFoundationEntity bean, CurrentLocationMasterEntity returnBean) {
			// TODO Auto-generated method stub
			returnBean.setMcreatedby(String.valueOf(bean.getMmeetingday()));
			returnBean.setMcreateddt(bean.getMfirstmeetngdt());
			returnBean.setMlastupdatedt(bean.getMnextmeetngdt());
			returnBean.setMlastupdateby(bean.getMlastupdateby());
			returnBean.setMgeolocation(bean.getMgeolocation());
			returnBean.setMgeolatd(bean.getMgeolatd());
			returnBean.setMgeologd(bean.getMgeologd());			
			returnBean.setMusrcode(String.valueOf(bean.getMcenterid()));
			returnBean.setMusrname(bean.getMcentername());
			returnBean.setMreportinguser(bean.getMmeetinglocn());
		}


		private void setBean(CurrentLocationMasterEntity bean, SecondaryUserMasterEntity profileImageBean,
				CurrentLocationHolderBean returnBean) {
			// TODO Auto-generated method stub

			
			returnBean.setMcreatedby(bean.getMcreatedby());
			returnBean.setMlastupdatedt(bean.getMlastupdatedt());
			returnBean.setMlastupdateby(bean.getMlastupdateby());
			returnBean.setMgeolocation(bean.getMgeolocation());
			returnBean.setMgeolatd(bean.getMgeolatd());
			returnBean.setMgeologd(bean.getMgeologd());			
			returnBean.setMusrcode(bean.getMusrcode());
			returnBean.setMusrname(bean.getMusrname());
			returnBean.setMreportinguser(bean.getMreportinguser());			
			returnBean.setProfileimage(profileImageBean.getProfileimage());
			
			
		}
		
		

}
