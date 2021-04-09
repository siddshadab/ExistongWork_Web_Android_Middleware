package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursmentListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.DisbursmentHolderBean;
import com.infrasofttech.microfinance.repository.DisbursmentListRepository;
import com.infrasofttech.microfinance.repository.SavingsListRepository;
import com.infrasofttech.microfinance.services.DisbursmentListServices;
import com.infrasofttech.microfinance.services.SavingsListServices;

@Service
@Transactional
public class DisbursementListServicesImpl implements DisbursmentListServices {

	@Autowired
	DisbursmentListRepository dsbrsrepo;
	
	@Autowired 
	DisbursedListServiceImpl disbursedRepo;

	@Transactional
	@Override
	public ResponseEntity<?> addList(List<DisbursmentListEntity> dsbrs) {

		System.out.println("dsbrs::::::::::::::::::::::::::"+dsbrs.toString());
		for(DisbursmentListEntity obj : dsbrs){
			System.out.println("dsbrs::::::::::::::::::::::::::"+obj.getMrefno());
			System.out.println("dsbrs::::::::::::::::::::::::::"+obj.getTrefno());
			}
		

			return new ResponseEntity<Object>(dsbrsrepo.saveAll(dsbrs), new HttpHeaders(), HttpStatus.CREATED);
	

	}



	
	  @Transactional
	  @Override 
	  public ResponseEntity<?> findByCreatedByAndLastSyncedTime(DisbursmentListEntity disbursmentListEntity)
	  { 
		  
		//List<DisbursmentHolderBean> disHolderList = new ArrayList<DisbursmentHolderBean>();
		  //try {
			  System.out.println("Service impl k andar");
	  List<DisbursmentListEntity> disbursmentList;
	  if(disbursmentListEntity.getMlastsynsdate()==null ) {
		  disbursmentList =dsbrsrepo.findByCreatedby(disbursmentListEntity.getMcreatedby()); 
		  }
	  else {
		  disbursmentList=dsbrsrepo.findByCreatedbyAndDateTime(disbursmentListEntity.getMcreatedby(), disbursmentListEntity.getMlastsynsdate()); }
	  //manipulateSavingsEntity(savingsList);
	  
	  
	  /*for(DisbursmentListEntity disbEntity : disbursmentList) {
		  
		  DisbursmentHolderBean disbHolderEntity = new DisbursmentHolderBean();
		  

		  disbHolderEntity.setTrefno(disbEntity.getTrefno());

		  disbHolderEntity.setMrefno(disbEntity.getMrefno());   

		  disbHolderEntity.setMcustno(disbEntity.getMcustno());

		  disbHolderEntity.setMlbrcode(disbEntity.getMlbrcode());
			 
		  disbHolderEntity.setMprdacctid(disbEntity.getMprdacctid());
			 
		  disbHolderEntity.setMlongname(disbEntity.getMlongname());
			
		  disbHolderEntity.setMgroupcd(disbEntity.getMgroupcd());
			 
		  disbHolderEntity.setMefffromdate(disbEntity.getMefffromdate()); 
			 
		  disbHolderEntity.setMdisburseddate(disbEntity.getMdisburseddate());
			 
		  disbHolderEntity.setMinstlstartdate(disbEntity.getMinstlstartdate());
			 
		  disbHolderEntity.setMinstlamt(disbEntity.getMinstlamt());
			 
		  disbHolderEntity.setMinstlintcomp(disbEntity.getMinstlintcomp());
			 
		  disbHolderEntity.setMleadsid(disbEntity.getMleadsid());
			 
		  disbHolderEntity.setMappliedasindvyn(disbEntity.getMappliedasindvyn());
			 
		  disbHolderEntity.setMnewtopupflag(disbEntity.getMnewtopupflag());
			 
		  disbHolderEntity.setMsancdate(disbEntity.getMsancdate());
			 
		  disbHolderEntity.setMdisbursedamt(disbEntity.getMdisbursedamt());
			 
		  disbHolderEntity.setMsdamt(disbEntity.getMsdamt());
			 
		  disbHolderEntity.setMrebateamt(disbEntity.getMrebateamt());
			 
		  disbHolderEntity.setMchargesamt(disbEntity.getMchargesamt());
			 
		  disbHolderEntity.setMdisbursedamtcoltd(disbEntity.getMdisbursedamtcoltd());
			 
		  disbHolderEntity.setMsdamtcoltd(disbEntity.getMsdamtcoltd());
			 
		  disbHolderEntity.setMrebateamtcoltd(disbEntity.getMrebateamtcoltd()); 
			 
		  disbHolderEntity.setMchargesamtcoltd(disbEntity.getMchargesamtcoltd());
			 
		  disbHolderEntity.setMdisbursedamtflag(disbEntity.getMdisbursedamtflag());
			 
		  disbHolderEntity.setMsdamtflag(disbEntity.getMsdamtflag());
			 
		  disbHolderEntity.setMrebateamtflag(disbEntity.getMrebateamtflag());
			 
		  disbHolderEntity.setMchargesamtflag(disbEntity.getMchargesamtflag());
			  
		  disbHolderEntity.setMsetno(disbEntity.getMsetno());
			 
		  disbHolderEntity.setMscrollno(disbEntity.getMscrollno());
			 
		  disbHolderEntity.setMentrydate(disbEntity.getMentrydate());
			 
		  disbHolderEntity.setMbatchcd(disbEntity.getMbatchcd());
			 
		  disbHolderEntity.setMmainscrollno(disbEntity.getMmainscrollno());
			 
		  disbHolderEntity.setMbatchnumber(disbEntity.getMbatchnumber());
			 
		  disbHolderEntity.setMnarration(disbEntity.getMnarration()); 

		  disbHolderEntity.setMcenterid(disbEntity.getMcenterid()); 

		  disbHolderEntity.setMcrs(disbEntity.getMcrs());

		  disbHolderEntity.setMsuspbatchcd(disbEntity.getMsuspbatchcd());

		  disbHolderEntity.setMsuspsetno(disbEntity.getMsuspsetno());

		  disbHolderEntity.setMsuspscrollno(disbEntity.getMsuspscrollno());

		  disbHolderEntity.setMsspmainscrollno(disbEntity.getMsspmainscrollno());
		  disbHolderEntity.setMpartcashamount(disbEntity.getMpartcashamount()); 

		  disbHolderEntity.setMpartcashbatchcd(disbEntity.getMpartcashbatchcd()); 

		  disbHolderEntity.setMpartcashsetno(disbEntity.getMpartcashsetno()); 

		  disbHolderEntity.setMpartcashscrollno(disbEntity.getMpartcashscrollno());
		  disbHolderEntity.setMpartcashmainscrollno(disbEntity.getMpartcashmainscrollno());

		  disbHolderEntity.setMneftclsrbatchcd(disbEntity.getMneftclsrbatchcd()); 

		  disbHolderEntity.setMneftclsrsetno(disbEntity.getMneftclsrsetno());

		  disbHolderEntity.setMneftclsrscrollno(disbEntity.getMneftclsrscrollno());

		  disbHolderEntity.setMneftclsrmainscrollno(disbEntity.getMneftclsrmainscrollno()); 

		  disbHolderEntity.setMcreateddt(disbEntity.getMcreateddt()); 

		  disbHolderEntity.setMcreatedby(disbEntity.getMcreatedby());

		  disbHolderEntity.setMlastupdatedt(disbEntity.getMlastupdatedt());

		  disbHolderEntity.setMlastupdateby(disbEntity.getMlastupdateby()); 

		  disbHolderEntity.setMgeolocation(disbEntity.getMgeolocation()); 

		  disbHolderEntity.setMgeolatd(disbEntity.getMgeolatd());

			 disbHolderEntity.setMgeologd(disbEntity.getMgeologd());

			 disbHolderEntity.setMlastsynsdate(disbEntity.getMlastsynsdate());

			 disbHolderEntity.setMerrormessage(disbEntity.getMerrormessage());

			 disbHolderEntity.setMdisbamount(disbEntity.getMdisbamount()); 

			 disbHolderEntity.setMchargesamt0(disbEntity.getMchargesamt0()); 

			 disbHolderEntity.setMchargesamt1(disbEntity.getMchargesamt1()); 

			 disbHolderEntity.setMchargesamt2(disbEntity.getMchargesamt2());

			 disbHolderEntity.setMchargesamt3(disbEntity.getMchargesamt3());

			 disbHolderEntity.setMchargesamt4(disbEntity.getMchargesamt4());
			 disbHolderEntity.setMchargesamt5(disbEntity.getMchargesamt5());
			 disbHolderEntity.setMchargesamt6(disbEntity.getMchargesamt6());
			 disbHolderEntity.setMchargesamt7(disbEntity.getMchargesamt7());
			 disbHolderEntity.setMchargesamt8(disbEntity.getMchargesamt8());
			 disbHolderEntity.setMchargesamt9(disbEntity.getMchargesamt9());
			 disbHolderEntity.setDisbursedBean(disbursedRepo.finfByMleadsid(disbEntity.getMleadsid()));
		  
		  
		  
		  
	  }*/
	  
	  if(disbursmentList.isEmpty())
	return ResponseEntity.notFound().build(); 
	  return  new ResponseEntity<List<DisbursmentListEntity>>(disbursmentList,new HttpHeaders(),HttpStatus.OK); 
	  
		/*  }
		  
		  catch(Exception e) {
	 
		  return new  ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY) ;}
	  */
	  }
		
	 

}
