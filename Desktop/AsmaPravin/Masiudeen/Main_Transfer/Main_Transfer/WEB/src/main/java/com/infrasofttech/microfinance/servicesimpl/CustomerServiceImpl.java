package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
/*import java.util.HashSet;*/
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.ContactPointVerificationEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerAddressDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerAssetDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerHouseholdExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPPIDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPaymentMethodDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerDedupHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.StatusHistoryHolder;
import com.infrasofttech.microfinance.repository.ContactPointVerificationRepository;
import com.infrasofttech.microfinance.repository.CustomerAddressDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerAssetDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerBorrowingDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerBusinessDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerBusinessExpenseRepository;
import com.infrasofttech.microfinance.repository.CustomerFamilyDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerHouseholdExpenseRepository;
import com.infrasofttech.microfinance.repository.CustomerPPIDetailsRepository;
import com.infrasofttech.microfinance.repository.CustomerPaymentMethodRepository;
import com.infrasofttech.microfinance.repository.CustomerRepository;
import com.infrasofttech.microfinance.repository.ImageMasterRepository;
import com.infrasofttech.microfinance.repository.SystemParameterRepository;
import com.infrasofttech.microfinance.services.CustomerService;





@Service
@Transactional
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	CustomerRepository customerRepository;
	@Autowired
	CustomerFamilyDetailsRepository customerFamilyDetailsRepository;
	@Autowired
	CustomerAddressDetailsRepository customerAddressDetailsRepository;
	@Autowired
	CustomerBorrowingDetailsRepository customerBorrowingDetailsRepository;
	@Autowired
	CustomerPPIDetailsRepository customerPPIDetailsRepository;
	@Autowired
	ImageMasterRepository imageMasterRepository;
	@Autowired
	CustomerBusinessExpenseRepository customerBusinessExpenseRepository;
	@Autowired
	CustomerHouseholdExpenseRepository customerHouseholdExpenseRepository;
	@Autowired
	CustomerAssetDetailsRepository customerAssetDetailsRepository;
	@Autowired
	CustomerBusinessDetailsRepository customerBusinessDetailsRepository;
	@Autowired
	CustomerPaymentMethodRepository	customerPaymentMethodRepository;
	@Autowired
	ContactPointVerificationRepository contactPointVerificationRepository;
	@Autowired
	SystemParameterRepository systemParameterRepo;

	@Transactional
	@Override
	public ResponseEntity<List<CustomerEntity>> addCustomerListByHolder(List<CustomerHolderBean> customerList) {
		try { 		
			CustomerEntity entityBean = new CustomerEntity();			
			List<CustomerFamilyDetailsEntity> addFamilyDetailsEntityList;
			List<CustomerBorrowingDetailsEntity> addborrowingDetailsList ;
			List<CustomerAddressDetailsEntity> addressDetailsList;
			List<CustomerPaymentMethodDetailsEntity> addPaymentDetailsDetailsList;
			List<ImageMasterEntity> addImageMasterList;
			List<CustomerPPIDetailsEntity> addCustomerPPIDetailsEntityList; 
			CustomerBusinessDetailsEntity customerBusinessDetailsEntity;
			List<CustomerBusinessExpenseEntity> addBnExpenseDetailsEntityList;
			List<CustomerHouseholdExpenseEntity> addHhExpenseDetailsEntityList;
			List<CustomerAssetDetailsEntity> addAssetDetailsEntityList;
			ContactPointVerificationEntity contactPointVerification;





			//List<CustomerHolderBean> customerReturnList = new ArrayList<CustomerHolderBean>();
			List<CustomerEntity> tempCustomerReturnList = new ArrayList<CustomerEntity>();
			List<CustomerEntity> customerReturnList = new ArrayList<CustomerEntity>();
			if(null != customerList) {
				for(CustomerHolderBean bean :customerList) {

					entityBean = new CustomerEntity();
					addFamilyDetailsEntityList=new ArrayList<CustomerFamilyDetailsEntity>();
					addborrowingDetailsList=new ArrayList<CustomerBorrowingDetailsEntity>();
					addressDetailsList=new ArrayList<CustomerAddressDetailsEntity>();
					addPaymentDetailsDetailsList=new ArrayList<CustomerPaymentMethodDetailsEntity>();
					addImageMasterList=new ArrayList<ImageMasterEntity>();
					addCustomerPPIDetailsEntityList=new ArrayList<CustomerPPIDetailsEntity>();
					customerBusinessDetailsEntity= bean.getCustomerBussDetails();
					addBnExpenseDetailsEntityList= new ArrayList<CustomerBusinessExpenseEntity>();
					addHhExpenseDetailsEntityList= new ArrayList<CustomerHouseholdExpenseEntity>();
					addAssetDetailsEntityList= new ArrayList<CustomerAssetDetailsEntity>();
					contactPointVerification= bean.getContactPointVerificationEntity();

					if(bean.getMrefno()>0) {
						entityBean.setMrefno(bean.getMrefno());
						
						if(bean.getMcustno()==0) {
							System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"+bean.getMrefno());
							CustomerEntity custEntity = customerRepository.findByMrefNo(bean.getMrefno());
							if(custEntity!=null) {
							
							System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"+custEntity.getMcustno());
							entityBean.setMcustno(custEntity.getMcustno());
							}
						}else {
							entityBean.setMcustno(bean.getMcustno());
						}
						customerBusinessDetailsRepository.deleteExistingRecords(bean.getMrefno());
						customerFamilyDetailsRepository.deleteExistingRecords(bean.getMrefno());
						customerAddressDetailsRepository.deleteExistingRecords(bean.getMrefno());
						customerBorrowingDetailsRepository.deleteExistingRecords(bean.getMrefno());
						customerBusinessExpenseRepository.deleteExistingRecords(bean.getMrefno());
						customerHouseholdExpenseRepository.deleteExistingRecords(bean.getMrefno());
						customerAssetDetailsRepository.deleteExistingRecords(bean.getMrefno());
						customerPPIDetailsRepository.deleteExistingRecords(bean.getMrefno());
						imageMasterRepository.deleteExistingRecords(bean.getMrefno());
						customerPaymentMethodRepository.deleteExistingRecords(bean.getMrefno());
						/*customerPPIDetailsRepository.deleteExistingRecords(bean.getMrefno());
						customerFamilyDetailsRepository.deleteExistingRecords(bean.getMrefno());*/
						contactPointVerificationRepository.deleteExistingRecords(bean.getMrefno());
					}

					entityBean.setMlastupdatedt(bean.getMlastupdatedt()); 
					entityBean.setTrefno(bean.getTrefno());
					//entityBean.setMrefno(bean.getMrefno());
					//entityBean.setMcustno(bean.getMcustno());
					entityBean.setMlbrcode(bean.getMlbrcode());
					entityBean.setMcenterid(bean.getMcenterid());
					entityBean.setMgroupcd(bean.getMgroupcd());
					entityBean.setMnametitle(bean.getMnametitle());
					entityBean.setMlongname(bean.getMlongname());
					entityBean.setMfathertitle(bean.getMfathertitle());
					entityBean.setMfathername(bean.getMfathername());
					entityBean.setMspousetitle(bean.getMspousetitle());
					entityBean.setMhusbandname(bean.getMhusbandname());
					entityBean.setMdob(bean.getMdob());
					entityBean.setMage(bean.getMage());
					entityBean.setMbankacno(bean.getMbankacno());
					//entityBean.setMbankacyn(bean.getMbankacyn());
					entityBean.setMbankifsc(bean.getMbankifsc());
					entityBean.setMbanknamelk(bean.getMbanknamelk());
					entityBean.setMbankbranch(bean.getMbankbranch());
					entityBean.setMcuststatus(bean.getMcuststatus());
					entityBean.setMdropoutdate(bean.getMdropoutdate());
					entityBean.setMmobno(bean.getMmobno());
					entityBean.setMpanno(bean.getMpanno());
					entityBean.setMpannodesc(bean.getMpannodesc());
					entityBean.setMtdsyn(bean.getMtdsyn());
					entityBean.setMtdsreasoncd(bean.getMtdsreasoncd());
					entityBean.setMtdsfrm15subdt(bean.getMtdsfrm15subdt());
					entityBean.setMemailid(bean.getMemailid());
					entityBean.setMcustcategory(bean.getMcustcategory());
					entityBean.setMtier(bean.getMtier());
					entityBean.setMadd1(bean.getMadd1());
					entityBean.setMadd2(bean.getMadd2());
					entityBean.setMadd3(bean.getMadd3());
					entityBean.setMarea(bean.getMarea());
					entityBean.setMpincode(bean.getMpincode());
					entityBean.setMcouncd(bean.getMcouncd());
					entityBean.setMcitycd(bean.getMcitycd());
					entityBean.setMfname(bean.getMfname());
					entityBean.setMmname(bean.getMmname());
					entityBean.setMlname(bean.getMlname());
					entityBean.setMgender(bean.getMgender());
					entityBean.setMrelegion(bean.getMrelegion());
					entityBean.setMruralurban(bean.getMruralurban());
					entityBean.setMcaste(bean.getMcaste());
					entityBean.setMqualification(bean.getMqualification());
					entityBean.setMoccupation(bean.getMoccupation());
					entityBean.setMlandtype(bean.getMlandtype());
					entityBean.setMlandmeasurement(bean.getMlandmeasurement());
					entityBean.setMmaritialstatus(bean.getMmaritialstatus());
					entityBean.setMtypeofid(bean.getMtypeofid());
					entityBean.setMiddesc(bean.getMiddesc());
					//entityBean.setMloanagreed(bean.getMloanagreed());
					//entityBean.setMinsurancecovyn(bean.getMinsurancecovyn());
					entityBean.setMtypeofcoverage(bean.getMtypeofcoverage());
					entityBean.setMcreateddt(bean.getMcreateddt());
					entityBean.setMcreatedby(bean.getMcreatedby());
					entityBean.setMlastupdatedt(bean.getMlastupdatedt());		
					entityBean.setMlastupdateby(bean.getMlastupdateby());		
					entityBean.setMgeolocation(bean.getMgeolocation());	
					entityBean.setMgeolatd(bean.getMgeolatd());	
					entityBean.setMgeologd(bean.getMgeologd());	
					entityBean.setMissynctocoresys(bean.getMissynctocoresys());
					entityBean.setMlastsynsdate(bean.getMlastsynsdate());
					entityBean.setMexpsramt(bean.getMexpsramt());
					entityBean.setMcbcheckrprtdt(bean.getMcbcheckrprtdt());
					entityBean.setMiscbcheckdone(bean.getMiscbcheckdone());
					entityBean.setMprofileind(bean.getMprofileind());
					entityBean.setMhusdob(bean.getMhusdob());
					entityBean.setMhusage(bean.getMhusage());
					entityBean.setMcrs(bean.getMcrs());
					entityBean.setMotpvrfdno(bean.getMotpvrfdno());
					entityBean.setMlangofcust(bean.getMlangofcust());
					entityBean.setMmainoccupn(bean.getMmainoccupn());
					entityBean.setMsuboccupn(bean.getMsuboccupn());
					entityBean.setMsecoccupatn(bean.getMsecoccupatn());
					
					entityBean.setMcusttype(bean.getMcusttype());
					
					entityBean.setMid1expdate(bean.getMid1expdate());
					entityBean.setMid1issuedate(bean.getMid1issuedate());
					entityBean.setMid2expdate(bean.getMid2expdate());
					entityBean.setMid2issuedate(bean.getMid2expdate());
					entityBean.setMdropoutreason(bean.getMdropoutreason());
					entityBean.setMmobilelastsynsdate(bean.getMmobilelastsynsdate());
					entityBean.setMretry(0);
					entityBean.setMutils(bean.getMutils());
					//added after radio button manupulation					
					entityBean.setMloanagreed(setRadioManupulationYN(bean.getMloanagreed()));
					entityBean.setMinsurancecovyn((setRadioManupulationYN(bean.getMinsurancecovyn())));
					//entityBean.setMgender(setGenderRadioManupulation(bean.getMgender()));
					//entityBean.setMruralurban(setRurIntRadioManupulation(bean.getMruralurban()));
					entityBean.setMbankacyn(setRadioManupulationYN(bean.getMbankacyn()));					
					//ends here 

					entityBean.setMmemberno(bean.getMmemberno());
					entityBean.setDesignation(bean.getDesignation());
					entityBean.setOrgname(bean.getOrgname());
					entityBean.setYearsinorg(bean.getYearsinorg());
		
					
					
					for(CustomerFamilyDetailsEntity famEntityBean :  bean.getFamilyDetails()) {
						System.out.println("");
						famEntityBean.setFamilyDetailsCustomerEntity(entityBean);
						addFamilyDetailsEntityList.add(famEntityBean);						
					}
					entityBean.setFamilyDetails(addFamilyDetailsEntityList);


					for(CustomerBorrowingDetailsEntity borrEntityBean :  bean.getBorrowingDetails()) {
						borrEntityBean.setBorrowingDetailsCustomerEntity(entityBean);
						addborrowingDetailsList.add(borrEntityBean);						
					}
					entityBean.setBorrowingDetails(addborrowingDetailsList);

					for(CustomerAddressDetailsEntity addEntityBean :  bean.getAddressDetails()) {
						addEntityBean.setAddressDetailsCustomerEntity(entityBean);
						addEntityBean.setMtoietyn(setToiletRadioManupulation(addEntityBean.getMtoietyn()));

						addressDetailsList.add(addEntityBean);						
					}
					entityBean.setAddressDetails(addressDetailsList);


					for(CustomerPaymentMethodDetailsEntity paymentMethodDetailsEntityBean :  bean.getPaymentDetailsDetails()) {
						paymentMethodDetailsEntityBean.setPaymetMethodDetailsCustomerEntity(entityBean);
						addPaymentDetailsDetailsList.add(paymentMethodDetailsEntityBean);						
					}
					entityBean.setPaymentDetailsDetails(addPaymentDetailsDetailsList);

					for(ImageMasterEntity imageMasterEntityBean :  bean.getImageMaster()) {
						imageMasterEntityBean.setImageMasterEntity(entityBean);
						addImageMasterList.add(imageMasterEntityBean);						
					}
					entityBean.setImageMaster(addImageMasterList);

 


					for(CustomerPPIDetailsEntity addCustomerPPIDetailsEntityBean :  bean.getCustomerPPIDetailsEntity()) {
						addCustomerPPIDetailsEntityBean.setPpiDetailsCustomerEntity(entityBean);
						addCustomerPPIDetailsEntityList.add(addCustomerPPIDetailsEntityBean);						
					}
					entityBean.setCustomerPPIDetailsEntity(addCustomerPPIDetailsEntityList);

					customerBusinessDetailsEntity.setCustomerBussDetailsCustomerEntity(entityBean);

					//added after radio button manipulation
					customerBusinessDetailsEntity.setMbusnhousesameplaceyn(setRadioManupulationYN(bean.getCustomerBussDetails().getMbusnhousesameplaceyn()));
					customerBusinessDetailsEntity.setMregisteredyn(setRadioManupulationYN(bean.getCustomerBussDetails().getMregisteredyn()));
					customerBusinessDetailsEntity.setMbusinesstrend(setRadioManupulation(bean.getCustomerBussDetails().getMbusinesstrend()));
					customerBusinessDetailsEntity.setMbusseasonalityjan(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalityjan()));
					customerBusinessDetailsEntity.setMbusseasonalityfeb(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalityfeb()));
					customerBusinessDetailsEntity.setMbusseasonalitymar(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalitymar()));
					customerBusinessDetailsEntity.setMbusseasonalityapr(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalityapr()));
					customerBusinessDetailsEntity.setMbusseasonalitymay(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalitymay()));
					customerBusinessDetailsEntity.setMbusseasonalityjun(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalityjun()));
					customerBusinessDetailsEntity.setMbusseasonalityjul(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalityjul()));
					customerBusinessDetailsEntity.setMbusseasonalityaug(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalityaug()));
					customerBusinessDetailsEntity.setMbusseasonalitysep(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalitysep()));
					customerBusinessDetailsEntity.setMbusseasonalityoct(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalityoct()));
					customerBusinessDetailsEntity.setMbusseasonalitynov(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalitynov()));
					customerBusinessDetailsEntity.setMbusseasonalitydec(setBussRadioManupulation(bean.getCustomerBussDetails().getMbusseasonalitydec()));
					
					//ends here

					entityBean.setCustomerBussDetails(customerBusinessDetailsEntity);

					//business and household expense
					for(CustomerBusinessExpenseEntity bnExpEntityBean :  bean.getCustomerBusinessExpenseEntity()) {
						bnExpEntityBean.setBusinessExpenseCustomerEntity(entityBean);
						addBnExpenseDetailsEntityList.add(bnExpEntityBean);						
					}
					entityBean.setCustomerBusinessExpenseEntity(addBnExpenseDetailsEntityList);

					for(CustomerHouseholdExpenseEntity bnExpEntityBean :  bean.getCustomerHouseholdExpenseEntity()) {
						bnExpEntityBean.setHouseholdExpenseCustomerEntity(entityBean);
						addHhExpenseDetailsEntityList.add(bnExpEntityBean);						
					}
					entityBean.setCustomerHouseholdExpenseEntity(addHhExpenseDetailsEntityList);

					//asset detail
					for(CustomerAssetDetailsEntity assetEntityBean :  bean.getCustomerAssetDetailsEntity()) {
						assetEntityBean.setAssetCustomerEntity(entityBean);
						addAssetDetailsEntityList.add(assetEntityBean);						
					}
					entityBean.setCustomerAssetDetailsEntity(addAssetDetailsEntityList);

					
					
					contactPointVerification.setContactPointVerificationEntity(entityBean);
					entityBean.setContactPointVerification(contactPointVerification);

					

					tempCustomerReturnList.add(customerRepository.save(entityBean));
					

				

				}
				//TODO CHanage below for loop as this is creating problrm and add single sync here itself
				
				for(CustomerEntity customerEntity :tempCustomerReturnList) {
					getWholeEntity(customerEntity);
					customerReturnList.add(customerEntity);
				}
				
			}
			return new ResponseEntity<List<CustomerEntity>>(customerReturnList,new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}



	private void setCustomerRadioToMiddleware(CustomerEntity entityBean, CustomerHolderBean bean) {


		//entityBean.getCustomerBussDetails().setMins(setRadioManupulation(bean.getCustomerBussDetails().getMbusinesstrend()));

	}

	private String setRadioManupulation(String radioString) {
		// TODO Auto-generated method stub
		if("1".equalsIgnoreCase(radioString)) {
			return "2";
		}else {
			return "1";
		}	
	}
	private String setToiletRadioManupulation(String radioString) {
		// TODO Auto-generated method stub
		if("1".equalsIgnoreCase(radioString)) {
			return "2";
		}else {
			return "1";
		}	
	}
	private String setRadioManupulationYN(String radioString) {
		// TODO Auto-generated method stub
		if("1".equalsIgnoreCase(radioString)) {
			return "N";
		}else {
			return "Y";
		}	
	}
