package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.InternalBankTransferEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.InternalBankTransferHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.InternalBankTransferServices;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.repository.DisbursedListRepository;
import com.infrasofttech.microfinance.repository.InternalBankTransferRepository;
@Service
public class InternalBankTransferServiceImpl implements InternalBankTransferServices {
	
	@Autowired
	InternalBankTransferRepository internalBankRepo;

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		TMsgInParam inParams = null ;	
		
		TMsgOutParam outparam = null;
		OmniSoapResultBean OmniSoapBean = new OmniSoapResultBean() ;
		
		
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try 
		{

			InternalBankTransferEntity internalBankTransferBean = (InternalBankTransferEntity) bean;
			TMsgInParam inParam = new TMsgInParam();
			
			
				inParam.setField1(String.valueOf(internalBankTransferBean.getMlbrcode()));
				inParam.setField2(String.valueOf(internalBankTransferBean.getMcashtr()));
				if(internalBankTransferBean.getMcashtr()==1) {
					inParam.setField3(String.valueOf(internalBankTransferBean.getMcrdr()));
					inParam.setField4(String.valueOf(internalBankTransferBean.getMaccid()));
					
				}else {
					inParam.setField3(String.valueOf(internalBankTransferBean.getMdraccid()));
					inParam.setField4(String.valueOf(internalBankTransferBean.getMcraccid()));
				}
				inParam.setField5(String.valueOf(internalBankTransferBean.getMamt()));
				inParam.setField6(String.valueOf(internalBankTransferBean.getMnarration()));
				inParam.setField7(String.valueOf(internalBankTransferBean.getMremark()));
				inParam.setField8(String.valueOf(internalBankTransferBean.getMcreatedby()));

				
				
			
			inParam.setField202("99");
			inParam.setField204(Constants.Field204);	
			System.out.println("inparamsa are "+inParam);
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910918, inParam);
			System.out.println("Internal Transaction  here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField203() +"203 hai yeh error For Internal Transaction");
			System.out.println(outparam.getField202());	
			System.out.println("Internal transaction here ends");
			System.out.println(outparam);
			
			if(outparam!=null&&!outparam.getField201().equals("0")){
				OmniSoapBean.setError(outparam.getField203());
				OmniSoapBean.setStatus(0);
				//OmniSoapBean.setMsetno(Integer.valueOf(outparam.getField1()));
				return OmniSoapBean;
			}
			if(outparam!=null && outparam.getField1() !=null) {
				OmniSoapBean.setError(outparam.getField203());
				OmniSoapBean.setStatus(1);
				//OmniSoapBean.setMsetno(Integer.valueOf(outparam.getField1()));
				return OmniSoapBean;
				
			} else {
				OmniSoapBean.setError("No Response from server");
				//OmniSoapBean.setMsetno(Integer.valueOf(outparam.getField1()));
				OmniSoapBean.setStatus(0);
				return OmniSoapBean;
			}
	
		}catch (RemoteException e){
			
			OmniSoapBean.setError("Something Went wrong");
			OmniSoapBean.setStatus(0);
			OmniSoapBean.setMsetno(0);
		

		return OmniSoapBean;
	}
	}

	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		// TODO Auto-generated method stub
		
		InternalBankTransferHolderBean internalBankTransferBean = (InternalBankTransferHolderBean) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		
			inParam.setField1(String.valueOf(internalBankTransferBean.getMlbrcode()));
			inParam.setField2(String.valueOf(internalBankTransferBean.getMcashtr()));
			if(internalBankTransferBean.getMcashtr()==1) {
				inParam.setField3(String.valueOf(internalBankTransferBean.getMcrdr()));
				inParam.setField4(String.valueOf(internalBankTransferBean.getMaccid()));
				
			}else {
				inParam.setField3(String.valueOf(internalBankTransferBean.getMdraccid()));
				inParam.setField4(String.valueOf(internalBankTransferBean.getMcraccid()));
			}
			inParam.setField5(String.valueOf(internalBankTransferBean.getMamt()));
			inParam.setField6(String.valueOf(internalBankTransferBean.getMnarration()));
			inParam.setField7(String.valueOf(internalBankTransferBean.getMremark()));
			inParam.setField8(String.valueOf(internalBankTransferBean.getMcreatedby()));

			
			
		
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;
		
	
	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	
	
