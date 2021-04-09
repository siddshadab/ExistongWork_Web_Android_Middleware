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

import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.CGT2Entity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.GRTEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CutomerLoanTillGrtHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.OmniLoginService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.repository.CGT1Repository;
import com.infrasofttech.microfinance.repository.CGT2Repository;
import com.infrasofttech.microfinance.repository.CustomerLoanRepository;
import com.infrasofttech.microfinance.repository.GRTRepository;
import com.infrasofttech.microfinance.repository.UserMasterDetailsRepository;
import com.infrasofttech.microfinance.schedular.ScheduledServicesToCoreSystem;
import com.infrasofttech.microfinance.services.CustomerLoanService;

@Service
@Transactional
public class CustomerLoanServiceImpl implements CustomerLoanService {


	@Autowired
	CustomerLoanRepository loanRepository;

	@Autowired
	UserMasterDetailsRepository userRepository;

	@Autowired
	CGT1Repository cGT1Repository;

	@Autowired
	CGT2Repository cGT2Repository;

	@Autowired
	GRTRepository grtRepository;


	@Autowired
	CustomerServiceImpl customerServiceImpl;
 
	@Autowired
	ScheduledServicesToCoreSystem scheduleServices;
	
	@Autowired
	OmniLoginService omniLoginService;




