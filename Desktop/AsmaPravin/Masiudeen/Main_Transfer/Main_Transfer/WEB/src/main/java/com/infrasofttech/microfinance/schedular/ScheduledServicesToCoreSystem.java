package com.infrasofttech.microfinance.schedular;
 
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCPVBusinessRecordEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCashFlowEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectedEntity;
import com.infrasofttech.microfinance.entityBeans.master.DeviationFormEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.GuarantorEntity;
import com.infrasofttech.microfinance.entityBeans.master.KycMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanLevelMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsCollectionListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SocialAndEnvironmentalEntity;
import com.infrasofttech.microfinance.entityBeans.master.TDReceiptsEntity;
import com.infrasofttech.microfinance.entityBeans.master.TradeAndNeighbourRefCheckEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.OmniLoginService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniCenterMasterServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniCustomerLoanBasicDetailsServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniCustomerLoanCPVBusinessRecordServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniCustomerLoanCashFlowServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniCustomerLoanMasterServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniCustomerMasterServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniDailyLoanCollectionServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniDeviationFormServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniDisbursedListAuthorizationServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniDisbursedListServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniGroupMasterServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniGuarantorDetailServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniKycMasterServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniSavingsCollectionListServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniSavingsListServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniSocialAndEnvironmentalServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniTDReceiptsServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniTradeAndNeighbourRefCheckServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.repository.CustomerLoanRepository;
import com.infrasofttech.microfinance.repository.LoanLevelRepository;
import com.infrasofttech.microfinance.servicesimpl.BranchMasterServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CentersFoundationServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerLoanCPVBusinessRecordServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerLoanCashFlowServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerLoanServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.DailyLoanCollectedImpl;
import com.infrasofttech.microfinance.servicesimpl.DeviationFormServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.DisbursedListServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.GroupsFoundationServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.GuarantorServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.KycMasterServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.SavingsCollectionListServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SavingsListServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.SocialAndEnvironmentalServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.TDReceiptsServicesImpl;
import com.infrasofttech.microfinance.servicesimpl.TradeAndNeighbourRefCheckServiceImpl;

@Component
@PropertySource("classpath:ecoMiddlewareConfig.properties")
public class ScheduledServicesToCoreSystem {

	@Autowired
	CustomerServiceImpl customerServiceImpl;
	@Autowired
	SavingsListServicesImpl savingsListServicesImpl;
	@Autowired
	SavingsCollectionListServicesImpl savingsCollectionListServicesImpl;
	@Autowired
	OmniSavingsCollectionListServiceImpl omniSavingsDisplayListServiceImpl;
	@Autowired
	OmniSavingsListServiceImpl omniSavingsListServiceImpl;
	@Autowired
	OmniCustomerMasterServiceImpl omniCustomerMasterServiceImpl;
	@Autowired
	OmniCustomerLoanMasterServiceImpl omniCustomerLoanMasterServiceImpl;
	@Autowired
	CustomerLoanServiceImpl loanServiceImpl;
	@Autowired
	OmniCustomerLoanBasicDetailsServiceImpl OmniCustomerLoanBasicDetailsServiceImpl;
	@Autowired
	OmniDailyLoanCollectionServiceImpl omniDailyLoanCollectionServiceImpl;
	@Autowired
	DailyLoanCollectedImpl dailyLoanCollectedImpl;
	@Autowired
	TDReceiptsServicesImpl tDReceiptsServicesImpl;
	@Autowired
	OmniTDReceiptsServiceImpl omniTDReceiptsServiceImpl;
	@Autowired
	CentersFoundationServiceImpl centersFoundationServicesImpl;
	@Autowired
	OmniCenterMasterServiceImpl omniCenterMasterServiceImpl;
	@Autowired
	OmniLoginService omniLoginService;
	@Autowired
	GroupsFoundationServiceImpl groupFoundationServicesImpl;
	@Autowired
	OmniGroupMasterServiceImpl omniGroupMasterServiceImpl;
	@Autowired
	OmniSocialAndEnvironmentalServiceImpl omniSocialAndEnvironmentalServiceImpl;
	@Autowired
	SocialAndEnvironmentalServiceImpl socialAndEnvironmentalServiceImpl;
	@Autowired
	OmniTradeAndNeighbourRefCheckServiceImpl omniTradeAndNeighbourRefCheckServiceImpl;
	@Autowired
	TradeAndNeighbourRefCheckServiceImpl tradeAndNeighbourRefCheckServiceImpl;
	@Autowired
	OmniDeviationFormServiceImpl omniDeviationFormServiceImpl;
	@Autowired
	DeviationFormServiceImpl deviationFormServiceImpl;
	
	@Autowired
	CustomerLoanCashFlowServiceImpl cashFlowServiceImpl;
	
	@Autowired
	OmniCustomerLoanCashFlowServiceImpl omniCashflowServiceImpl;
	@Autowired
	OmniCustomerLoanCPVBusinessRecordServiceImpl omniCpvBusinessRecordServiceImpl;
	@Autowired
	CustomerLoanCPVBusinessRecordServiceImpl cpvBusinessRecordServiceImpl;
	@Autowired
	OmniGuarantorDetailServiceImpl omniGuarantorDetailServiceImpl;
	@Autowired
	GuarantorServicesImpl guarantorServicesImpl;
	@Autowired
	OmniKycMasterServiceImpl omniKycMasterServiceImpl;
	@Autowired
    KycMasterServiceImpl kycMasterServiceImpl;
	@Autowired
    CustomerLoanRepository customerLoanRepository;
	@Autowired
	BranchMasterServiceImpl branchmasterserviceImpl;
	@Autowired
	DisbursedListServiceImpl disbursedListServiceImpl;
	@Autowired
	OmniDisbursedListServiceImpl omniDisbursedListServiceImpl;
	@Autowired
	OmniDisbursedListAuthorizationServiceImpl omniDisbursedListAuthServiceImpl;
	@Autowired
	LoanLevelRepository loanlevelrepo;
	
	
	
	@Autowired
	private Environment envr;
	private static final Logger log = LoggerFactory.getLogger(ScheduledServicesToCoreSystem.class);

	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

	
	
	@Scheduled(fixedDelay  = 30000)
	public   void tryConsecutiveLoginInOmni() {
		
		String isSceduleReq =envr.getProperty("loginschedule");
		Constants.ENDPOINT = envr.getProperty("ENDPOINT");
		System.out.println("xxxxxxxxxxxxxxxis schedule req "+isSceduleReq);
		System.out.println("session variable final 204 "+ Constants.Field204);
		System.out.println("session variable final 201 "+ Constants.Field1);
		if("1".equals(isSceduleReq)) {
			if(Constants.Field204 != null && Constants.Field204.equals("") ) {
				//OmniLoginService login = new OmniLoginService();
				omniLoginService.loginOmni();
			}	
		}
		
	}
	
	
	
	
	 @Scheduled(fixedDelay = 30000) 
	  public synchronized void mergeCustomerToCoreSystem() {
		 String isSceduleReq =envr.getProperty("customerToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 
			 System.out.println("session variable final 204 "+ Constants.Field204);
			  System.out.println("session variable final 201 "+ Constants.Field1);
			  if(Constants.Field204 != null && !Constants.Field204.equals("") ) {
			  synchronizeCustomerToOmni(); } 
		 }
		 
	 } //
		
