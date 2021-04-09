package com.infrasofttech.microfinance.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AckHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerDedupHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerModificationAccessHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.StatusHistoryHolder;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.OmniLoginService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl.OmniCustomerMasterServiceImpl;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.repository.CustomerRepository;
import com.infrasofttech.microfinance.servicesimpl.CustomerLoanServiceImpl;
import com.infrasofttech.microfinance.servicesimpl.CustomerServiceImpl;

@RestController
@RequestMapping("/customerData")
public class CustomersController {

	@Autowired
	CustomerServiceImpl customerService;
	
	@Autowired
	OmniCustomerMasterServiceImpl omniCustomerMasterServiceImpl;
	@Autowired
	CustomerLoanServiceImpl loanServiceImpl; 
	@Autowired
	CustomerRepository customerRepository;
	
	@Autowired
	OmniLoginService omniLoginService;
	
	
	
	@GetMapping(value = "/getlistOfCustomers", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return customerService.getAllCustomerData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<CustomerEntity> customer){
		if(null != customer)
			return customerService.addList(customer);
		return null;
	}
	
	
	@PostMapping(value = "/getCustomerbyCreatedByAndLastSyncedTiming/", produces = "application/json")
	public ResponseEntity<?>  getCustomerbyAgentUserName(@RequestBody CustomerEntity customerEntity){
		System.out.println(customerEntity.getMlastsynsdate()+"printng chu1 ");
		System.out.println(customerEntity.getMcreatedby()+"printng chu2 ");
		if(null != customerEntity.getMcreatedby()) {
			System.out.println(customerEntity.getMlastsynsdate()!=null?customerEntity.getMlastsynsdate():"printng chu ");
			return customerService.findByCreatedByAndLastSyncedTime(customerEntity);
		}
		return null;
	}
	
	
	@PostMapping(value = "/getCustomerDedup/", produces = "application/json")
	public ResponseEntity<CustomerEntity>  getCustomerDedup(@RequestBody CustomerDedupHolder customerDedupHolder){
		if(null != customerDedupHolder.getMnationalid()) {
			System.out.println(" customerDedupHolder.getMnationalid() : "+customerDedupHolder.getMnationalid().toString());
			return customerService.getCustomerDedup(customerDedupHolder);
		}
		return null;
	}
	
	
	
	
	