	@Transactional
	@Override
	public ResponseEntity<?> getAllCustomerLoanData() {
		try {
			List<CustomerLoanEntity> customerLoanList=loanRepository.findAll();
			if(customerLoanList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerLoanEntity>>(customerLoanList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> getDataCustomerByLoanNo(Long loanNo) {
		return null;

	}

	@Override
	public List<CustomerLoanEntity> isDataSynced(int isDataSynced) {
		List<CustomerLoanEntity> customerLoan = new ArrayList<CustomerLoanEntity>() ;
		try {

			System.out.println(isDataSynced);
			customerLoan=new ArrayList<CustomerLoanEntity>();
			customerLoan = loanRepository.findByIsDataSynced(isDataSynced);


		}catch(Exception e) {
			e.printStackTrace();
		}

		return customerLoan ;
	}
	
	
	@Override
	public List<CustomerLoanEntity> getLoanForBasicDetails() {
		List<CustomerLoanEntity> customerLoan = new ArrayList<CustomerLoanEntity>() ;
		try {

			customerLoan=new ArrayList<CustomerLoanEntity>();
			customerLoan = loanRepository.findLoanBasicDetails();


		}catch(Exception e) {
			e.printStackTrace();
		}

		return customerLoan ;
	}
	
	
	@Override
	public List<CustomerLoanEntity> getLoanForFinalApproval() {
		List<CustomerLoanEntity> customerLoan = new ArrayList<CustomerLoanEntity>() ;
		try {

			
			customerLoan=new ArrayList<CustomerLoanEntity>();
			customerLoan = loanRepository.findLoanFinalDetails();


		}catch(Exception e) {
			e.printStackTrace();
		}

		return customerLoan ;
	}
	
	

	@Override
	public int updateCustomerLoan(long loanNumberOfTab, String LoanNumberOfCore) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ResponseEntity<?> addList(List<CustomerLoanEntity> customerLoan) {
		try {
			
			List<CustomerLoanEntity> customerLoanAdd =new ArrayList<CustomerLoanEntity>();
			for(CustomerLoanEntity bean: customerLoan) {

				if(bean.getMleadsid() == null || "".equals(bean.getMleadsid())) {
					System.out.println("getting Loan mrefno"+bean.getMrefno());
					CustomerLoanEntity customerLoanBean = loanRepository.findByMrefNo(bean.getMrefno());
					if(customerLoanBean!=null) {
						bean.setMlastupdatedt(customerLoanBean.getMlastupdatedt()); 
						System.out.println("getting leads is  "+customerLoanBean.getMleadsid());
						bean.setMleadsid(customerLoanBean.getMleadsid());
					}
				}else {
					bean.setMleadsid(bean.getMleadsid());
				}

				customerLoanAdd.add(bean);
			}
			
			return new ResponseEntity<Object>(loanRepository.saveAll(customerLoan),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Override
	public int updateCustomerLoanAccountNumber( int mrefno,String loanAccountNumber) {
		int isCustomerUpdated = 0 ;
		try {
			//System.out.println("Data in loan loanAccountNumber update "+ loanAccountNumber +" loanNumberOfTab "+ loanNumberOfTab +" customerNumberOfTab "+customerNumberOfTab+" usrCode "+usrCode);
			LocalDateTime dateTime = LocalDateTime.now();
			isCustomerUpdated = loanRepository.updateCustomerLoanAccountNumber(mrefno,loanAccountNumber,dateTime);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustomerUpdated;
		}
		return isCustomerUpdated;
	}


	@Override
	public int updateCustomerLoanLeadIdOfCore(String loanLeadId, int mrefno) {
		int isCustomerUpdated = 0 ;
		try {
			LocalDateTime dateTime = LocalDateTime.now();
			isCustomerUpdated = loanRepository.updateCustomerLoanLeadId(mrefno,loanLeadId,dateTime);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustomerUpdated;
		}
		return isCustomerUpdated;
	}

	@Transactional
	@Override
	public ResponseEntity<?>findByCreatedByOrRouteTo(String createdby, String routeto) {
		try {
			List<CustomerLoanEntity> customerList=loanRepository.findByMcreatedbyAndMrouteto(createdby, routeto);
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerLoanEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	@Transactional
	@Override
	public ResponseEntity<?> findByCreatedByOrMrouteToAndLastSyncedTime(CustomerLoanEntity customerLoanEntity) {			
		try { 
			List<CustomerLoanEntity> customerLoanList;
			//List<UserMasterEntity> userList = userRepository.getHerarchy(customerLoanEntity.getMcreatedby());		

			//boolean isNeedWithLastSyncDate=false;
			List<CutomerLoanTillGrtHolder> cutomerLoanTillGrtHolderList; 
			customerLoanList = new ArrayList<CustomerLoanEntity>();


			List<CustomerLoanEntity> customerLoanEntityList =null;
			if(customerLoanEntity.getMlastsynsdate()==null  ) {
				System.out.println("Mlast sysndate is null");
				customerLoanEntityList = loanRepository.findByCreatedby(customerLoanEntity.getMcreatedby());
				
			}else if(customerLoanEntity.getMlastsynsdate()!=null ) {
				
				System.out.println("retutned item is userEntity.getMusrcode() " + customerLoanEntity.getMcreatedby());
				customerLoanEntityList = loanRepository.findByCreatedbyAndDateTime(customerLoanEntity.getMcreatedby(),customerLoanEntity.getMlastsynsdate());
				
				System.out.println(customerLoanEntityList.size());
			}
			if(customerLoanEntityList!=null && !customerLoanEntityList.isEmpty()) {
				customerLoanList.addAll(customerLoanEntityList);
			}


			cutomerLoanTillGrtHolderList = new ArrayList<CutomerLoanTillGrtHolder>();
			for(CustomerLoanEntity cutLoanBean:customerLoanList) {

				
				// Do not add leadstatus  7 and 99 while superuser asking for get sync
				if(/*!(customerLoanEntity.getMcreatedby()!=null &&
						cutLoanBean.getMrouteto() !=null && customerLoanEntity.getMcreatedby().equalsIgnoreCase(
						cutLoanBean.getMrouteto())
						
						) &&*/
						(cutLoanBean.getMleadstatus() !=7 || cutLoanBean.getMleadstatus() != 99)) {


					CutomerLoanTillGrtHolder cutomerLoanTillGrtHolder = new CutomerLoanTillGrtHolder();
					List<CGT1Entity> cgt1Bean =cGT1Repository.findByLoanmrefnoAndLoantrefno(cutLoanBean.getMrefno(), cutLoanBean.getTrefno());
					List<CGT2Entity> cgt2Bean =cGT2Repository.findByLoanmrefnoAndLoantrefno(cutLoanBean.getMrefno(), cutLoanBean.getTrefno());
					List<GRTEntity> grtBean =grtRepository.findByLoanmrefnoAndLoantrefno(cutLoanBean.getMrefno(), cutLoanBean.getTrefno());
					//TODO what if customer no is not generated still
					CustomerEntity custEntity = customerServiceImpl.getDataByMrefNo(cutLoanBean.getMcustmrefno());
					cutomerLoanTillGrtHolder.setCgt1Bean(cgt1Bean);
					cutomerLoanTillGrtHolder.setCgt2Bean(cgt2Bean);
					cutomerLoanTillGrtHolder.setGrtBean(grtBean);
					if(custEntity!=null) {
						cutomerLoanTillGrtHolder.setCustBean(custEntity);	
					}
					else {
						System.out.println("CustomerList is empty");
					}
					System.out.println("done for cust no ");
					System.out.println(cutLoanBean.getMcustno());

					cutomerLoanTillGrtHolder.setTrefno(cutLoanBean.getTrefno());
					cutomerLoanTillGrtHolder.setMrefno(cutLoanBean.getMrefno());	
					cutomerLoanTillGrtHolder.setMleadsid(cutLoanBean.getMleadsid());
					cutomerLoanTillGrtHolder.setMappldloanamt(cutLoanBean.getMappldloanamt());
					cutomerLoanTillGrtHolder.setMapprvdloanamt(cutLoanBean.getMapprvdloanamt());
					cutomerLoanTillGrtHolder.setMcustno(cutLoanBean.getMcustno());
					cutomerLoanTillGrtHolder.setMcusttrefno(cutLoanBean.getMcusttrefno());
					cutomerLoanTillGrtHolder.setMcustmrefno(cutLoanBean.getMcustmrefno());
					cutomerLoanTillGrtHolder.setMloanamtdisbd(cutLoanBean.getMloanamtdisbd());
					cutomerLoanTillGrtHolder.setMloandisbdt(cutLoanBean.getMloandisbdt());
					cutomerLoanTillGrtHolder.setMleadstatus(cutLoanBean.getMleadstatus());
					cutomerLoanTillGrtHolder.setMexpdt(cutLoanBean.getMexpdt());
					cutomerLoanTillGrtHolder.setMinstamt(cutLoanBean.getMinstamt());
					cutomerLoanTillGrtHolder.setMinststrtdt(cutLoanBean.getMinststrtdt());
					cutomerLoanTillGrtHolder.setMinterestamount(cutLoanBean.getMinterestamount());
					cutomerLoanTillGrtHolder.setMrepaymentmode(cutLoanBean.getMrepaymentmode());
					cutomerLoanTillGrtHolder.setMmodeofdisb(cutLoanBean.getMmodeofdisb());
					cutomerLoanTillGrtHolder.setMPeriod(cutLoanBean.getMPeriod());
					cutomerLoanTillGrtHolder.setMprdcd(cutLoanBean.getMprdcd());
					cutomerLoanTillGrtHolder.setMpurposeofloan(cutLoanBean.getMpurposeofloan());
					cutomerLoanTillGrtHolder.setMsubpurposeofloan(cutLoanBean.getMsubpurposeofloan());
					cutomerLoanTillGrtHolder.setMintrate(cutLoanBean.getMintrate());
					cutomerLoanTillGrtHolder.setMroutefrom(cutLoanBean.getMroutefrom());
					cutomerLoanTillGrtHolder.setMrouteto(cutLoanBean.getMrouteto());
					cutomerLoanTillGrtHolder.setMprdacctid(cutLoanBean.getMprdacctid());
					cutomerLoanTillGrtHolder.setMloancycle(cutLoanBean.getMloancycle());
					cutomerLoanTillGrtHolder.setMfrequency(cutLoanBean.getMfrequency());
					cutomerLoanTillGrtHolder.setMapprovaldesc(cutLoanBean.getMapprovaldesc());
					cutomerLoanTillGrtHolder.setMerrormessage(cutLoanBean.getMerrormessage());	
					cutomerLoanTillGrtHolder.setMcreateddt(cutLoanBean.getMcreateddt());
					cutomerLoanTillGrtHolder.setMcreatedby(cutLoanBean.getMcreatedby());
					cutomerLoanTillGrtHolder.setMlastupdatedt(cutLoanBean.getMlastupdatedt());		
					cutomerLoanTillGrtHolder.setMlastupdateby(cutLoanBean.getMlastupdateby());		
					cutomerLoanTillGrtHolder.setMgeolocation(cutLoanBean.getMgeolocation());	
					cutomerLoanTillGrtHolder.setMgeolatd(cutLoanBean.getMgeolatd());	
					cutomerLoanTillGrtHolder.setMgeologd(cutLoanBean.getMgeologd());	
					cutomerLoanTillGrtHolder.setMissynctocoresys(cutLoanBean.getMissynctocoresys());
					cutomerLoanTillGrtHolder.setMlastsynsdate(cutLoanBean.getMlastsynsdate());
					cutomerLoanTillGrtHolder.setMappliedasind(cutLoanBean.getMappliedasind());
					cutomerLoanTillGrtHolder.setMcheckresaddchng(cutLoanBean.getMcheckresaddchng());
					cutomerLoanTillGrtHolder.setMspouserelname(cutLoanBean.getMspouserelname());
					cutomerLoanTillGrtHolder.setMcheckspouserepay(cutLoanBean.getMcheckspouserepay());  
					cutomerLoanTillGrtHolder.setMcheckbiometric(cutLoanBean.getMcheckbiometric()); 
					cutomerLoanTillGrtHolder.setMomnileadstatus(cutLoanBean.getMomnileadstatus()); 
					cutomerLoanTillGrtHolder.setMlbrcode(cutLoanBean.getMlbrcode());
					System.out.println("adding to customer holder bean");
					cutomerLoanTillGrtHolderList.add(cutomerLoanTillGrtHolder);
				}

			}

			System.out.println("trying to return");
			return new ResponseEntity<List<CutomerLoanTillGrtHolder>>(cutomerLoanTillGrtHolderList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}


	}

	@Transactional
	@Override
	public int updateErrorfromOmni(int mCustRefNo,String errorFromOmni) {
		int isCustomerUpdated = 0 ;
		try {
			LocalDateTime updatedDt = LocalDateTime.now();
			isCustomerUpdated = loanRepository.updateErrorFromOmni(mCustRefNo,errorFromOmni,updatedDt);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustomerUpdated;
		}
		return isCustomerUpdated;
	}



	@Transactional
	@Override
	public int updateErrorfromOmni(int mCustRefNo,String errorFromOmni,int mRetry) {
		int isCustomerUpdated = 0 ;
		try {
			LocalDateTime updatedDt = LocalDateTime.now();
			mRetry+=1;
			isCustomerUpdated = loanRepository.updateErrorFromOmni(mCustRefNo,errorFromOmni,updatedDt,mRetry);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustomerUpdated;
		}
		return isCustomerUpdated;
	}


	@Override
	public int updateCustomerLoanLeadIdOfCore(String loanLeadId, int mrefno,int mRetry) {
		int isCustomerUpdated = 0 ;
		try {
			mRetry+=1;
			LocalDateTime dateTime = LocalDateTime.now();
			isCustomerUpdated = loanRepository.updateCustomerLoanLeadId(mrefno,loanLeadId,dateTime,mRetry);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustomerUpdated;
		}
		return isCustomerUpdated;
	}



	//update Customer no in loan details

	@Transactional
	@Override
	public int updateCustomerInLoanDetails(int mrefno,int customerNumberOfCore,LocalDateTime updatedDateTime) {
		int isCustomerUpdated = 0 ;
		try {

			isCustomerUpdated = loanRepository.updateCustomerInLoanDetails(mrefno,customerNumberOfCore,updatedDateTime);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustomerUpdated;
		}
		return isCustomerUpdated;
	}


	public void  synchronizeLoanToOmni(CustomerLoanEntity entity) {
		System.out.println("synchronizeCustomerToOmni");   
		OmniSoapResultBean bean = null;
		if(entity!=null) {    		
			try { 	
				/*if(Constants.Field204 != null && Constants.Field204.equals("") ) {

    				System.out.println("xxxxxxxTring to login");
    				OmniLoginService login = new OmniLoginService();
    				login.loginOmni();
    			}*/
				
				bean = scheduleServices.LoanBasicDetailsRequest(entity);    
				System.out.println("Yhan Vapas Aya" + entity);
				/*if(bean!=null & bean.getStatus() ==0) {
    				entity.setMcustno(bean.getMCustNo());


    				customerService.updateCustomer(bean.getMCustRefNo(), bean.getMCustNo(),LocalDateTime.now())  ;
					loanServiceImpl.updateCustomerInLoanDetails(entity.getMrefno(), bean.getMCustNo(),LocalDateTime.now());
    				} else {
    					entity.setMerrormessage(bean.getError());
    					customerService.updateErrorfromOmni(bean.getMCustRefNo(), bean.getError());
    					System.out.println("Not pdated Some Error recieved");
    				}*/
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			
		}


	}




	public void  synchronizeLoanFinalCallToOmni(CustomerLoanEntity entity) {
		System.out.println("synchronizeCustomerToOmni");   
		OmniSoapResultBean bean = null;
		if(entity!=null) {    		
			try { 	
				if(Constants.Field204 != null && Constants.Field204.equals("") ) {
					OmniLoginService login = new OmniLoginService();
					omniLoginService.loginOmni();
				}
				bean = scheduleServices.loanApprovalDetailsRequest(entity,entity.getMleadsid());    				
				/*if(bean!=null & bean.getStatus() ==0) {
    				entity.setMcustno(bean.getMCustNo());


    				customerService.updateCustomer(bean.getMCustRefNo(), bean.getMCustNo(),LocalDateTime.now())  ;
					loanServiceImpl.updateCustomerInLoanDetails(entity.getMrefno(), bean.getMCustNo(),LocalDateTime.now());
    				} else {
    					entity.setMerrormessage(bean.getError());
    					customerService.updateErrorfromOmni(bean.getMCustRefNo(), bean.getError());
    					System.out.println("Not pdated Some Error recieved");
    				}*/
			}catch(Exception e) {
				e.printStackTrace();
			}


		}


	}

	@Override
	public CustomerLoanEntity getLoanWithMrefNo(int mrefno) {
		CustomerLoanEntity cusLoanEntity;
		try {
			
			cusLoanEntity = loanRepository.findByMrefNo(mrefno);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return null;
		}
		return cusLoanEntity;
	}
	




}