	@Scheduled(fixedDelay = 30000)
	public void mergeCustomerLoanBasicsDetailsToCoreSystem() {
		 String isSceduleReq =envr.getProperty("loanBasicDeatilsToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeCustomerLoanToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeCustomerLoanToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {				
					synchronizeLoanBasicsDetailsToOmni();
					//synchronizeFinalLoanApprovalToOmni();
					
				}
			 
		 }
		
	}
	
	
	
/*	@Scheduled(fixedDelay = 30000)
	public void mergeCustomerLoanFinalDetailsToCoreSystem() {
		 String isSceduleReq =envr.getProperty("loanDeatilsToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeCustomerLoanToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeCustomerLoanToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {				
					//synchronizeLoanBasicsDetailsToOmni();
					synchronizeFinalLoanApprovalToOmni();
					
				}
			 
		 }
		
	}*/
	
	@Scheduled(fixedDelay = 30000)
	public void mergeCustomerDailyLoanCollectionToCoreSystem() {
		 String isSceduleReq =envr.getProperty("dailyLoanCollectionSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeCustomerLoanToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeCustomerLoanToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeDailyLoanCollectionToOmni();	
				}	 
		 }
		
	}
	
	@Scheduled(fixedDelay = 30000)
	public void mergeCustomerSavingsAccountCreationToCoreSystem() {
		 String isSceduleReq =envr.getProperty("savingAccountCreationSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeCustomerLoanToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeCustomerLoanToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeSavingsListToOmni();
		    			} 
			 
		 }
		
	}
	
	@Scheduled(fixedDelay = 30000)
	public void mergeCustomerDailySavingsCollectionToCoreSystem() {
		 String isSceduleReq =envr.getProperty("dailySavingsCollectionSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeCustomerLoanToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeCustomerLoanToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {				
		    		synchronizeSavingsCollectionListToOmni();
					
				}	 
			 
		 }
		
	}
	
	@Scheduled(fixedDelay = 30000)
	public void mergeCustomerTDAccountCreationToCoreSystem() {
		 String isSceduleReq =envr.getProperty("tdAccountCreationSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeCustomerLoanToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeCustomerLoanToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
						synchronizeTDReceiptsToOmni();
				}	 
			 
		 }
		
		 
	}
	
	
	@Scheduled(fixedDelay = 30000)
	public void mergeCenterCreationToCoreSystem() {
		 String isSceduleReq =envr.getProperty("centerToOmniSchedule"); 
		 
		 //System.out.println("Synchronizing Center");
		 if("1".equals(isSceduleReq)) {
			 System.out.println("Centyer Sync Required = true");
			 System.out.println("session mergeCenterCreationToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeCenterCreationToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeCenterMasterToOmni();
				}	 
			 
		 }
		
		 
	}
	
	@Scheduled(fixedDelay = 30000)
	public void mergeGroupCreationToCoreSystem() {
		 String isSceduleReq =envr.getProperty("groupToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeGroupCreationToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeGroupCreationToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeGroupMasterToOmni();
				}	 
			 
		 }
		
		 
	}
	
	@Scheduled(fixedDelay = 30000)
	public void mergeSocialAndEnvToCoreSystem() {
		 String isSceduleReq =envr.getProperty("socialAndEnvToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeSocialAndEnvToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeSocialAndEnvToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeSocialAndEnvToOmni();
				}	 
			 
		 }
		
		 
	}
	
	@Scheduled(fixedDelay = 30000)
	public void mergeTradeAndNeighRefToCoreSystem() {
		 String isSceduleReq =envr.getProperty("tradeAndNeighRefToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeTradeAndNeighRefToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeTradeAndNeighRefToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeTradeAndNeighRefToOmni();
				}	 
			 
		 }
		
		 
	}
	
	@Scheduled(fixedDelay = 30000)
	public void mergeDeviationFormToCoreSystem() {
		 String isSceduleReq =envr.getProperty("deviationFormToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeDeviationFormToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeDeviationFormToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeDeviationFormToOmni();
				}	 
			 
		 }
		
		 
	}
	
	
	@Scheduled(fixedDelay = 40000)
	public void mergeCustomerLoanCashFlowToOmni() {
		 String isSceduleReq =envr.getProperty("deviationFormToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeDeviationFormToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeDeviationFormToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeDeviationFormToOmni();
				}	 
			 
		 }
		
		 
	}
	
	@Scheduled(fixedDelay = 30000)
	public void mergeCpvBusinessRecordToOmni() {
		 String isSceduleReq =envr.getProperty("cpvBusinessRecordToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeCpvBusinessRecordToOmni final 204 "+ Constants.Field204);
				System.out.println("session mergeCpvBusinessRecordToOmni final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeCpvBusinessRecordToOmni();
				}	 
			 
		 }
		
		 
	}
	
	@Scheduled(fixedDelay = 120000)
	public void mergeGuarantorToCoreSystem() {
		 String isSceduleReq =envr.getProperty("guatantorToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeGuarantorToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeGuarantorToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeGuarantorToOmni();
				}	 
		 }
	}
	
	
	
	@Scheduled(fixedDelay = 30000)
	public void mergeLoanCashFlowToCoreSystem() {
		 String isSceduleReq =envr.getProperty("customerLoanCashFlow"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeGuarantorToCoreSystem final 204 "+ Constants.Field204);
				System.out.println("session mergeGuarantorToCoreSystem final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {		
					synchronizeCustomerLoanCashFlow();
				}	 
		 }
	}
	
	@Scheduled(fixedDelay = 30000)
	public void mergeKycMasterToOmni() {
		 String isSceduleReq =envr.getProperty("kycMasterToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session mergeKycMasterToOmni final 204xxxxxxxx "+ Constants.Field204);
				System.out.println("session mergeKycMasterToOmni final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {
					System.out.println("if k andr aa hai..");
					synchronizeKycMasterToOmni();
				}
			 
		 }
		
		 
	}
	
	
	
	@Scheduled(fixedDelay = 30000)
	public void mergeDisbursedListToOmni() {
		 String isSceduleReq =envr.getProperty("disbursedListToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session Disbursed List final 204xxxxxxxx "+ Constants.Field204);
				System.out.println("session Disbursed List final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {
					System.out.println("if k andr aa hai..");
					synchronizeDisbursedListToOmni();
				}
			 
		 }
		
		 
	}
	
	
	@Scheduled(fixedDelay = 30000)
	public void mergeDisbursedListAuthToOmni() {
		 String isSceduleReq =envr.getProperty("disbListAuthToOmniSchedule"); 
		 if("1".equals(isSceduleReq)) {
			 System.out.println("session Disbursed List final 204xxxxxxxx "+ Constants.Field204);
				System.out.println("session Disbursed List final 201 "+ Constants.Field1);
				if(Constants.Field204 != null && !Constants.Field204.equals("") ) {
					System.out.println("if k andr aa hai..");
					synchronizeDisbursedListAutorizationToOmni();
				}
			 
		 }
		
		 
	}
	

	
	
	
	
	//Temp Remove this later on just to chek los system
	
	/*
	 * private static void postCallLos(BaseEntity entity) { final String uri =
	 * "http://172.25.2.202:8080/LoanOriginationSystem/rest/ws/generateLead";
	 * 
	 * RestTemplate restTemplate = new RestTemplate(); URI result =
	 * restTemplate.postForLocation(uri, entity);
	 * 
	 * System.out.println(result); }
	 */
	
	
	
	//customer generation in omni
	public void synchronizeCustomerToOmni() {
		System.out.println("synchronizeCustomerToOmni");
		List<CustomerEntity> listEntity = customerServiceImpl.isDataSynced(0);
		if (listEntity != null) {
			int i = 0;
			for (CustomerEntity objEntity : listEntity) {
				i++;
				System.out.println("I ki values = obj " + i);
				System.out.println(objEntity.getMbankacyn() + "account number ");
				// if(objEntity.getMcustno() >0 ) {
				try {
					OmniSoapResultBean bean = omniCustomerMasterServiceImpl.omniSoapServices(objEntity);

					if (bean != null & bean.getStatus() == 0) {
						System.out.println("Receipt Status is "+ bean.getMreceiptstatus());
						customerServiceImpl.updateCustomer(bean.getMCustRefNo(), bean.getMCustNo(), LocalDateTime.now(),bean.getMreceiptstatus());
						loanServiceImpl.updateCustomerInLoanDetails(objEntity.getMrefno(), bean.getMCustNo(),
								LocalDateTime.now());
					savingsListServicesImpl.updateSavingsCustNo(objEntity.getMrefno(), bean.getMCustNo());	
					} else {
						
						if(bean != null &&
								(bean.getError().trim().equals("User Not Found From Web Session")||
								bean.getError().trim().equals("Session Token Not matching with User Web Session Token"))	
								
								) {
							
							objEntity.setMretry(objEntity.getMretry()+1);
							if(objEntity.getMretry()==3) {
								
								customerServiceImpl.updateErrorWithRetryFromOmni(bean.getMCustRefNo(), bean.getError(),objEntity.getMretry(),2);
							}else {
								customerServiceImpl.updateErrorWithRetryFromOmni(bean.getMCustRefNo(), bean.getError(),objEntity.getMretry(),0);	
									
							}
							
						}
						else {
							customerServiceImpl.updateErrorfromOmni(bean.getMCustRefNo(), bean.getError());	
						}
						
						
					}	
				}
				catch(NullPointerException e) { 
					objEntity.setMretry(objEntity.getMretry()+1);
					objEntity.setMerrormessage("System Busy Please try Again");
					
					if(objEntity.getMretry()==3) {
						
						customerServiceImpl.updateErrorWithRetryFromOmni(objEntity.getMrefno(),objEntity.getMerrormessage(),objEntity.getMretry(),2);
					}else {
						customerServiceImpl.updateErrorWithRetryFromOmni(objEntity.getMrefno(),objEntity.getMerrormessage(),objEntity.getMretry(),0);	
							
					}
				}
				catch(Exception  e) {
					customerServiceImpl.updateErrorfromOmni(objEntity.getMrefno(), "Data Not Correct");
				}
				
				
			}
		}

	}

	// prdaccid generated in omni
	public void synchronizeSavingsListToOmni() {
		System.out.println("synchronizeSavingsListToOmni");
		List<SavingsListEntity> savingsListEntity = savingsListServicesImpl.isDataSynced(0);
		if (savingsListEntity != null) {
			System.out.println("savingsListEntity" + savingsListEntity);
			int i = 0;
			for (SavingsListEntity objEntity : savingsListEntity) {
				i++;
				
				if(objEntity.getMcustno()==0) {
					int custno = customerServiceImpl.getCustomeNumberBymref(objEntity.getMcustmrefno());
					System.out.println("Customer Number aaya " + custno + "  " + objEntity.getMcustmrefno());
					if(!(custno==0)) {
						System.out.println("pahle if k andar  " +custno+"  "+objEntity.getMcustmrefno() );
						savingsListServicesImpl.updateSavingsCustNo(objEntity.getMcustmrefno(),custno);
						objEntity.setMcustno(custno);
						try {

							OmniSoapResultBean bean = omniSavingsListServiceImpl.omniSoapServices(objEntity);
							
							
							
							if (bean != null & bean.getStatus() == 0) {
								System.out.println("bean" + bean.getMCustRefNo());
								System.out.println("bean1" + bean.getMCustNo());
								System.out.println("bean2" + bean.getMprdcd());
								// .savingsListServicesImpl.updateSavingsList(bean.getMCustRefNo(),
								// bean.getMCustNo(),bean.getMprdcd()) ;
								savingsListServicesImpl.updateSavingsList(bean.getMCustRefNo(), bean.getMprdacctid(),
										bean.getMcrs());
								savingsCollectionListServicesImpl.updateSavingsCollectionPrdAcctid(bean.getMCustRefNo(), bean.getMprdacctid());

							} else {
								System.out.println("Inside Else");
								System.out.println("xxxxxxxxxxxxxUpdateing Error for "+ bean.getMCustRefNo());
								savingsListServicesImpl.updateSavingsErrorfromOmni(bean.getMCustRefNo(), bean.getError());
								System.out.println("Can not be updated Some Error recieved");
							}
							
							
						}catch(Exception e) {
							
							
							
							objEntity.setMerrormessage("Something went wrong");
							
							System.out.println("Inside Else");
							
							savingsListServicesImpl.updateSavingsErrorfromOmni(objEntity.getMrefno(),objEntity.getMerrormessage());
							System.out.println("Can not be updated Some Error recieved");
							
							
						}
						
					
						
						
						
					}else {
						System.out.println("continue Things for  "+  objEntity.getMcustmrefno());
					
					}
					
				}else {
					try {

						OmniSoapResultBean bean = omniSavingsListServiceImpl.omniSoapServices(objEntity);
						
						System.out.println("Dusre else k andar");
					
						if (bean != null & bean.getStatus() == 0) {
							System.out.println("bean" + bean.getMCustRefNo());
							System.out.println("bean1" + bean.getMCustNo());
							System.out.println("bean2" + bean.getMprdcd());
							// .savingsListServicesImpl.updateSavingsList(bean.getMCustRefNo(),
							// bean.getMCustNo(),bean.getMprdcd()) ;
							savingsListServicesImpl.updateSavingsList(bean.getMCustRefNo(), bean.getMprdacctid(),
									bean.getMcrs());
							savingsCollectionListServicesImpl.updateSavingsCollectionPrdAcctid(bean.getMCustRefNo(), bean.getMprdacctid());

						} else {
							System.out.println("Inside Else");
							System.out.println("xxxxxxxxxxxxxUpdateing Error for "+ bean.getMCustRefNo());
							savingsListServicesImpl.updateSavingsErrorfromOmni(bean.getMCustRefNo(), bean.getError());
							System.out.println("Can not be updated Some Error recieved");
						}
						
					}catch(Exception e) {
						
						objEntity.setMerrormessage("Something went wrong");
						
						System.out.println("Inside Else");
						
						savingsListServicesImpl.updateSavingsErrorfromOmni(objEntity.getMrefno(),objEntity.getMerrormessage());
						System.out.println("Can not be updated Some Error recieved");
						
					}
					
					
					
				}
				
				
				
				
				// if(objEntity!=null&& "".equals(objEntity.getMerrormessage()))

			}
		}

	}

	public void synchronizeSavingsCollectionListToOmni() {
		System.out.println("synchronizeSavingsCollectionListToOmni");
		long start = System.nanoTime();
		System.out.println("Taking time for Update start synchronizeSavingsCollectionListToOmni " + start);
		List<SavingsCollectionListEntity> listEntity = savingsCollectionListServicesImpl.isDataSynced(0, 11, "C");
		List<SavingsCollectionListEntity> savingCollectionList = new ArrayList<SavingsCollectionListEntity>();
		for(SavingsCollectionListEntity savingCollectionObject : listEntity) {
			if(savingCollectionObject.getMprdacctid()==null||savingCollectionObject.getMprdacctid().trim().equals("")
					||savingCollectionObject.getMprdacctid().trim().equals("0")||
					savingCollectionObject.getMprdacctid().trim().equals("null")
					) {
				//    SavingsListEntity savingListEntity = savingsListServicesImpl.getSavAcctFromMrefno(savingCollectionObject.getm, mprdaccid, mcrs);
				//todo      add two fields savingaccountmrefno
				
				SavingsListEntity savListEntity = savingsListServicesImpl.getSavAcctFromMrefno(savingCollectionObject.getMsvngaccmrefno());
				if(savListEntity!=null) {
					
					if(savListEntity.getMprdacctid()==null||savListEntity.getMprdacctid().trim().equals("")
							||savListEntity.getMprdacctid().trim().equals("0")||
							savListEntity.getMprdacctid().trim().equals("null")
							) {
						
					}
					else {
						savingCollectionObject.setMprdacctid(savListEntity.getMprdacctid());
						savingsCollectionListServicesImpl.updateSavingsCollectionPrdAcctid(savingCollectionObject.getMrefno(), savListEntity.getMprdacctid());
						savingCollectionList.add(savingCollectionObject);
					}
					
					
					
				}
			}
			else {
				savingCollectionList.add(savingCollectionObject);
			}
			
			
		}
		
		
		System.out.println("Savings Collection list size " + listEntity.size());
		if (savingCollectionList != null && savingCollectionList.size() > 0) {

			List<SavingsCollectionListEntity> listBean = omniSavingsDisplayListServiceImpl
					.omniSoapServicesSavingsCollectedList(savingCollectionList);
			System.out.println("listBean" + listBean.toString());
			savingsCollectionListServicesImpl.updateStatus(listBean);

			long ends = System.nanoTime();
			System.out.println("Taking time for Update ends synchronizeSavingsCollectionListToOmni " + ends);

			long total = ends - start;

			System.out.println("Taking time for Update total synchronizeSavingsCollectionListToOmni " + total);
		}

		// }
	}

	// loan lead id generation in omni
	public OmniSoapResultBean LoanBasicDetailsRequest(CustomerLoanEntity customerLoanEntity) {
		System.out.println("xxxxx for loan basic details");
		int trefno = customerLoanEntity.getMcusttrefno();
		String mcreatedby = customerLoanEntity.getMcreatedby();
		int mrefno = customerLoanEntity.getMcustmrefno();
		OmniSoapResultBean bean = new OmniSoapResultBean();
		CustomerEntity customer = customerServiceImpl.findByTrefAndMcreatedByAndIsSynced(trefno, mcreatedby, mrefno, 1);
		/*if (customer == null) {
			System.out.println("No for two");
			customer = customerServiceImpl.findByTrefAndMcreatedByAndIsSynced(trefno, mcreatedby, mrefno, 2);
			
		}*/
		BranchMasterEntity branchMasterEntity = null;
		if(customerLoanEntity.getMlbrcode()!=0) {
			
			branchMasterEntity = branchmasterserviceImpl.getBranchMasterEntityDataOnMlbrCd(customerLoanEntity.getMlbrcode());
		}
		
		try {
		if (customer != null && customer.getMcustno() > 0) {
			if (customerLoanEntity.getMcustno() <= 0) {
				customerLoanEntity.setMcustno(customer.getMcustno());
			}
			
			if(branchMasterEntity!=null) {
				bean = OmniCustomerLoanBasicDetailsServiceImpl.omniSoapServiceswithLoanAndCustomer(customer.getMcustno(),
						branchMasterEntity.getMlastopendate(), customerLoanEntity);
			}
			
			else {
				
				bean = OmniCustomerLoanBasicDetailsServiceImpl.omniSoapServiceswithLoanAndCustomer(customer.getMcustno(),
						null, customerLoanEntity);
			}
			
		} else {
			System.out.println("No such customer");
		}

		if (bean != null & bean.getStatus() == 0) {
			loanServiceImpl.updateCustomerLoanLeadIdOfCore(bean.getLoanLeadIdOfCore(), customerLoanEntity.getMrefno());
			customerLoanEntity.setMleadsid(bean.getLoanLeadIdOfCore());
			customerLoanEntity.setMerrormessage("");
			
			List<LoanLevelMasterEntity> loanLevelList=loanlevelrepo.findByPrdCd(customerLoanEntity.getMprdcd());
			System.out.println("Loan List Yhan aaya" + loanLevelList);
			if(loanLevelList!=null&&loanLevelList.size()>0) {
				
				for(LoanLevelMasterEntity loanLevelEntity :loanLevelList) {
					if(loanLevelEntity.getMbuttonid()==8) {
						try {
							cashFlowServiceImpl.updateMleadsIdfromMrefTref(bean.getLoanLeadIdOfCore(),customerLoanEntity.getMrefno(),
									customerLoanEntity.getTrefno());
						}catch(Exception e) {	
							System.out.println("Error in updating LeadId of Cashflow");
						}
						
					}
					else if(loanLevelEntity.getMbuttonid()==5) {
						try {
							kycMasterServiceImpl.updateMleadsIdfromMrefTref(bean.getLoanLeadIdOfCore(),customerLoanEntity.getMrefno(),
									customerLoanEntity.getTrefno());
						}catch(Exception e) {	
							System.out.println("Error in updating LeadId of KYC");
						}
					}
					else if(loanLevelEntity.getMbuttonid()==2) {//Guarantor
						try {
							guarantorServicesImpl.updateMleadsIdfromMrefTref(bean.getLoanLeadIdOfCore(),customerLoanEntity.getMrefno(),
									customerLoanEntity.getTrefno());
						}catch(Exception e) {	
							System.out.println("Error in updating LeadId of Guarantor");
						}					
					}
					else if(loanLevelEntity.getMbuttonid()==3) {//CPV
						try {
							cpvBusinessRecordServiceImpl.updateMleadsIdfromMrefTref(bean.getLoanLeadIdOfCore(),customerLoanEntity.getMrefno(),
									customerLoanEntity.getTrefno());
						}catch(Exception e) {	
							System.out.println("Error in updating LeadId of CPV");
						}
					}
					else if(loanLevelEntity.getMbuttonid()==4) {//Social
						try {
							socialAndEnvironmentalServiceImpl.updateMleadsIdfromMrefTref(bean.getLoanLeadIdOfCore(),customerLoanEntity.getMrefno(),
									customerLoanEntity.getTrefno());
						}catch(Exception e) {	
							System.out.println("Error in updating LeadId of Social");
						}
					}
					else if(loanLevelEntity.getMbuttonid()==6) {//Trade
						try {
							tradeAndNeighbourRefCheckServiceImpl.updateMleadsIdfromMrefTref(bean.getLoanLeadIdOfCore(),customerLoanEntity.getMrefno(),
									customerLoanEntity.getTrefno());
						}catch(Exception e) {	
							System.out.println("Error in updating LeadId of Trade");
						}
					}
					else if(loanLevelEntity.getMbuttonid()==7) {//Deviation
						try {
							deviationFormServiceImpl.updateMleadsIdfromMrefTref(bean.getLoanLeadIdOfCore(),customerLoanEntity.getMrefno(),
									customerLoanEntity.getTrefno());
						}catch(Exception e) {	
							System.out.println("Error in updating LeadId of Deviation");
						}
					}
					
					
				}
				
			}
		} else {
			loanServiceImpl.updateErrorfromOmni(customerLoanEntity.getMrefno(), bean.getError());
			System.out.println("Not pdated Some Error recieved");
			customerLoanEntity.setMerrormessage(bean.getError());
			
		}
		}catch(Exception e ) {
			loanServiceImpl.updateErrorfromOmni(customerLoanEntity.getMrefno(), "Data Not Correct");
			System.out.println("Not pdated Some Error recieved");
			customerLoanEntity.setMerrormessage("Data Not Correct");
			
		}

		return bean;
	}

	// initail method to get basics loan details issynced loan 0
	public void synchronizeLoanBasicsDetailsToOmni() {
		System.out.println("inside  synchronizeLoanToOmni");
		OmniSoapResultBean bean = new OmniSoapResultBean();
		List<CustomerLoanEntity> loanEntity = loanServiceImpl.getLoanForBasicDetails();
		if (loanEntity != null) {
			int i = 0;
			for (CustomerLoanEntity objEntity : loanEntity) {
				System.out.println("value of i");
				i++;
				System.out.println("I  loan ki values in laon basics  = obj " + i);
				System.out.println(objEntity.getMappldloanamt() + "Applied Amount ");
				if ( objEntity.getMerrormessage() == null || "".equals(objEntity.getMerrormessage().trim())) {
					
					
					try {
						bean = LoanBasicDetailsRequest(objEntity);
					}catch(Exception e) {
						
					}
					
				} else {
					System.out.println("nothing to do");
				}

			}
		} else {
			System.out.println("Loan Entity list is null");
		}
	}

	// final loan approval call in omni
	public void synchronizeFinalLoanApprovalToOmni() {
		System.out.println("inside  synchronizeLoanToOmni");
		OmniSoapResultBean bean = new OmniSoapResultBean();
		List<CustomerLoanEntity> loanEntity = loanServiceImpl.getLoanForFinalApproval();
		if (loanEntity != null) {
			int i = 0;
			for (CustomerLoanEntity objEntity : loanEntity) {
				System.out.println("value of i");
				i++;
				System.out.println("I  loan ki values = obj " + i);
				System.out.println(objEntity.getMleadsid() + " bean.getLoanNumberOfCore() laon approval ");
				if (objEntity.getMleadstatus() == 7
						&&  objEntity.getMleadsid() != null && !("".equals(objEntity.getMleadsid()))
						&& (objEntity.getMerrormessage() == null || "".equals(objEntity.getMerrormessage().trim()))) {
					System.out.println(objEntity.getMappldloanamt() + "Applied Amount ");
					bean = loanApprovalDetailsRequest(objEntity, objEntity.getMleadsid());
				} else {

				}
				System.out.println("Dtaa of primne loan hai yeh bhaiyaji 1" + bean.getMleadsid());

			}
		} else {
			System.out.println("Loan Entity list is null");
		}
	}

	public void synchronizeTDReceiptsToOmni() {
		System.out.println("synchronizeTDReceiptsToOmni");
		List<TDReceiptsEntity> tDReceiptsEntity = tDReceiptsServicesImpl.isDataSynced(0);
		if (tDReceiptsEntity != null) {
			System.out.println("tDReceiptsEntity" + tDReceiptsEntity);
			int i = 0;
			for (TDReceiptsEntity objEntity : tDReceiptsEntity) {
				i++;
				System.out.println("I ki values = obj " + i);
				OmniSoapResultBean bean = omniTDReceiptsServiceImpl.omniSoapServices(objEntity);
				if (bean != null & bean.getStatus() == 0) {
					System.out.println("bean" + bean.getMCustRefNo());
					System.out.println("bean1" + bean.getMCustNo());
					System.out.println("bean2" + bean.getMprdcd());
					// .savingsListServicesImpl.updateSavingsList(bean.getMCustRefNo(),
					// bean.getMCustNo(),bean.getMprdcd()) ;
					tDReceiptsServicesImpl.updateTDReceipts(bean.getMCustRefNo(), bean.getMprdacctid(),
							bean.getMmatval(), bean.getMreceiptstatus());

				} else {
					System.out.println("Inside Else");
					tDReceiptsServicesImpl.updateTDReceiptsErrorfromOmni(bean.getMCustRefNo(), bean.getError());
					System.out.println("Can not be updated Some Error recieved");
				}
			}
		}
	}

	public OmniSoapResultBean loanApprovalDetailsRequest(CustomerLoanEntity objEntity, String loanLeadIdOfCore) {
		System.out.println("xxxxx for loan  details");
		Long customerNoOftab = (long) objEntity.getMcustno();
		// String usrCode = objEntity.getCompositeLoanId().getUsrCode();
		OmniSoapResultBean bean = new OmniSoapResultBean();
		try {
			
			
			bean = omniCustomerLoanMasterServiceImpl.omniSoapServicesLoanAndCustomer(objEntity, loanLeadIdOfCore);

			if (bean != null & bean.getStatus() == 0) {
				loanServiceImpl.updateCustomerLoanAccountNumber(objEntity.getMrefno(), bean.getLoanAccountNumberOfCore());
				objEntity.setMerrormessage(bean.getError());
				objEntity.setMprdacctid(bean.getLoanAccountNumberOfCore());
				
				System.out.println("Loan Ban gya ");
				
			} else {
				loanServiceImpl.updateErrorfromOmni(objEntity.getMrefno(), bean.getError());
				objEntity.setMerrormessage(bean.getError());
				System.out.println("Not updated Some Error recieved");
			}
		}catch(Exception e) {
			
			loanServiceImpl.updateErrorfromOmni(objEntity.getMrefno(), "Data Not Correct");
			objEntity.setMerrormessage("Data Not Correct");
			System.out.println("Not updated Some Error recieved");
		}
		

		return bean;
	}

	// customer generation in omni
	public void synchronizeDailyLoanCollectionToOmni() {
		System.out.println("synchronizeDailyColl");
		long start = System.nanoTime();
		System.out.println("Taking time for Update start synchronizeDailyColl " + start);
		List<DailyLoanCollectedEntity> listEntity = dailyLoanCollectedImpl.isDataSyncedToCoreSys(0);
		System.out.println("Collection list Size hai bhaioye " + listEntity.size());
		if (listEntity != null && listEntity.size() > 0) {

			List<DailyLoanCollectedEntity> listBean = omniDailyLoanCollectionServiceImpl
					.omniSoapServicesDailyCollectedList(listEntity);

			dailyLoanCollectedImpl.updateStatus(listBean);

			long ends = System.nanoTime();
			System.out.println("Taking time for Update ends synchronizeDailyColl " + ends);

			long total = ends - start;

			System.out.println("Taking time for Update total synchronizeDailyColl " + total);

			// }
		}
	}
	
	
	// Center Creation omni
	public void synchronizeCenterMasterToOmni() {
		System.out.println("synchronizeCenterMasterToOmni");
		List<CentersFoundationEntity> centersFoundationEntity = centersFoundationServicesImpl.isDataSynced(0);
		
		System.out.println("Returned Center List is" + centersFoundationEntity.toString());
		
		if (centersFoundationEntity != null) {
			System.out.println("centersFoundationEntity" + centersFoundationEntity);
			int i = 0;
			for (CentersFoundationEntity objEntity : centersFoundationEntity) {
				i++;
				System.out.println("I ki values = obj " + i);
				// if(objEntity!=null&& "".equals(objEntity.getMerrormessage()))
				OmniSoapResultBean bean = omniCenterMasterServiceImpl.omniSoapServices(objEntity);
				if (bean != null & bean.getStatus() == 0) {
					System.out.println("bean" + bean.getStatus());
					System.out.println("bean1" + bean.getCenterId());
					System.out.println("bean2" + bean.getError());
					centersFoundationServicesImpl.updateCentersFoundation(bean.getMRefno(), bean.getCenterId());
					groupFoundationServicesImpl.updateCenterInGroupDetails(bean.getMRefno(), bean.getCenterId(), LocalDateTime.now());
					customerServiceImpl.updateCenterInCustomerDetails(bean.getMRefno(), bean.getCenterId(), LocalDateTime.now());

				} else {
					System.out.println("Inside Else");
					centersFoundationServicesImpl.updateCentersErrorfromOmni(bean.getMRefno(), bean.getError());
					System.out.println("Can not be updated Some Error recieved");
				}
			}
		}

	}
		
	// Group Creation omni
	public void synchronizeGroupMasterToOmni() {
		System.out.println("synchronizeGroupMasterToOmni");
		List<GroupsFoundationEntity> groupsFoundationEntity = groupFoundationServicesImpl.isDataSynced(0);		
		
		if (groupsFoundationEntity != null) {
			System.out.println("groupsFoundationEntity" + groupsFoundationEntity);
			int i = 0;
			for (GroupsFoundationEntity objEntity : groupsFoundationEntity) {
				i++;
				System.out.println("I ki values = obj " + i);				
				
				OmniSoapResultBean bean = new OmniSoapResultBean();
				int trefno = objEntity.getTrefcenterid();
				String mcreatedby = objEntity.getMcreatedby();
				int mrefno = objEntity.getMrefcenterid();
				CentersFoundationEntity center = centersFoundationServicesImpl.findByTrefAndMcreatedByAndIsSynced(trefno, mcreatedby, mrefno, 1);
				if (center == null) {
					System.out.println("No for two");
					center = centersFoundationServicesImpl.findByTrefAndMcreatedByAndIsSynced(trefno, mcreatedby, mrefno, 2);
					if (center == null) {
						System.out.println("No for two");
						center = centersFoundationServicesImpl.findByTrefAndMcreatedByAndIsSynced(trefno, mcreatedby, mrefno, 0);
					}
				}				
				
				if (center != null && center.getMcenterid() > 0) {
					if (objEntity.getMcenterid() <= 0) {
						objEntity.setMcenterid(center.getMcenterid());
					}
					
				    bean = omniGroupMasterServiceImpl.omniSoapServices(objEntity);
				}else
				{
					System.out.println("No such Center");
				}				    
				    
				if (bean != null & bean.getStatus() == 0) {
					groupFoundationServicesImpl.updateGroupsFoundation(bean.getMRefno(), bean.getGroupId());
					customerServiceImpl.updateGroupInCustomerDetails(bean.getMRefno(), bean.getGroupId(), LocalDateTime.now());

				} else {
					System.out.println("Inside Else");
					groupFoundationServicesImpl.updateGroupsErrorfromOmni(objEntity.getMrefno(), bean.getError());
					System.out.println("Can not be updated Some Error recieved");
				}
			}
		}

	}
				public void synchronizeSingleTDReceiptsToOmni(TDReceiptsEntity tdEntity) {
					System.out.println("synchronize Single TD Receipts To Omni");
							
							OmniSoapResultBean bean = omniTDReceiptsServiceImpl.omniSoapServices(tdEntity);
							if (bean != null & bean.getStatus() == 0) {
								System.out.println("bean" + bean.getMCustRefNo());
								System.out.println("bean1" + bean.getMCustNo());
								System.out.println("bean2" + bean.getMprdcd());
								
								tdEntity.setMreceiptstatus(bean.getMreceiptstatus());
								tdEntity.setMmatval(bean.getMmatval());
								tdEntity.setMprdacctid(bean.getMprdacctid());
								tdEntity.setMerrormessage("");
								tDReceiptsServicesImpl.updateTDReceipts(bean.getMCustRefNo(), bean.getMprdacctid(),
										bean.getMmatval(), bean.getMreceiptstatus());

							} else {
								System.out.println("Inside Else");
								tdEntity.setMerrormessage(bean.getError());
								tDReceiptsServicesImpl.updateTDReceiptsErrorfromOmni(bean.getMCustRefNo(), bean.getError());
								System.out.println("Can not be updated Some Error recieved");
							}
						
					}
				
				// Social And Env				
				public void synchronizeSocialAndEnvToOmni() {
					System.out.println("synchronizeSocialAndEnvToOmni");
					boolean leadIdNotPresent=false;
					List<SocialAndEnvironmentalEntity> listEntity = socialAndEnvironmentalServiceImpl.isDataSynced(0);
					System.out.println("List Size -- " + listEntity.size());
					if (listEntity != null) {
						System.out.println("SocialAndEnvEntity" + listEntity);
						int i = 0;
						for (SocialAndEnvironmentalEntity objEntity : listEntity) {
							i++;
							if(objEntity.getMleadsid()==null||("").equals(objEntity.getMleadsid())) {
								System.out.println("Finding for mrefno"+ objEntity.getMloanmrefno());
								leadIdNotPresent = true;
								CustomerLoanEntity customerLoanEntity =customerLoanRepository.findByMrefNo(objEntity.getMloanmrefno());
								if(customerLoanEntity!=null&&customerLoanEntity.getMleadsid()!=null&&!("").equals(customerLoanEntity.getMleadsid())) {
									objEntity.setMleadsid(customerLoanEntity.getMleadsid());	
								}
								
								else {
									continue;
								}
								
								
							}
							System.out.println("I ki values = obj " + i);							
							OmniSoapResultBean bean = omniSocialAndEnvironmentalServiceImpl.omniSoapServices(objEntity);
							if (bean != null & bean.getStatus() == 0) {
								//socialAndEnvironmentalServiceImpl.updateStatus(bean.getMRefno());
								if (leadIdNotPresent == true) {
									socialAndEnvironmentalServiceImpl.updateStatusAndLeadid(bean.getMRefno(),objEntity.getMleadsid());									
								} else {
									socialAndEnvironmentalServiceImpl.updateStatus(bean.getMRefno());
								}
							} else {
								System.out.println("Inside Else");
								socialAndEnvironmentalServiceImpl.updateErrorStatus(bean.getMRefno(),bean.getError());
								System.out.println("Can not be updated Some Error recieved");
							}
							
						}
					}
				}	
				
				//Trade and Neighbour Ref Check				
				public void synchronizeTradeAndNeighRefToOmni() {
					System.out.println("synchronizeTradeAndNeighRefToOmni");
					boolean leadIdNotPresent=false;
					List<TradeAndNeighbourRefCheckEntity> listEntity = tradeAndNeighbourRefCheckServiceImpl.isDataSynced(0);
					System.out.println("List Size -- " + listEntity.size());
					if (listEntity != null) {
						System.out.println("TradeAndNeighbourRefCheckEntity" + listEntity);
						int i = 0;;
						for (TradeAndNeighbourRefCheckEntity objEntity : listEntity) {
							i++;
							if(objEntity.getMleadsid()==null||("").equals(objEntity.getMleadsid())) {
								System.out.println("Finding for mrefno"+ objEntity.getMloanmrefno());
								leadIdNotPresent = true;
								CustomerLoanEntity customerLoanEntity =customerLoanRepository.findByMrefNo(objEntity.getMloanmrefno());
								if(customerLoanEntity!=null&&customerLoanEntity.getMleadsid()!=null&&!("").equals(customerLoanEntity.getMleadsid())) {
									objEntity.setMleadsid(customerLoanEntity.getMleadsid());	
								}
								
								else {
									continue;
								}
								
								
							}
							System.out.println("I ki values = obj " + i);
							OmniSoapResultBean bean = omniTradeAndNeighbourRefCheckServiceImpl.omniSoapServices(objEntity);
							if (bean != null & bean.getStatus() == 0) {
								//tradeAndNeighbourRefCheckServiceImpl.updateStatus(bean.getMRefno());
								if (leadIdNotPresent == true) {
									tradeAndNeighbourRefCheckServiceImpl.updateStatusAndLeadid(bean.getMRefno(),objEntity.getMleadsid());									
								} else {
									tradeAndNeighbourRefCheckServiceImpl.updateStatus(bean.getMRefno());
								}
							} else {
								System.out.println("Inside Else");
								tradeAndNeighbourRefCheckServiceImpl.updateErrorStatus(bean.getMRefno(), bean.getError());
								System.out.println("Can not be updated Some Error recieved");
							}
							
						}
					}
				}	
				
				// Deviation Form
				public void synchronizeDeviationFormToOmni() {
					System.out.println("synchronizeDeviationFormToOmni");
					boolean leadIdNotPresent=false;
					List<DeviationFormEntity> listEntity = deviationFormServiceImpl.isDataSynced(0);
					System.out.println("List Size -- " + listEntity.size());
					if (listEntity != null) {
						System.out.println("DeviationFormEntity" + listEntity);
						int i = 0;
						for (DeviationFormEntity objEntity : listEntity) {
							i++;
							if(objEntity.getMleadsid()==null||("").equals(objEntity.getMleadsid())) {
								System.out.println("Finding for mrefno"+ objEntity.getMloanmrefno());
								leadIdNotPresent = true;
								CustomerLoanEntity customerLoanEntity =customerLoanRepository.findByMrefNo(objEntity.getMloanmrefno());
								if(customerLoanEntity!=null&&customerLoanEntity.getMleadsid()!=null&&!("").equals(customerLoanEntity.getMleadsid())) {
									objEntity.setMleadsid(customerLoanEntity.getMleadsid());	
								}
								
								else {
									continue;
								}
								
								
							}
							System.out.println("I ki values = obj " + i);
							// if(objEntity!=null&& "".equals(objEntity.getMerrormessage()))
							OmniSoapResultBean bean = omniDeviationFormServiceImpl.omniSoapServices(objEntity);
							if (bean != null & bean.getStatus() == 0) {
								//deviationFormServiceImpl.updateStatus(bean.getMRefno());
								if (leadIdNotPresent == true) {
									deviationFormServiceImpl.updateStatusAndLeadid(bean.getMRefno(),objEntity.getMleadsid());									
								} else {
									deviationFormServiceImpl.updateStatus(bean.getMRefno());
								}
							} else {
								System.out.println("Inside Else");
								deviationFormServiceImpl.updateErrorStatus(bean.getMRefno(), bean.getError());
								System.out.println("Can not be updated Some Error recieved");
							}
							
						}
					}
				}	
				
				
				
				
				public void synchronizeCustomerLoanCashFlow() {
					System.out.println("Synchronize Loan Cashflow");
					boolean leadIdNotPresent=false;
					List<CustomerLoanCashFlowEntity> listEntity = cashFlowServiceImpl.isDataSynced(1);
					System.out.println("List Size CashFlow-- " + listEntity.size());
					if (listEntity != null) {
						System.out.println("Cash Flow" + listEntity);
						int i = 0;
						for (CustomerLoanCashFlowEntity objEntity : listEntity) {
							i++;
							System.out.println("I ki values = obj " + i);
							if(objEntity.getMleadsid()==null||("").equals(objEntity.getMleadsid())) {
								System.out.println("Finding for mrefno"+ objEntity.getMloanmrefno());
								leadIdNotPresent = true;
								CustomerLoanEntity customerLoanEntity =customerLoanRepository.findByMrefNo(objEntity.getMloanmrefno());
								if(customerLoanEntity!=null&&customerLoanEntity.getMleadsid()!=null&&!("").equals(customerLoanEntity.getMleadsid())) {
									objEntity.setMleadsid(customerLoanEntity.getMleadsid());	
								}
								
								else {
									continue;
								}
								
								
							}
							// if(objEntity!=null&& "".equals(objEntity.getMerrormessage()))
							try {
								OmniSoapResultBean bean = omniCashflowServiceImpl.omniSoapServices(objEntity);
								if (bean != null && bean.getStatus() == 0) {
									//cashFlowServiceImpl.updatemisSynctocoreSys(2, objEntity.getMrefno(),bean.getError());
									if (leadIdNotPresent == true) {
										cashFlowServiceImpl.updateStatusAndLeadid(bean.getMRefno(),objEntity.getMleadsid());									
									} else {
										cashFlowServiceImpl.updatemisSynctocoreSys(2, objEntity.getMrefno(),bean.getError());
									}
								} else {
									System.out.println("Inside Else");
									
									cashFlowServiceImpl.updateMerrorMessage(9, bean.getMRefno(), bean.getError());
									System.out.println("Can not be updated Some Error recieved");
								}
							}catch(Exception e) {
								
								cashFlowServiceImpl.updateMerrorMessage(9, objEntity.getMrefno(), "System Busy Please try again");
							}
							
							
						}
					}
				}	
				
				
				// CONTACT POINT VERIFICATION BUSINESS & OFFICE
				public void synchronizeCpvBusinessRecordToOmni() {
					System.out.println("synchronizeCpvBusinessRecordToOmni");
					boolean leadIdNotPresent=false;
					List<CustomerLoanCPVBusinessRecordEntity> listEntity = cpvBusinessRecordServiceImpl.isDataSynced(0);
					System.out.println("List Size -- " + listEntity.size());
					if (listEntity != null) {
						System.out.println("CustomerLoanCPVBusinessRecordEntity" + listEntity);
						int i = 0;
						for (CustomerLoanCPVBusinessRecordEntity objEntity : listEntity) {
							i++;
							if(objEntity.getMleadsid()==null||("").equals(objEntity.getMleadsid())) {
								System.out.println("Finding for mrefno"+ objEntity.getMloanmrefno());
								leadIdNotPresent = true;
								CustomerLoanEntity customerLoanEntity =customerLoanRepository.findByMrefNo(objEntity.getMloanmrefno());
								if(customerLoanEntity!=null&&customerLoanEntity.getMleadsid()!=null&&!("").equals(customerLoanEntity.getMleadsid())) {
									objEntity.setMleadsid(customerLoanEntity.getMleadsid());	
								}
								
								else {
									continue;
								}
								
								
							}
							
							System.out.println("I ki values = obj " + i);
							// if(objEntity!=null&& "".equals(objEntity.getMerrormessage()))
							OmniSoapResultBean bean = omniCpvBusinessRecordServiceImpl.omniSoapServices(objEntity);
							if (bean != null & bean.getStatus() == 0) {
								//cpvBusinessRecordServiceImpl.updateStatus(bean.getMRefno());
								if (leadIdNotPresent == true) {
									cpvBusinessRecordServiceImpl.updateStatusAndLeadid(bean.getMRefno(),objEntity.getMleadsid());									
								} else {
									cpvBusinessRecordServiceImpl.updateStatus(bean.getMRefno());
								}
							} else {
								System.out.println("Inside Else");
								cpvBusinessRecordServiceImpl.updateErrorStatus(bean.getMRefno(), bean.getError());
								System.out.println("Can not be updated Some Error recieved");
							}
							
						}
					}
				}
				
				
				// Guarantor
				public void synchronizeGuarantorToOmni() {
					System.out.println("synchronizeGuarantorToOmni");
					boolean leadIdNotPresent=false;
					List<BigDecimal> listEntity = guarantorServicesImpl.isDataSynced(0);
					System.out.println("List Size -- " + listEntity.size());
				
					
					String leadsId = "";					
					
					if (listEntity != null) {
						System.out.println("GuarantorEntity" + listEntity);						
		/*				for (int guaranterLoanMapHolder : listEntity) {
							
	
					
						}*/
						for (int guar = 0; guar < listEntity.size(); guar++) { 
							  
							List<GuarantorEntity> guarantorEntity =null;
							try {
								 guarantorEntity = guarantorServicesImpl.findDataByMloanRefoJoin(listEntity.get(guar));
							}catch(Exception e) {
								e.printStackTrace();
							}
								List<GuarantorEntity> gaurantorSendingList = new ArrayList<GuarantorEntity>();
								
								if(guarantorEntity!=null) {
								for (GuarantorEntity objEntity : guarantorEntity) {
									System.out.println("leadsId Loan xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -- " + leadsId);
		
									objEntity.setMleadsid(objEntity.getMleads());					
										gaurantorSendingList.add(objEntity);	
										
										}
								}
									
									if(!gaurantorSendingList.isEmpty()) {
										
										OmniSoapResultBean bean=null;
										try{
										bean = omniGuarantorDetailServiceImpl.omniSoapServicesGuarantorList(gaurantorSendingList);
										if (bean != null & bean.getStatus() == 0) {
											//guarantorServicesImpl.updateStatus(bean.getMRefno());
											//if (leadIdNotPresent == true) {
												guarantorServicesImpl.updateStatusAndLeadid(bean.getMLoanRefNo(),leadsId);									
											/*} else {
												guarantorServicesImpl.updateStatus(bean.getMLoanRefNo());
											}*/
										} else {
											System.out.println("Inside Else");
											guarantorServicesImpl.updateErrorStatus(bean.getMLoanRefNo());
											System.out.println("Can not be updated Some Error recieved");
										}
										
										gaurantorSendingList = new ArrayList<GuarantorEntity>();
										leadsId = "";
									}
								
									catch(Exception e) {								
											//objEntity.setMerrormessage("Something went wrong");							
											System.out.println("Inside Else");								
											guarantorServicesImpl.updateErrorStatus(bean.getMLoanRefNo());
											System.out.println("Can not be updated Some Error recieved");
											
										}
									}
				            
				        } 		
						
						
						}
						
			
						
			
				}	
			


				public void synchronizeKycMasterToOmni() {
					System.out.println("synchronizeKycMasterToOmni");
					boolean leadIdNotPresent=false;
					List<KycMasterEntity> listEntity = kycMasterServiceImpl.isDataSynced(0);
					System.out.println("List Size -- " + listEntity.size());
					if (listEntity != null) {
						System.out.println("KycMasterEntity" + listEntity);
						int i = 0;
						for (KycMasterEntity objEntity : listEntity) {
							i++;
							String leadsid = getLeadsidFromLoan(objEntity);
							System.out.println("getMloanmrefno id :"+objEntity.getMloanmrefno());
							
							if(objEntity.getMleadsid()==null||("").equals(objEntity.getMleadsid())) {
								System.out.println("Finding for mrefno"+ objEntity.getMloanmrefno());
								leadIdNotPresent = true;
								CustomerLoanEntity customerLoanEntity =customerLoanRepository.findByMrefNo(objEntity.getMloanmrefno());
								if(customerLoanEntity!=null&&customerLoanEntity.getMleadsid()!=null&&!("").equals(customerLoanEntity.getMleadsid())) {
									objEntity.setMleadsid(customerLoanEntity.getMleadsid());	
								}
								
								else {
									continue;
								}
								
								
							}

							System.out.println("mleads id :"+leadsid);
							if(leadsid == null || leadsid.equals("") ) {
								System.out.println("no records found");
							}else {
								System.out.println("I ki values = obj " + i);
								// if(objEntity!=null&& "".equals(objEntity.getMerrormessage()))
								objEntity.setMleadsid(leadsid);
								OmniSoapResultBean bean = omniKycMasterServiceImpl.omniSoapServices(objEntity);
								if (bean != null & bean.getStatus() == 0) {
									//kycMasterServiceImpl.updateStatus(bean.getMRefno());
									if (leadIdNotPresent == true) {
										kycMasterServiceImpl.updateStatusAndLeadid(bean.getMRefno(),objEntity.getMleadsid());									
									} else {
										kycMasterServiceImpl.updateStatus(bean.getMRefno());
									}
								} else {
									System.out.println("Inside Else");
									kycMasterServiceImpl.updateErrorStatus(bean.getMRefno(), bean.getError());
									System.out.println("Can not be updated Some Error recieved");
								}
							}
							
							
							
						}
					}
				}




				private String getLeadsidFromLoan(KycMasterEntity objEntity) {
					// TODO Auto-generated method stub
					
					CustomerLoanEntity customerLoanEntity =customerLoanRepository.findByMrefNo(objEntity.getMloanmrefno());
					
					if(customerLoanEntity== null) {
						return null;
					}
					else {
						System.out.println("leads id" + customerLoanEntity.getMleadsid());
						return customerLoanEntity.getMleadsid();
					}
					
					
				}	
				
				
				
				
				
				public void synchronizeDisbursedListToOmni() {
					System.out.println("Syncronize Disbursed");
					long start = System.nanoTime();
					System.out.println("Taking time for Update start synchronizeDailyColl " + start);
					List<DisbursedListEntity> listEntity = disbursedListServiceImpl.isDataSynced(0, 1);
					System.out.println("Disbursed list Size hai " + listEntity.size());
					if (listEntity != null && listEntity.size() > 0) {

						List<DisbursedListEntity> listBean = omniDisbursedListServiceImpl
								.omniSoapServicesDisbursedList(listEntity);
							
							
							disbursedListServiceImpl.updateStatus(listBean);

							long ends = System.nanoTime();
							System.out.println("Taking time for Update ends synchronizeDailyColl " + ends);

							long total = ends - start;

							System.out.println("Taking time for Update total synchronizeDailyColl " + total);
							
						
					}
				}
			
				
				
				public void synchronizeDisbursedListAutorizationToOmni() {
					System.out.println("Syncronize Disbursed Authorized");
					long start = System.nanoTime();
					System.out.println("Taking time for Update start synchronizeDailyColl " + start);
					List<DisbursedListEntity> listEntity = disbursedListServiceImpl.isDataSynced(0, 2);
					System.out.println("Disbursed authorized list Size hai " + listEntity.size());
					if (listEntity != null && listEntity.size() > 0) {

						List<DisbursedListEntity> listBean = omniDisbursedListAuthServiceImpl
								.omniSoapServicesDisbursedList(listEntity);
							
							
							disbursedListServiceImpl.updateStatus(listBean);

							long ends = System.nanoTime();
							System.out.println("Taking time for Update ends synchronizeDailyColl " + ends);

							long total = ends - start;

							System.out.println("Taking time for Update total synchronizeDailyColl " + total);
							
						
					}
				}
			
			
				

}
