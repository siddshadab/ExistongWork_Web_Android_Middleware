package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniDisbursedListAuthorizationService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniDisbursedListService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.repository.SystemParameterRepository;
import com.infrasofttech.microfinance.servicesimpl.DisbursedListServiceImpl;
import com.infrasofttech.microfinance.utility.Utility;


@Service
public class OmniDisbursedListAuthorizationServiceImpl implements OmniDisbursedListAuthorizationService{
	//DailyLoanCollectedEntity dailyLoanCollectedEntity = new DailyLoanCollectedEntity();
	@Autowired
	DisbursedListServiceImpl disbServiceImpl;	
	
	@Autowired
	SystemParameterRepository systemParamRepo;
	
	boolean isOnline;
	
	
	
	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		DisbursedListEntity disbursedListEntity = (DisbursedListEntity) bean;
		
		
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(disbursedListEntity);
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910921, inParams);
			System.out.println("here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField102());
			System.out.println(outparam.getField103());
			System.out.println(outparam.getField104());
			System.out.println(outparam.getField201());
			System.out.println(outparam.getField204());
			System.out.println(outparam.getField203() + " 203 hai yeh customer Creation time");
			System.out.println(outparam.getField202());
			System.out.println("here ends");
			retBean = prepareResponseRecievedFromOmni(outparam);
			retBean = new OmniSoapResultBean();		
			retBean.setMCustRefNo(disbursedListEntity.getMrefno());
			retBean.setCreatedBy(disbursedListEntity.getMcreatedby());
			retBean.setTRefno(disbursedListEntity.getTrefno());
			if (!outparam.getField201().equals("0")) {
				System.out.println("Dayta of in patrams 1"+outparam.toString());
				retBean.setStatus(1);
				//retBean.setMCustNo(0);				
				retBean.setError(outparam.getField203());
				return retBean;
			}
			System.out.println("Dayta of in patrams 2 "+outparam.toString());
			if(outparam!=null && outparam.getField1() !=null) {
				retBean.setStatus(0);
				//retBean.setMCustNo(Integer.parseInt(outparam.getField1()));
			} else {
				retBean.setStatus(1);
				//retBean.setMCustNo(0);
				retBean.setError(outparam.getField203());
			}
			
			return retBean;
		} catch (RemoteException e) {

		}

		return null;
	}

	List<DisbursedListEntity> beanList ;
	
	public List<DisbursedListEntity> omniSoapServicesDisbursedList(List<DisbursedListEntity> beanList,boolean isOnline) {
		//DailyLoanCollectedEntity dailyLoanCollectedEntity = (DailyLoanCollectedEntity) bean;
		//this.beanList = new ArrayList<DailyLoanCollectedEntity>();
		this.beanList= beanList;
		this.isOnline = isOnline;
		
		System.out.println("this.beanList " +this.beanList.size());
		//System.out.println("beanList " +beanList.size());
		TMsgInParam inParams = prepareRequestToOmni(null);
		
		
		System.out.println("starts");
		System.out.println(inParams);
		System.out.println("ends");
		
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "5", 910921, inParams);
			System.out.println("here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField102());
			System.out.println(outparam.getField103());
			System.out.println(outparam.getField104());
			System.out.println(outparam.getField201());
			System.out.println(outparam.getField204());
			System.out.println(outparam.getField203() + " 203 hai yeh customer Creation time");
			System.out.println(outparam.getField202());
			System.out.println("here ends");
			
			
			return prepareResponseRecievedFromOmniForCollection(outparam);
			/*
			 * retBean = prepareResponseRecievedFromOmni(outparam); retBean = new
			 * OmniSoapResultBean();
			 */
			
			/*
			 * retBean.setMCustRefNo(dailyLoanCollectedEntity.getMrefno());
			 * retBean.setCreatedBy(dailyLoanCollectedEntity.getMcreatedby());
			 * retBean.setTRefno(dailyLoanCollectedEntity.getTrefno());
			 */
			
			
			
			/*
			 * if (!outparam.getField201().equals("0")) {
			 * System.out.println("Dayta of in patrams 1"+outparam.toString());
			 * retBean.setStatus(1); //retBean.setMCustNo(0);
			 * retBean.setError(outparam.getField203()); return retBean; }
			 * System.out.println("Dayta of in patrams 2 "+outparam.toString());
			 * if(outparam!=null && outparam.getField1() !=null) { retBean.setStatus(0);
			 * //retBean.setMCustNo(Integer.parseInt(outparam.getField1())); } else {
			 * retBean.setStatus(1); //retBean.setMCustNo(0);
			 * retBean.setError(outparam.getField203()); }
			 * 
			 * return retBean;
			 */
		} catch (RemoteException e) {

		}

		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		//DailyLoanCollectedEntity customerLoanEntityBean = (DailyLoanCollectedEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
				
		StringBuilder temp=new StringBuilder();
		Field f1=null;
		int mode = 2;
		int sdCashFlag= 2;
		SystemParameterEntity sysBean = systemParamRepo.findByCode("SDFEESINCASH");
		if(sysBean!=null&&sysBean.getMcodevalue().equals(Constants.YES)) {
			sdCashFlag=1;
			
		}
		for(int inparamsCount =0;inparamsCount<this.beanList.size();inparamsCount++) {
			
			
			//changing dates to omni format
			String lastSyncDate = Utility.unFormateDt(this.beanList.get(inparamsCount).getMlastsynsdate());
			String mcreatedDate = Utility.unFormateDt(this.beanList.get(inparamsCount).getMcreateddt());
			String effdate = Utility.unFormateDt(this.beanList.get(inparamsCount).getMefffromdate());
			String disbDate = Utility.unFormateDt(this.beanList.get(inparamsCount).getMdisburseddate());
			
			
			//changing prcdacctid
			
			String mprdcd  = this.beanList.get(inparamsCount).getMprdacctid().substring(0, 8);
			String mcustno = this.beanList.get(inparamsCount).getMprdacctid().substring(8, 16);
			String acctid  = this.beanList.get(inparamsCount).getMprdacctid().substring(16, 24);			
			String mprcdacctid = mcustno+"/"+mprdcd+"/"+acctid+"/0";
			System.out.println("contractid--" + mprcdacctid);
			
			//Change checkboex to YN
			
			double collectionCharge = this.beanList.get(inparamsCount).getMchargesamt0()+
					 this.beanList.get(inparamsCount).getMchargesamt1()+this.beanList.get(inparamsCount).getMchargesamt2()+
					 this.beanList.get(inparamsCount).getMchargesamt3()+this.beanList.get(inparamsCount).getMchargesamt4()+
					 this.beanList.get(inparamsCount).getMchargesamt5()+this.beanList.get(inparamsCount).getMchargesamt6()+
					 this.beanList.get(inparamsCount).getMchargesamt7()+this.beanList.get(inparamsCount).getMchargesamt8()+
					 this.beanList.get(inparamsCount).getMchargesamt9();	
			
		
			
			temp =new StringBuilder();
			temp.append(this.beanList.get(inparamsCount).getMlbrcode()).append("~").append(this.beanList.get(inparamsCount).getMleadsid()).append("~");
			temp.append(effdate).append("~").append(mprcdacctid).append("~");
			//temp.append(mcustno+"/"+mprdcd+"/"+mprcdacctid).append("~").append(this.beanList.get(inparamsCount).getMcenterid()).append("~");
			temp.append(this.beanList.get(inparamsCount).getMdisbamount()).append("~").append(this.beanList.get(inparamsCount).getMsdamt()).append("~");
			temp.append(collectionCharge).append("~").append(this.beanList.get(inparamsCount).getMrebateamt()).append("~");
			temp.append(mode).append("~").append(sdCashFlag).append("~");
			temp.append(mode).append("~").append(mode).append("~");
			temp.append(disbDate).append("~").append(this.beanList.get(inparamsCount).getMreason()).append("~");
			temp.append(this.beanList.get(inparamsCount).getMremarks()).append("~").append(this.beanList.get(inparamsCount).getMcheckbiometric());
			temp.append("~").append(this.beanList.get(inparamsCount).getMlastupdateby());
			
			
			
			try {
				int parmsCount =inparamsCount+1;
				f1= TMsgInParam.class.getDeclaredField("field" + ""+parmsCount);
				f1.setAccessible(true);
				f1.set(inParam, temp.toString());
			} catch (NoSuchFieldException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 

			
			
			
		}
		
		
		
		
		inParam.setField202("99");	
		//inParam.setField204(Constants.Field204);
		inParam.setField204(Constants.Field204);
		return inParam;
	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	public List<DisbursedListEntity> prepareResponseRecievedFromOmniForCollection(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<DisbursedListEntity> retBeanList = new ArrayList<DisbursedListEntity>();
		System.out.println(" bean response here is "+bean.toString());
		
		for(int outParams =0;outParams<this.beanList.size();outParams++) {
			DisbursedListEntity disbBean = new DisbursedListEntity();
			try {
				
				int outParamsLength =outParams+1;
				Field f1= TMsgOutParam.class.getDeclaredField("field" + ""+outParamsLength);
				f1.setAccessible(true);
				String str = f1.get(bean).toString();
				String[] arrOfStr = str.split("~"); 
				  
		      f1=null;
		        	for(int arrOfStringSingles =0;arrOfStringSingles<=arrOfStr.length;arrOfStringSingles++) {
		        		disbBean.setMleadsid(arrOfStr[1]);
		        		if(Integer.valueOf(arrOfStr[2])==0) {
		        			disbBean.setMissynctocoresys(1);	
		        		}
		        		else {
		        			disbBean.setMissynctocoresys(2);
		        		}
		        		
		        		try {
		        			disbBean.setMerrormessage(arrOfStr[3]);
				        	disbBean.setMentrydate(Utility.changeToDt(arrOfStr[4]));
				        	disbBean.setMbatchcd(arrOfStr[5]);
				        	disbBean.setMsetno(Integer.valueOf(arrOfStr[6]));
				        	disbBean.setMcurcd(arrOfStr[7]);
				        	
				        	if(isOnline==false) {
				        		disbServiceImpl.updateStatus(disbBean,true);	
				        		
				        	}
				        	
		        			
		        		}catch(Exception e) {
		        			e.printStackTrace();
		        			if(isOnline==false) {
				        		disbServiceImpl.updateStatus(disbBean);	
				        		
				        	}
		        		}
		        		
		        	
		           // System.out.println(a); 
		        }
		        retBeanList.add(disbBean);
				
			} catch (NoSuchFieldException | SecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		// etc.
		

		
		return retBeanList;
	}


}