//	private String setGenderRadioManupulation(String radioString) {
//		// TODO Auto-generated method stub
//		if("0".equalsIgnoreCase(radioString)) {
//			return "M";
//		}else{
//			return "F";
//		}	
//	}
	private String setBussRadioManupulation(String radioString) {
		// TODO Auto-generated method stub
		if("2".equalsIgnoreCase(radioString)) {
			return "L";
		}else if("1".equalsIgnoreCase(radioString)) {
			return "M";
		}else{
			return "H";
		}	
	}
	
	//TODO (this is not a object refrence, in java we use .equals for comparing string not refrence)
	private int setRurIntRadioManupulation(int str) {
		if(0==str) {
			return 1;
		}else {
			return 2;
		}	
	}


	@Transactional
	@Override
	public ResponseEntity<?> addList(List<CustomerEntity> customer) {
		try {	 

			return new ResponseEntity<Object>(customerRepository.saveAll(customer),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> getAllCustomerData() {
		try {
			List<CustomerEntity> customerList=customerRepository.findAll();
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	/*	@Transactional
	@Override
	public ResponseEntity<?> getDataCustomerByCustomerNo(Long custNo) {
		try {
			CustomerEntity customer=customerRepository.findByCustomerNumberOfTab(custNo);
			if(customer.equals(null)) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<CustomerEntity>(customer,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}*/

	@Transactional
	@Override
	public List<CustomerEntity> isDataSynced(int isDataSynced) {
		List<CustomerEntity> customerList = null;
		List<CustomerEntity> retEntity = null;
		try {
			//System.out.println(isDataSyncedToCoreSystem);
			customerList=new ArrayList<CustomerEntity>();
			customerList = customerRepository.findDataByisDataSyncedNativeQuery(isDataSynced);
			retEntity = new ArrayList<CustomerEntity>() ;
			//List<CustomerAddressDetailsEntity> responses=null ;
			for (CustomerEntity customerListEntity : customerList) {
				//CustomerEntity custEntity = new CustomerEntity();
//			    for(CustomerAddressDetailsEntity add :customerListEntity.getAddressDetails()) {
//			    	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"+add.getMaddressrefno());
//			    }
				
				
				if(customerListEntity != null)
				{
					
					
					List<CustomerAddressDetailsEntity> custTempEnt = customerAddressDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setAddressDetails(custTempEnt);
					System.out.println("Added address list");
					
					CustomerBusinessDetailsEntity custBusTempEnt = (CustomerBusinessDetailsEntity)
							customerBusinessDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerBussDetails(custBusTempEnt);
					System.out.println("Added business  list");
					List<CustomerFamilyDetailsEntity> custFamTempEnt = customerFamilyDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setFamilyDetails(custFamTempEnt);
					System.out.println("Added family list");
					List<CustomerBorrowingDetailsEntity> custBorTempEnt = customerBorrowingDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setBorrowingDetails(custBorTempEnt);
					System.out.println("Added borrowing list");
					List<CustomerPPIDetailsEntity> custPPITempEnt = customerPPIDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerPPIDetailsEntity(custPPITempEnt);
					System.out.println("Added ppi list");
					//List<CustomerBusinessExpenseEntity> custBExpTempEnt = customerBusinessExpenseRepository.findByMrefno(customerListEntity.getMrefno());
					
					//customerListEntity.setCustomerBusinessExpenseEntity(custBExpTempEnt);
					System.out.println("Added business list");
					List<CustomerHouseholdExpenseEntity> custHhTempEnt = customerHouseholdExpenseRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerHouseholdExpenseEntity(custHhTempEnt);
					System.out.println("Added added household list");
					List<CustomerAssetDetailsEntity> custAstTempEnt = customerAssetDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerAssetDetailsEntity(custAstTempEnt);
					System.out.println("Added asset list");
					
					System.out.println("adding Image Entity");
					
					
					
					  List<ImageMasterEntity> custImgTempEnt =
					  imageMasterRepository.findByMrefno(customerListEntity.getMrefno());
					  
					  customerListEntity.setImageMaster(custImgTempEnt);
					  System.out.println("Added Image Entity"); 
					  
					  List<CustomerBusinessExpenseEntity> custBusinessExpnsEntity =
							  customerBusinessExpenseRepository.findByMrefno(customerListEntity.getMrefno());
							  
					  customerListEntity.setCustomerBusinessExpenseEntity(custBusinessExpnsEntity);
					  
					  System.out.println("Added Business expense entity");
					  ContactPointVerificationEntity custCpvTempEnt = (ContactPointVerificationEntity)
							  contactPointVerificationRepository.findByMrefno(customerListEntity.getMrefno());
					  customerListEntity.setContactPointVerification(custCpvTempEnt);
				    
				}
				retEntity.add(customerListEntity);
			}
			
			
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return retEntity;
	}

	/*	@Transactional
	@Override
	public int updateCustomer(long customerNumberOfTab,String customerNumberOfCore,String agentUsrCode) {
		int isCustomerUpdated = 0 ;
		try {
			System.out.println("customer numbetr to split "+customerNumberOfCore);
			String p = customerNumberOfCore.substring(customerNumberOfCore.indexOf("$")+1,customerNumberOfCore.length()-1);
			System.out.println("ppppppppppppp"+p);
			String[] customerNumebrSplit = customerNumberOfCore.split("\\^\\|\\$");
			System.out.println("CUsto Spli0"+customerNumebrSplit[0]);
			System.out.println("CUsto Spli1"+customerNumebrSplit[1]);
			System.out.println("ppppppppppppp"+p);

			isCustomerUpdated = customerRepository.updateCustomer(customerNumberOfTab,customerNumebrSplit[1],agentUsrCode);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustomerUpdated;
		}
		return isCustomerUpdated;
	}*/

	@Transactional
	@Override
	public int updateCustomer(int mCustRefNo,int customerNumberOfCore,LocalDateTime updatedDateTime,int mcuststatus) {
		int isCustomerUpdated = 0 ;
		try {

			isCustomerUpdated = customerRepository.updateCustomer(mCustRefNo,customerNumberOfCore,updatedDateTime,mcuststatus);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustomerUpdated;
		}
		return isCustomerUpdated;
	}

	@Transactional
	@Override
	public int updateErrorfromOmni(int mCustRefNo,String errorFromOmni) {
		int isCustomerUpdated = 0 ;
		try {
			LocalDateTime updatedDt = LocalDateTime.now();
			isCustomerUpdated = customerRepository.updateErrorFromOmni(mCustRefNo,errorFromOmni,updatedDt);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustomerUpdated;
		}
		return isCustomerUpdated;
	}

	@Transactional
	@Override
	public int updateErrorWithRetryFromOmni(int mCustRefNo,String errorFromOmni,int retry,int misSysncToCoreSys) {
		int isCustomerUpdated = 0 ;
		try {
			LocalDateTime updatedDt = LocalDateTime.now();
			isCustomerUpdated = customerRepository.updateErrorWithRetryFromOmni(mCustRefNo,errorFromOmni,updatedDt,retry,misSysncToCoreSys);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustomerUpdated;
		}
		return isCustomerUpdated;
	}
	
	

	@Transactional(readOnly=true)
	@Override
	public CustomerEntity getDataCustomerByCustomerNo(int custno) {
		try {
			List<CustomerEntity> customerList = new ArrayList<CustomerEntity>();
			System.out.println("trying to find customer ");
			CustomerEntity customerEntity = customerRepository.findByMcustNo(custno);
			System.out.println("Customer Found for ");
			System.out.println(custno );
			
			customerList.add(customerEntity);
			
			
			manipulateCustomerEntity(customerList);


			if(customerList.isEmpty()) {
				System.out.println("customer List is empty");
				return null;
				
			}
				
						return customerList.get(0);
		}catch(Exception e) {
			System.out.println("No Record Found. wasasas : "+e.getStackTrace());
			//logger.error("No Record Found."+e.getMessage());
			return null;		}
	}

	@Transactional(readOnly=true)
	@Override
	public ResponseEntity<?> findByCreatedByAndLastSyncedTime(CustomerEntity customerEntity) {		
		try {
			List<CustomerEntity> customerList;
			customerList = new ArrayList<CustomerEntity>();
			if(customerEntity.getMlastsynsdate()==null ) {
			
				customerList = customerRepository.findByCreatedby(customerEntity.getMcreatedby());
			}else {
				customerList=customerRepository.findByCreatedbyAndDateTime(customerEntity.getMcreatedby(), customerEntity.getMlastsynsdate());
			}
			
			List<CustomerEntity> retEntity = new ArrayList<CustomerEntity>() ;
			//List<CustomerAddressDetailsEntity> responses=null ;
			for (CustomerEntity customerListEntity : customerList) {
				//CustomerEntity custEntity = new CustomerEntity();
//			    for(CustomerAddressDetailsEntity add :customerListEntity.getAddressDetails()) {
//			    	System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"+add.getMaddressrefno());
//			    }
				
				
				if(customerListEntity != null)
				{
					
					
					List<CustomerAddressDetailsEntity> custTempEnt = customerAddressDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setAddressDetails(custTempEnt);
					System.out.println("Added address list");
					
					CustomerBusinessDetailsEntity custBusTempEnt = (CustomerBusinessDetailsEntity)
							customerBusinessDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerBussDetails(custBusTempEnt);
					System.out.println("Added business  list");
					List<CustomerFamilyDetailsEntity> custFamTempEnt = customerFamilyDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setFamilyDetails(custFamTempEnt);
					System.out.println("Added family list");
					List<CustomerBorrowingDetailsEntity> custBorTempEnt = customerBorrowingDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setBorrowingDetails(custBorTempEnt);
					System.out.println("Added borrowing list");
					List<CustomerPPIDetailsEntity> custPPITempEnt = customerPPIDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerPPIDetailsEntity(custPPITempEnt);
					System.out.println("Added ppi list");
					//List<CustomerBusinessExpenseEntity> custBExpTempEnt = customerBusinessExpenseRepository.findByMrefno(customerListEntity.getMrefno());
					
					//customerListEntity.setCustomerBusinessExpenseEntity(custBExpTempEnt);
					System.out.println("Added business list");
					List<CustomerHouseholdExpenseEntity> custHhTempEnt = customerHouseholdExpenseRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerHouseholdExpenseEntity(custHhTempEnt);
					System.out.println("Added added household list");
					List<CustomerAssetDetailsEntity> custAstTempEnt = customerAssetDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerAssetDetailsEntity(custAstTempEnt);
					System.out.println("Added asset list");
					
					System.out.println("adding Image Entity");
					
					
					
					  List<ImageMasterEntity> custImgTempEnt =
					  imageMasterRepository.findByMrefno(customerListEntity.getMrefno());
					  
					  customerListEntity.setImageMaster(custImgTempEnt);
					  System.out.println("Added Image Entity"); 
					  
					  List<CustomerBusinessExpenseEntity> custBusinessExpnsEntity =
							  customerBusinessExpenseRepository.findByMrefno(customerListEntity.getMrefno());
							  
					  customerListEntity.setCustomerBusinessExpenseEntity(custBusinessExpnsEntity);
					  
					  System.out.println("Added Business expense entity");
					  ContactPointVerificationEntity custCpvTempEnt = (ContactPointVerificationEntity)
							  contactPointVerificationRepository.findByMrefno(customerListEntity.getMrefno());
					  customerListEntity.setContactPointVerification(custCpvTempEnt);
				    
				}
				retEntity.add(customerListEntity);
			}
				
			
			
			
		
			manipulateCustomerEntity(retEntity);			
	
			if(retEntity.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerEntity>>(retEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			System.out.println("No Record Found. wasasas : "+e.getStackTrace());
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	private void manipulateCustomerEntity(List<CustomerEntity> customerList) {
		// TODO Auto-generated method stub
		for(int custList =0;custList<customerList.size();custList++) {
			
			if(customerList.get(custList).getMlongname()!=null) {
				
				String str = customerList.get(custList).getMlongname();
				String[] splitStr= str.split(" ");
				if(splitStr!=null) {
				if(splitStr.length>0) {
				customerList.get(custList).setMfname(splitStr[0]);
				}
				if(splitStr.length>1) {
				customerList.get(custList).setMmname(splitStr[1]);
				}
				if(splitStr.length>2) {
		        customerList.get(custList).setMlname(splitStr[2]);
				}
				}
			}
			
			if(customerList.get(custList).getMloanagreed()!=null) {
			customerList.get(custList).setMloanagreed(getRadioManupulation(customerList.get(custList).getMloanagreed()));
			}else {
				customerList.get(custList).setMloanagreed("1");
			}
			if(customerList.get(custList).getMinsurancecovyn()!=null) {
			customerList.get(custList).setMinsurancecovyn((getRadioManupulation(customerList.get(custList).getMinsurancecovyn())));
			}else {
				customerList.get(custList).setMinsurancecovyn("1");
			}
//			if(customerList.get(custList).getMgender()!=null) {
//			customerList.get(custList).setMgender(getGenderRadioManupulation(customerList.get(custList).getMgender()));
//			}else {
//				customerList.get(custList).setMgender("1");
//			}
			//int type
			//customerList.get(custList).setMruralurban(getRurIntRadioManupulation(customerList.get(custList).getMruralurban()));
			
			if(customerList.get(custList).getMbankacyn()!=null) {
			customerList.get(custList).setMbankacyn(getRadioManupulation(customerList.get(custList).getMbankacyn()));
			}else {
				customerList.get(custList).setMbankacyn("1");
			}
			
			if(customerList.get(custList).getCustomerBussDetails()!=null) {
			if(customerList.get(custList).getCustomerBussDetails().getMbusnhousesameplaceyn()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusnhousesameplaceyn(getRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusnhousesameplaceyn()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusnhousesameplaceyn("1");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMregisteredyn()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMregisteredyn(getRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMregisteredyn()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMregisteredyn("1");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusinesstrend()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusinesstrend(getRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusinesstrend()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusinesstrend("1");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityjan()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalityjan(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityjan()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalityjan("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityfeb()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalityfeb(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityfeb()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalityfeb("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalitymar()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalitymar(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalitymar()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalitymar("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityapr()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalityapr(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityapr()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalityapr("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalitymay()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalitymay(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalitymay()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalitymay("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityjun()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalityjun(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityjun()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalityjun("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityjul()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalityjul(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityjul()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalityjul("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityaug()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalityaug(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityaug()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalityaug("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalitysep()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalitysep(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalitysep()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalitysep("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityoct()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalityoct(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalityoct()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalityoct("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalitynov()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalitynov(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalitynov()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalitynov("0");
				}
			
			if(customerList.get(custList).getCustomerBussDetails().getMbusseasonalitydec()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusseasonalitydec(getBussRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusseasonalitydec()));
				}else {
					customerList.get(custList).getCustomerBussDetails().setMbusseasonalitydec("0");
				}
			
		}
			/*if(customerList.get(custList).getCustomerBussDetails()!=null && customerList.get(custList).getCustomerBussDetails().getMbusnhousesameplaceyn()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusnhousesameplaceyn(getRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusnhousesameplaceyn()));
			}else {
				customerList.get(custList).getCustomerBussDetails().setMbusnhousesameplaceyn("");
			}
			
			if(customerList.get(custList).getCustomerBussDetails()!=null && customerList.get(custList).getCustomerBussDetails().getMregisteredyn()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMregisteredyn(getRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMregisteredyn()));
			}else {
				customerList.get(custList).getCustomerBussDetails().setMregisteredyn("1");
			}
			if(customerList.get(custList).getCustomerBussDetails()!=null && customerList.get(custList).getCustomerBussDetails().getMbusinesstrend()!=null) {
				customerList.get(custList).getCustomerBussDetails().setMbusinesstrend(getRadioManupulation(customerList.get(custList).getCustomerBussDetails().getMbusinesstrend()));
			}else {
				customerList.get(custList).getCustomerBussDetails().setMbusinesstrend("1");
			}	*/		
			
			for(int addBean=0;addBean<customerList.get(custList).getAddressDetails().size();addBean++) {
				if(customerList.get(custList).getAddressDetails()!=null && customerList.get(custList).getAddressDetails().get(addBean).getMtoietyn()!=null) {
					//customerList.get(custList).getAddressDetails().get(addBean).setMtoietyn(getRadioManupulation(customerList.get(custList).getAddressDetails().get(addBean).getMtoietyn()));
					
					customerList.get(custList).getAddressDetails().get(addBean).setMtoietyn(getRadioManupulation(customerList.get(custList).getAddressDetails().get(addBean).getMtoietyn()));
					
				}else {
					customerList.get(custList).getAddressDetails().get(addBean).setMtoietyn("1");
					//customerList.get(custList).getCustomerBussDetails().setMbusinesstrend("1");
				}
				
			}


		}

	}


	/*
	 * mIsMbrGrp
CustomerFormationMasterTabsState.fdb.mmemberno = selection.toString(); 	
CustomerFormationMasterTabsState.custListBean.mConstruct = selection;
CustomerFormationMasterTabsState.custListBean.mToilet = selection;	 
	 */

	private String getRadioManupulation(String str) {
		if("N".equalsIgnoreCase(str)) {
			return "0";
		}else {
			return "1";
		}	
	}
	
	private String getBussRadioManupulation(String str) {
		if("L".equalsIgnoreCase(str)) {
			return "2";
		}else if("M".equalsIgnoreCase(str)) {
			return "1";
		}else {
			return "0";
		}	
	}

	private int getRurIntRadioManupulation(int str) {
		if(1==str) {
			return 0;
		}else {
			return 1;
		}	
	}
	private int getIntRadioManupulation(String str) {
		if(("N".equalsIgnoreCase(str))) {
			return 1;
		}else {
			return 2;
		}	
	}
//	private String getGenderRadioManupulation(String radioString) {
//		// TODO Auto-generated method stub
//		if("M".equalsIgnoreCase(radioString)) {
//			return "0";
//		}else{
//			return "1";
//		}	
//	}

	@Transactional(readOnly=true)
	@Override
	public CustomerEntity findByTrefAndMcreatedByAndIsSynced(int trefNo, String mCreatedBy, int mrefno,
			int isSynced) {
		CustomerEntity customer = new CustomerEntity();
		try {


			customer = customerRepository.findByMrefNo(mrefno);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return customer;
	}



	@Transactional(readOnly=true)
	@Override
	public ResponseEntity<?> getCustomerById(String mpanNoDesc, String midDesc) {
		try {
			List<CustomerEntity> customerList=customerRepository.findByID(mpanNoDesc, midDesc);
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	}



//	@Transactional(readOnly=true)
//	@Override 
//	public ResponseEntity<?> findByCenterId(CustomerEntity customerEntity) {
//		
//		
//		try {
//			List<CustomerEntity> customerList;
//		
//				customerList=customerRepository.findByCenterId(customerEntity.getMcenterid());
//		
//			manipulateCustomerEntity(customerList);
//
//
//			if(customerList.isEmpty()) 
//				return ResponseEntity.notFound().build();
//			return new ResponseEntity<List<CustomerEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
//		}catch(Exception e) {
//			System.out.println("No Record Found. wasasas : "+e.getStackTrace());
//			//logger.error("No Record Found."+e.getMessage());
//			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}
//
//	}
	
	@Transactional(readOnly=true)
	@Override 
	public ResponseEntity<?> findByCenterId(CustomerEntity customerEntity) {
		
		
		try {
			List<CustomerEntity> customerList;
			
		
			System.out.println("finding by centerid");
				customerList=customerRepository.findByCenterId(customerEntity.getMcenterid());
				System.out.println("added to customerlist");
				List<CustomerEntity> retEntity = new ArrayList<CustomerEntity>() ;
				for (CustomerEntity customerListEntity : customerList) {
					
				if(customerListEntity != null)
				{
					List<CustomerAddressDetailsEntity> custTempEnt = customerAddressDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setAddressDetails(custTempEnt);
					System.out.println("Added address list");
					
					CustomerBusinessDetailsEntity custBusTempEnt = 
							(CustomerBusinessDetailsEntity) customerBusinessDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerBussDetails(custBusTempEnt);
					System.out.println("Added business  list");
					List<CustomerFamilyDetailsEntity> custFamTempEnt = customerFamilyDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setFamilyDetails(custFamTempEnt);
					System.out.println("Added family list");
					List<CustomerBorrowingDetailsEntity> custBorTempEnt = 
							customerBorrowingDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setBorrowingDetails(custBorTempEnt);
					System.out.println("Added borrowing list");
					List<CustomerPPIDetailsEntity> custPPITempEnt = customerPPIDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerPPIDetailsEntity(custPPITempEnt);
					System.out.println("Added ppi list");
					//List<CustomerBusinessExpenseEntity> custBExpTempEnt = customerBusinessExpenseRepository.findByMrefno(customerListEntity.getMrefno());
					
					//customerListEntity.setCustomerBusinessExpenseEntity(custBExpTempEnt);
					System.out.println("Added business list");
					List<CustomerHouseholdExpenseEntity> custHhTempEnt = customerHouseholdExpenseRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerHouseholdExpenseEntity(custHhTempEnt);
					System.out.println("Added added household list");
					List<CustomerAssetDetailsEntity> custAstTempEnt = customerAssetDetailsRepository.findByMrefno(customerListEntity.getMrefno());
					
					customerListEntity.setCustomerAssetDetailsEntity(custAstTempEnt);
					System.out.println("Added asset list");
					
					System.out.println("adding Image Entity");
					
					
					
					  List<ImageMasterEntity> custImgTempEnt =
					  imageMasterRepository.findByMrefno(customerListEntity.getMrefno());
					  
					  customerListEntity.setImageMaster(custImgTempEnt);
					  System.out.println("Added Image Entity"); 
					  
					  List<CustomerBusinessExpenseEntity> custBusinessExpnsEntity =
							  customerBusinessExpenseRepository.findByMrefno(customerListEntity.getMrefno());
							  
					  customerListEntity.setCustomerBusinessExpenseEntity(custBusinessExpnsEntity);
					  
					  System.out.println("Added Business expense entity");
					  ContactPointVerificationEntity custCpvTempEnt = (ContactPointVerificationEntity)
							  contactPointVerificationRepository.findByMrefno(customerListEntity.getMrefno());
					  customerListEntity.setContactPointVerification(custCpvTempEnt);
					    
				}
				
				System.out.println("trying to return");
				retEntity.add(customerListEntity);
				System.out.println("added to return");
		}
		
				System.out.println("Trying to manipulate");
			manipulateCustomerEntity(retEntity);
			System.out.println("ManipulateCompleted");

			if(retEntity.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CustomerEntity>>(retEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			System.out.println("No Record Found. wasasas : "+e.getStackTrace());
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}




	@Override
	@Transactional(readOnly=true)
	public CustomerEntity getDataByMrefNo(int mrefNo) {
		try {
			List<CustomerEntity> customerList = new ArrayList<CustomerEntity>();
			System.out.println("trying to find customer ");
			CustomerEntity customerEntity = customerRepository.findByMrefNo(mrefNo);
			System.out.println("Customer Found for ");
			
			if(customerEntity != null)
			{
				List<CustomerAddressDetailsEntity> custTempEnt = customerAddressDetailsRepository.findByMrefno(customerEntity.getMrefno());
				
				customerEntity.setAddressDetails(custTempEnt);
				
				CustomerBusinessDetailsEntity custBusTempEnt = 
						(CustomerBusinessDetailsEntity) customerBusinessDetailsRepository.findByMrefno(customerEntity.getMrefno());
				
				customerEntity.setCustomerBussDetails(custBusTempEnt);
				
				List<CustomerFamilyDetailsEntity> custFamTempEnt = customerFamilyDetailsRepository.findByMrefno(customerEntity.getMrefno());
				
				customerEntity.setFamilyDetails(custFamTempEnt);
				
				List<CustomerBorrowingDetailsEntity> custBorTempEnt = customerBorrowingDetailsRepository.findByMrefno(customerEntity.getMrefno());
				
				customerEntity.setBorrowingDetails(custBorTempEnt);
				
				List<CustomerPPIDetailsEntity> custPPITempEnt = customerPPIDetailsRepository.findByMrefno(customerEntity.getMrefno());
				
				customerEntity.setCustomerPPIDetailsEntity(custPPITempEnt);
				
				List<CustomerBusinessExpenseEntity> custBExpTempEnt = customerBusinessExpenseRepository.findByMrefno(customerEntity.getMrefno());
				
				customerEntity.setCustomerBusinessExpenseEntity(custBExpTempEnt);
				
				List<CustomerHouseholdExpenseEntity> custHhTempEnt = customerHouseholdExpenseRepository.findByMrefno(customerEntity.getMrefno());
				
				customerEntity.setCustomerHouseholdExpenseEntity(custHhTempEnt);
				
				List<CustomerAssetDetailsEntity> custAstTempEnt = customerAssetDetailsRepository.findByMrefno(customerEntity.getMrefno());
				customerEntity.setCustomerAssetDetailsEntity(custAstTempEnt);
				List<ImageMasterEntity> custImgTempEnt = imageMasterRepository.findByMrefno(customerEntity.getMrefno());
				
				customerEntity.setImageMaster(custImgTempEnt);
				
				List<CustomerBusinessExpenseEntity> custBusinessExpenseTempEnt = customerBusinessExpenseRepository.
						findByMrefno(customerEntity.getMrefno());
				
				customerEntity.setCustomerBusinessExpenseEntity(custBusinessExpenseTempEnt);
				 ContactPointVerificationEntity custCpvTempEnt = (ContactPointVerificationEntity)
						  contactPointVerificationRepository.findByMrefno(customerEntity.getMrefno());
				 customerEntity.setContactPointVerification(custCpvTempEnt);
			    
			}
			
			customerList.add(customerEntity);
			manipulateCustomerEntity(customerList);


			if(customerList.isEmpty()) {
				System.out.println("customer List is empty");
				return null;
				
			}
				
			return customerList.get(0);
		}catch(Exception e) {
			System.out.println("No Record Found. wasasas : "+e.getStackTrace());
			//logger.error("No Record Found."+e.getMessage());
			return null;		}

	}

	@Override
	@Transactional(readOnly=true)
	public void getWholeEntity(CustomerEntity entity) {
		
		List<CustomerAddressDetailsEntity> custTempEnt = customerAddressDetailsRepository.findByMrefno(entity.getMrefno());
		
		entity.setAddressDetails(custTempEnt);
		System.out.println("Added address list");
		
//		CustomerBusinessDetailsEntity custBusTempEnt = (CustomerBusinessDetailsEntity) customerBusinessDetailsRepository.findByMrefno(entity.getMrefno());
//		
		CustomerBusinessDetailsEntity custBusTempEnt = (CustomerBusinessDetailsEntity)
				customerBusinessDetailsRepository.findByMrefno(entity.getMrefno());
		
		entity.setCustomerBussDetails(custBusTempEnt);
		System.out.println("Added business  list");
		List<CustomerFamilyDetailsEntity> custFamTempEnt = customerFamilyDetailsRepository.findByMrefno(entity.getMrefno());
		
		entity.setFamilyDetails(custFamTempEnt);
		System.out.println("Added family list");
		List<CustomerBorrowingDetailsEntity> custBorTempEnt = customerBorrowingDetailsRepository.findByMrefno(entity.getMrefno());
		
		entity.setBorrowingDetails(custBorTempEnt);
		System.out.println("Added borrowing list");
		List<CustomerPPIDetailsEntity> custPPITempEnt = customerPPIDetailsRepository.findByMrefno(entity.getMrefno());
		
		entity.setCustomerPPIDetailsEntity(custPPITempEnt);
		System.out.println("Added ppi list");
		//List<CustomerBusinessExpenseEntity> custBExpTempEnt = customerBusinessExpenseRepository.findByMrefno(entity.getMrefno());
		
		//entity.setCustomerBusinessExpenseEntity(custBExpTempEnt);
		System.out.println("Added business list");
		List<CustomerHouseholdExpenseEntity> custHhTempEnt = customerHouseholdExpenseRepository.findByMrefno(entity.getMrefno());
		
		entity.setCustomerHouseholdExpenseEntity(custHhTempEnt);
		System.out.println("Added added household list");
		List<CustomerAssetDetailsEntity> custAstTempEnt = customerAssetDetailsRepository.findByMrefno(entity.getMrefno());
		
		entity.setCustomerAssetDetailsEntity(custAstTempEnt);
		System.out.println("Added asset list");
		
		System.out.println("adding Image Entity");
		
		  List<ImageMasterEntity> custImgTempEnt =
		  imageMasterRepository.findByMrefno(entity.getMrefno());
		entity.setImageMaster(custImgTempEnt);
		  System.out.println("Added Image Entity"); 
		  List<CustomerBusinessExpenseEntity> custBusinessExpnsEntity =
				  customerBusinessExpenseRepository.findByMrefno(entity.getMrefno());
		  entity.setCustomerBusinessExpenseEntity(custBusinessExpnsEntity);
		  System.out.println("Added Business expense entity");
		  ContactPointVerificationEntity custCpvTempEnt = (ContactPointVerificationEntity)
				  contactPointVerificationRepository.findByMrefno(entity.getMrefno());
		  entity.setContactPointVerification(custCpvTempEnt);
		
		  
		
	}
	
	@Transactional
	@Override
	public int updateGroupInCustomerDetails(int mrefno,int groupNumberOfCore,LocalDateTime updatedDateTime) {
		int isGroupUpdated = 0 ;
		try {

			isGroupUpdated = customerRepository.updateGroupInCustomerDetails(mrefno,groupNumberOfCore,updatedDateTime);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isGroupUpdated;
		}
		return isGroupUpdated;
	}
	
	
	@Transactional
	@Override
	public int updateCenterInCustomerDetails(int mrefno,int centerNumberOfCore,LocalDateTime updatedDateTime) {
		int isCenterUpdated = 0 ;
		try {

			isCenterUpdated = customerRepository.updateCenterInCustomerDetails(mrefno,centerNumberOfCore,updatedDateTime);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCenterUpdated;
		}
		return isCenterUpdated;
	}
	
	
	
	
	@Transactional(readOnly=true)
	@Override
	public ResponseEntity<?> getFingerPrintByCustNo(int custNo) {
		try {
			List<ImageMasterEntity> fingerPrintList = imageMasterRepository.getByFingerPrint(custNo);
			if(fingerPrintList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<ImageMasterEntity>>(fingerPrintList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	}
	
	
	
	
	@Transactional
	@Override
	public int getCustomeNumberBymref(int mrefno) {
		try {
			CustomerEntity customerEntity=customerRepository.findByMrefNo(mrefno);
			if(customerEntity==null) 
				return 0;
			return customerEntity.getMcustno();
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return 0;
		}
	}
	
	
		@Transactional(readOnly=true)
	@Override
	public ResponseEntity<CustomerEntity> getCustomerDedup(CustomerDedupHolder customerDedupHolder){
		try {
			
			int isFullerton =0;
			SystemParameterEntity systemParameterEntity = null;
			try {
				systemParameterEntity = systemParameterRepo.findByCode("ISFULLERTON");
				isFullerton = Integer.parseInt(systemParameterEntity.getMcodevalue().trim());
			}catch(Exception e) {
				
			}
			CustomerEntity customerEntity=null;
			if(isFullerton==1) {
			 customerEntity = customerRepository.findByMnationalId(customerDedupHolder.getMdob(),customerDedupHolder.getMnationalid().substring(customerDedupHolder.getMnationalid().length() - 6));
			}else {
				customerEntity = customerRepository.findByOnlyMnationalId(customerDedupHolder.getMnationalid());
			}
			if(customerEntity!=null) {
				return new ResponseEntity<CustomerEntity>(customerEntity,new HttpHeaders(),HttpStatus.OK);
			}
		
		}catch(Exception e) {

		}
		return null;	

	}



	@Transactional
	@Override
	public int updateCustStatusInCustomerDetails(int custno,int custStatus) {
		int isCustStatusUpdated = 0 ;
		try {

			isCustStatusUpdated = customerRepository.updateCustStatusInCustomerDetails(custno,custStatus);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isCustStatusUpdated;
		}
		return isCustStatusUpdated;
	}
	
	
		@Transactional
		//	@Override
		public ResponseEntity<?> updateStatusFromCore(StatusHistoryHolder statusHistoryHolder) {	
			StatusHistoryHolder retBean =new StatusHistoryHolder();
			LocalDateTime dateTime = LocalDateTime.now();
			try {	
				if(statusHistoryHolder==null ||  statusHistoryHolder.getMcustno()==0) {
					retBean.setMresponsestatuscd(99);	
					retBean.setMresponsestatusmessage("No Specific Recored Found For Provided Customer Id ");				
					return new ResponseEntity<StatusHistoryHolder>(retBean,new HttpHeaders(),HttpStatus.OK);
				}else {
					int customerList=customerRepository.updateStatusFromCore(statusHistoryHolder.getMcustno(),dateTime,statusHistoryHolder.getMauthcd());
					retBean.setMcustno(statusHistoryHolder.getMcustno());
					retBean.setMauthcd(statusHistoryHolder.getMauthcd());
					retBean.setMresponsestatusmessage(statusHistoryHolder.getMresponsestatusmessage());
					
					if(customerList >0) {		
						retBean.setMresponsestatuscd(200);	
						retBean.setMresponsestatusmessage("Sucesfully Record Updated In Middleware");
						return new ResponseEntity<StatusHistoryHolder>(retBean,new HttpHeaders(),HttpStatus.OK);
					}else {
						retBean.setMresponsestatuscd(99);	
						retBean.setMresponsestatusmessage("No Specific Recored Found For Provided Customer Id ");				
						return new ResponseEntity<StatusHistoryHolder>(retBean,new HttpHeaders(),HttpStatus.OK);

					}	
				}
				

			}catch(Exception e) {
				//logger.error("No Record Found."+e.getMessage());
				retBean.setMresponsestatuscd(999);	
				retBean.setMresponsestatusmessage("SomeThing Went Worng On Middleware side");	
				return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
			}


		}
	
	
}