public InternalBankTransferHolderBean omniSoapServicesInternalBankTransfer(InternalBankTransferHolderBean bean) {
		
		TMsgInParam inParams = null ;	
	
		TMsgOutParam outparam = null;
		
		
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try 
		{

			inParams = prepareRequestToOmni(bean);
			System.out.println(inParams);
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910918, inParams);
			System.out.println("Internal Transaction  here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField203() +"203 hai yeh loan lead id generation");
			System.out.println(outparam.getField202());	
			System.out.println("Internal transaction here ends");
			System.out.println(outparam);
			if(outparam!=null && outparam.getField201().trim().equals("0")){
				bean.setMerrormessage(outparam.getField203());
				bean.setMstatus(1);
				bean.setMsetno(Integer.valueOf(outparam.getField1()));
				bean.setMlbrcode(Integer.valueOf(outparam.getField2()));
				bean.setMentrydt(outparam.getField3());
				bean.setMbatchcd(outparam.getField4());
				bean.setMcurcd(outparam.getField5());
				return bean;
			}
			if(outparam!=null && !outparam.getField201().trim().equals("1")) {
				bean.setMerrormessage(outparam.getField203());
				bean.setMstatus(0);
				bean.setMsetno(Integer.valueOf(outparam.getField1()));
				bean.setMlbrcode(Integer.valueOf(outparam.getField2()));
				bean.setMentrydt(outparam.getField3());
				bean.setMbatchcd(outparam.getField4());
				bean.setMcurcd(outparam.getField5());
				return bean;
				
			} else {
				bean.setMerrormessage("No Response from server");
				bean.setMsetno(Integer.valueOf(outparam.getField1()));
				bean.setMlbrcode(Integer.valueOf(outparam.getField2()));
				bean.setMentrydt(outparam.getField3());
				bean.setMbatchcd(outparam.getField4());
				bean.setMcurcd(outparam.getField5());
				bean.setMstatus(0);
				return bean;
			}
	
		}catch (RemoteException e){
			
			bean.setMerrormessage("Something Went wrong");
			bean.setMstatus(0);
			bean.setMsetno(0);
		

		return bean;
	}
}


public List<InternalBankTransferEntity> getListNotSynced(){
	
	return internalBankRepo.getTransactionNotSynced();
	
	
}


public ResponseEntity<?> addList(List<InternalBankTransferEntity> interBankTransferEntity) {
	try {
		
		List<InternalBankTransferEntity> InterBankTransferList =new ArrayList<InternalBankTransferEntity>();
		for(InternalBankTransferEntity bean: interBankTransferEntity) {

			System.out.println("Trying to add for "+ bean.getMrefno());
			if( bean.getMrefno()!=0) {
				System.out.println("getting Loan mrefno"+bean.getMrefno());
				InternalBankTransferEntity internalBankBean = internalBankRepo.findByMrefNo(bean.getMrefno());
				if(internalBankBean!=null) {
					
				}
			}else {
				InterBankTransferList.add(bean);
			}

			
		}
		
		return new ResponseEntity<Object>(internalBankRepo.saveAll(InterBankTransferList),new HttpHeaders(),HttpStatus.CREATED);
	} catch (Exception e) {
		//logger.error("Error While Persisting Object"+e.getMessage());
		return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
	}
}



@Transactional
public int  updateResponseFromOmni(String merrormessage,int missynctocoresys,int mretry,int mrefno) {
	//try {
		
		System.out.println("mrefno is "+ mrefno );
		System.out.println("missynctocoresys is "+missynctocoresys);
		System.out.println("mretry hai " + mretry);
		System.out.println("merrormessage hai "+merrormessage );

		return internalBankRepo.updateStausFromOmni(merrormessage,missynctocoresys,mretry,mrefno, LocalDateTime.now());
				
//	} catch (Exception e) {
//		//logger.error("Error While Persisting Object"+e.getMessage());
//		return 0;
//	}
}



@Transactional(readOnly=true)
public void updateSyncFromCore(List<Integer> mrefNoList){
	try {
		
		//System.out.println("Idhar bhi aaya");
		internalBankRepo.updateSyncFromServer(mrefNoList);
		
	}
	catch(Exception e ) {
		
	}
}


@Transactional(readOnly=true)
public ResponseEntity<?> findModifiedData(InternalBankTransferEntity internalBankTransferEntity) {		
	try {
		
		List<InternalBankTransferEntity> internalBankTransferList;
		internalBankTransferList = new ArrayList<InternalBankTransferEntity>();
		if(internalBankTransferEntity.getMlastsynsdate()==null ) {
		
			internalBankTransferList = internalBankRepo.findByCreatedby(internalBankTransferEntity.getMcreatedby());
		}else {
			internalBankTransferList=internalBankRepo.findByCreatedbyWithLastSyncDate(internalBankTransferEntity.getMcreatedby());
		}
		
		
		if(internalBankTransferList.isEmpty()) 
			return ResponseEntity.notFound().build();
		return new ResponseEntity<List<InternalBankTransferEntity>>(internalBankTransferList,new HttpHeaders(),HttpStatus.OK);
	}catch(Exception e) {
		System.out.println("No Record Found. wasasas : "+e.getStackTrace());
		//logger.error("No Record Found."+e.getMessage());
		return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
	}

}
}

	

