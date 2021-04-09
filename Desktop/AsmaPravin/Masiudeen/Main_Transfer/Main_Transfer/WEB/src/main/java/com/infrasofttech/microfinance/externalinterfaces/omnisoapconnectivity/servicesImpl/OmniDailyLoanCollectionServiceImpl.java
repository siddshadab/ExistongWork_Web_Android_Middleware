package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectedEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniCustomerLoanBasicDetailsService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;


@Service
public class OmniDailyLoanCollectionServiceImpl implements OmniCustomerLoanBasicDetailsService {

	//DailyLoanCollectedEntity dailyLoanCollectedEntity = new DailyLoanCollectedEntity();
	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		DailyLoanCollectedEntity dailyLoanCollectedEntity = (DailyLoanCollectedEntity) bean;
		
		
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(dailyLoanCollectedEntity);
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910901, inParams);
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
			retBean.setMCustRefNo(dailyLoanCollectedEntity.getMrefno());
			retBean.setCreatedBy(dailyLoanCollectedEntity.getMcreatedby());
			retBean.setTRefno(dailyLoanCollectedEntity.getTrefno());
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

	List<DailyLoanCollectedEntity> beanList ;
	
	public List<DailyLoanCollectedEntity> omniSoapServicesDailyCollectedList(List<DailyLoanCollectedEntity> beanList) {
		//DailyLoanCollectedEntity dailyLoanCollectedEntity = (DailyLoanCollectedEntity) bean;
		//this.beanList = new ArrayList<DailyLoanCollectedEntity>();
		this.beanList= beanList;
		
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
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910911, inParams);
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
		for(int inparamsCount =0;inparamsCount<this.beanList.size();inparamsCount++) {
			
			
			//changing dates to omni format
			String lastSyncDate = Utility.unFormateDt(this.beanList.get(inparamsCount).getMlastsynsdate());
			String mcreatedDate = Utility.unFormateDt(this.beanList.get(inparamsCount).getMcreateddt());
			String midealBalDate = Utility.unFormateDt(this.beanList.get(inparamsCount).getMidealbaldate());
			String malmeffdate = Utility.unFormateDt(this.beanList.get(inparamsCount).getMalmeffdate());
			
			//changing prcdacctid
			
			String mprdcd = this.beanList.get(inparamsCount).getMprdacctid().substring(0, 8);
			String mcustno =  this.beanList.get(inparamsCount).getMprdacctid().substring(9, 16);
			String mprcdacctid =  this.beanList.get(inparamsCount).getMprdacctid().substring(17, 24);
			String mremarks = this.beanList.get(inparamsCount).getMremarks();
			
			//Change checkboex to YN
			
			
			 String madjfrmsd = Utility.chngToYN(String.valueOf(this.beanList.get(inparamsCount).getMadjfrmsd()));
			 String madjfrmexcss = Utility.chngToYN(String.valueOf(this.beanList.get(inparamsCount).getMadjfrmexcss()));			 
			String mpaidByGrp = Utility.chngToYN(String.valueOf(this.beanList.get(inparamsCount).getMpaidbygrp()));
			String mattndnc = Utility.chngToYN(String.valueOf(this.beanList.get(inparamsCount).getMattndnc()));
			
			
			
			temp =new StringBuilder();
			temp.append(this.beanList.get(inparamsCount).getMrefno()).append("~").append(this.beanList.get(inparamsCount).getMlbrcode()).append("~");
			temp.append(mcustno+"/"+mprdcd+"/"+mprcdacctid).append("~").append(this.beanList.get(inparamsCount).getMcenterid()).append("~");
			temp.append(this.beanList.get(inparamsCount).getMgroupid()).append("~").append(this.beanList.get(inparamsCount).getMfocode()).append("~");
			temp.append(malmeffdate).append("~").append(madjfrmsd).append("~");
			temp.append(madjfrmexcss).append("~").append(mpaidByGrp).append("~");
			temp.append(mattndnc).append("~").append(this.beanList.get(inparamsCount).getMcustno()).append("~");
			temp.append(this.beanList.get(inparamsCount).getMcollamt()).append("~").append(mcreatedDate).append("~");
			temp.append(lastSyncDate).append("~").append("30").append("~");
			temp.append(midealBalDate).append("~");
			temp.append(mremarks);
			//System.out.println("Net is slow here in euthopia "+temp.toString()+"  inparamsCount "+inparamsCount);
			
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
	
	
	public List<DailyLoanCollectedEntity> prepareResponseRecievedFromOmniForCollection(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<DailyLoanCollectedEntity> retBeanList = new ArrayList<DailyLoanCollectedEntity>();
		System.out.println(" bean response here is "+bean.toString());
		/*
		 * Class<?> clz = TMsgOutParam.class; Method[] methods =
		 * clz.getDeclaredMethods();
		 */
		
		for(int outParams =0;outParams<this.beanList.size();outParams++) {
			DailyLoanCollectedEntity dailyCollBean = new DailyLoanCollectedEntity();
			try {
				
				int outParamsLength =outParams+1;
				Field f1= TMsgOutParam.class.getDeclaredField("field" + ""+outParamsLength);
				f1.setAccessible(true);
				String str = f1.get(bean).toString();
				String[] arrOfStr = str.split("/"); 
				  
		      f1=null;
		        	for(int arrOfStringSingles =0;arrOfStringSingles<=arrOfStr.length;arrOfStringSingles++) {
		        	dailyCollBean.setMrefno(Integer.valueOf(arrOfStr[0]));
		        	dailyCollBean.setMissynctocoresys(Integer.valueOf(arrOfStr[1].toString())==1?0:1);
		        	dailyCollBean.setMerrormessage(arrOfStr[2]);
		        	
		           // System.out.println(a); 
		        }
		        retBeanList.add(dailyCollBean);
				
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