	@PostMapping(value = "/addCustomerByHolder", produces = "application/json")
	public ResponseEntity<?>  addCustomerListByHolder(@RequestBody List<CustomerHolderBean> customerlist){		
		ResponseEntity<List<CustomerEntity>> responseEntity =  customerService.addCustomerListByHolder(customerlist);
		//System.out.println("Response xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
		//System.out.println(responseEntity);
       if(customerlist.size()==1) {   	   
    	   
    	   List<CustomerEntity> addEntity;
			for(CustomerEntity entity : responseEntity.getBody()) {	
				customerService.getWholeEntity(entity);
				addEntity = new ArrayList<CustomerEntity>();
				//Changes done by shadab for customer modification in single sync 
				//if(entity.getMcustno()==0) {				
				synchronizeCustomerToOmni(entity);
				//CustomerEntity custEntity = customerRepository.findByMrefNo(entity.getMrefno());
				addEntity.add(entity);
				System.out.println("Response xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  + entity.getMcustno());
				System.out.println("error message xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"  + entity.getMerrormessage());

				responseEntity = new ResponseEntity<List<CustomerEntity>>(addEntity,new HttpHeaders(),HttpStatus.CREATED);				
				/*} else {
					addEntity = new ArrayList<CustomerEntity>();
					addEntity.add(entity);
					responseEntity = new ResponseEntity<List<CustomerEntity>>(addEntity,new HttpHeaders(),HttpStatus.CREATED);
				}*/
			}
		}
		return responseEntity;
		
	}
	
	
	
	@PostMapping(value = "/getCustomerbyID", produces = "application/json")
	public ResponseEntity<?>  getCustomerbyID(@RequestBody CustomerEntity customerEntity){
		if(customerEntity.getMpannodesc()!=null&&customerEntity.getMiddesc()!=null) {
			
			System.out.println(customerEntity.getMpannodesc()+"  "+customerEntity.getMiddesc());
			return customerService.getCustomerById(customerEntity.getMpannodesc(),customerEntity.getMiddesc());
		}
		return null;
	}
	
	
	@PostMapping(value = "/getCustomerbyCenterId/", produces = "application/json")
	public ResponseEntity<?>  getCustomerbyCenterId(@RequestBody CustomerEntity customerEntity){
		if(0 != customerEntity.getMcenterid()) {
			
			return customerService.findByCenterId(customerEntity);
		}
		return null;
	}
	
	 //customer generation in omni
    public void synchronizeCustomerToOmni(CustomerEntity entity) {
    	System.out.println("synchronizeCustomerToOmni");    	
    		if(entity!=null) {  
    			try { 	
    			if(Constants.Field204 != null && Constants.Field204.equals("") ) {
    				//OmniLoginService login = new OmniLoginService();    		
    				omniLoginService.loginOmni();    			
    			}
    				OmniSoapResultBean bean = omniCustomerMasterServiceImpl.omniSoapServices(entity);    				
    				if(bean!=null && bean.getStatus() ==0) {
    				entity.setMcustno(bean.getMCustNo());
    				System.out.println("Receipt status is "+bean.getMreceiptstatus());
    				entity.setMcuststatus(bean.getMreceiptstatus());
    				customerService.updateCustomer(bean.getMCustRefNo(), bean.getMCustNo(),LocalDateTime.now(),bean.getMreceiptstatus())  ;
					loanServiceImpl.updateCustomerInLoanDetails(entity.getMrefno(), bean.getMCustNo(),LocalDateTime.now());
    				} else if(bean!=null) {
    					
    					entity.setMerrormessage(bean.getError());
    					if(bean.getError()!=null&&
    							
    							(bean.getError().trim().equals(Constants.SESSIONERRORONE)||
    									bean.getError().trim().equals(Constants.SESSIONERRORTWO)||
    									
    									bean.getError().trim().equals(Constants.SESSIONERRORTHREE)	)) {
							
    						entity.setMretry(entity.getMretry()+1);
							if(entity.getMretry()==3) {
								
								customerService.updateErrorWithRetryFromOmni(bean.getMCustRefNo(), bean.getError(),entity.getMretry(),2);
							}else {
								customerService.updateErrorWithRetryFromOmni(bean.getMCustRefNo(), bean.getError(),entity.getMretry(),0);	
									
							}
							
						}
						else {
							customerService.updateErrorfromOmni(bean.getMCustRefNo(), bean.getError());	
						}    					
    					
    					System.out.println("Not pdated Some Error recieved");
    				}
    				
    				else {
    					entity.setMretry(entity.getMretry()+1);	
        				entity.setMerrormessage("Returned Blank Try again  ");
        				if(entity.getMretry()==3) {
    						
    						customerService.updateErrorWithRetryFromOmni(entity.getMrefno(),entity.getMerrormessage(),entity.getMretry(),2);
    					}else {
    						customerService.updateErrorWithRetryFromOmni(entity.getMrefno(),entity.getMerrormessage(),entity.getMretry(),0);	
    							
    					}	
    					
    				}
    			}catch(Exception e) {
					
    				
    				entity.setMretry(entity.getMretry()+1);	
    				entity.setMerrormessage("System Busy Please Try ");
    				//customerService.updateErrorWithRetryFromOmni(entity.getMrefno(), entity.getMerrormessage(),entity.getMretry());	
					if(entity.getMretry()==3) {
						
						customerService.updateErrorWithRetryFromOmni(entity.getMrefno(),entity.getMerrormessage(),entity.getMretry(),2);
					}else {
						customerService.updateErrorWithRetryFromOmni(entity.getMrefno(),entity.getMerrormessage(),entity.getMretry(),0);	
							
					}					
    				
    				
    				
				
				  System.out.println("xxxxxxxxxxxxxDoing it from SinngleSync");
				  
				  customerService.updateErrorfromOmni(entity.getMrefno(),
				  entity.getMerrormessage());
				  System.out.println("Not pdated Some Error recieved");
				 
    				
    				
				}
    			
		}
    						
    			}
    
    
    
    
    
    
//    @PostMapping(value = "/getFinprintByCustNo", produces = "application/json")
//	public ResponseEntity<?>  getFingerPrintByCustNo(@RequestBody CustomerEntity customerEntity){
//		if(customerEntity.getMcustno()!=0) {
//			
//			System.out.println(" Getting Finger Print for  "+customerEntity.getMcustno());
//			return customerService.getFingerPrintByCustNo(customerEntity.getMcustno());
//		}
//		return null;
//	}
//    
    
    @PostMapping(value =  "/StatusHistoryRequest/", produces = "application/json")
	public ResponseEntity<?>  getStatusHistoryRequest(@RequestBody StatusHistoryHolder statusHistoryHolder){
		if(null != statusHistoryHolder) {
		//	System.out.println(customerLoanEntity.getMlastsynsdate()!=null?customerLoanEntity.getMlastsynsdate():"printng chu ");
			return customerService.updateStatusFromCore(statusHistoryHolder);
		}
		return null;
	}
    
    
    
    @PostMapping(value =  "/CustomerModifyAccess/", produces = "application/json")
  	public ResponseEntity<?>  updateCustomerModificationAccess(@RequestBody CustomerModificationAccessHolder accessHolder){
  		if(null != accessHolder) {
  		//	System.out.println(customerLoanEntity.getMlastsynsdate()!=null?customerLoanEntity.getMlastsynsdate():"printng chu ");
  			return customerService.updateCustomerModificationAccess(accessHolder);
  		}
  		return null;
  	}
    
    
    
	@PostMapping(value = "/getCustomerForGaurantor/", produces = "application/json")
	public ResponseEntity<CustomerEntity>  getCustomerDetails(@RequestBody CustomerDedupHolder customerDedupHolder){
		if(null != customerDedupHolder.getMnationalid()||0!=customerDedupHolder.getMcustno()) {
			System.out.println(" customerDedupHolder.getMnationalid() : "+customerDedupHolder.getMnationalid());
			return customerService.getCustomerDetails(customerDedupHolder);
		}
		return null;
	}
	
	
	
	@PostMapping(value = "/updateCustomerSyncFromServer/", produces = "application/json")
	public ResponseEntity<CustomerEntity>  updateCustomerSyncFromServer(@RequestBody AckHolder ackHolder){
		if(null != ackHolder ) {
			System.out.println(" Ack List : "+ ackHolder.getMrefnolist());
			 customerService.updateSyncFromCore(ackHolder.getMrefnolist());
		}
		return null;
	}
	
	
    @PostMapping(value = "/getFinprintByCustNo", produces = "application/json")
	public ResponseEntity<?>  getFingerPrintByCustNo(@RequestBody CustomerEntity customerEntity){
		if(customerEntity.getMcustno()!=0) {
			
			System.out.println(" Getting Finger Print for  "+customerEntity.getMcustno());
			return customerService.getFingerPrintByCustNo(customerEntity.getMcustno());
		}
		return null;
	}
 
	
    @PostMapping(value = "/getCustomerbyCenterIdForLocations/", produces = "application/json")
	public ResponseEntity<?>  getCustomerbyCenterIdForLocations(@RequestBody CustomerEntity customerEntity){
		if(0 != customerEntity.getMcenterid()) {			
			return customerService.findByCenterIdForLocations(customerEntity);
		}
		return null;
	}
	
}
