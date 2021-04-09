package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.DisbursmentListEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFLoanClosureHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;

@Service
@Transactional
public class CIFDisbursmentServiceImpl {

	
	
	public DisbursmentListEntity getDisbursmentDetails(CIFHolderBean cifBean) {
		
		TMsgInParam inParams = new TMsgInParam();
		
		
		inParams.setField1(String.valueOf(cifBean.getMlbrcode()));
		inParams.setField2(String.valueOf(cifBean.getMprdacctid()));
		inParams.setField202("99");
		inParams.setField204(Constants.Field204);
		
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 910921, inParams);
			
			System.out.println(outparam);
			if(outparam!=null&&outparam.getField201()!=null) {
				if("0".equals(outparam.getField201().trim())) {
					
					return prepareResponseRecievedFromOmni(outparam);
					
				}
				else {
					DisbursmentListEntity disbListEntity = new DisbursmentListEntity();
					disbListEntity.setMissynctocoresys(2);
					disbListEntity.setMerrormessage(outparam.getField102());
					
				}
				
				
			}else {
				return null;
			}
			
			
			
			//return prepareResponseRecievedFromOmniForCifCustAuth(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public DisbursmentListEntity prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CIFLoanClosureHolderBean> retBeanList = new ArrayList<CIFLoanClosureHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		DisbursmentListEntity disbListEntity = new DisbursmentListEntity();
		try {
			disbListEntity.setMlbrcode(Integer.parseInt(bean.getField1()));
			disbListEntity.setMprdacctid(bean.getField2());
			disbListEntity.setMefffromdate(Utility.changeToDt(bean.getField3()));
			disbListEntity.setMdisburseddate(Utility.changeToDt(bean.getField4()));
			disbListEntity.setMinstlstartdate(Utility.changeToDt(bean.getField5()));
			disbListEntity.setMinstlamt(Double.valueOf(bean.getField6()));
			disbListEntity.setMinstlintcomp(Double.valueOf(bean.getField7()));
			disbListEntity.setMleadsid(bean.getField8());
			disbListEntity.setMlongname(bean.getField9());
			disbListEntity.setMcustno(Integer.valueOf(bean.getField10()));
			disbListEntity.setMappliedasindvyn(bean.getField12());
			disbListEntity.setMnewtopupflag(Integer.valueOf(bean.getField12()));
			disbListEntity.setMsancdate(Utility.changeToDt(bean.getField13()));
			disbListEntity.setMdisbamount(Double.valueOf(bean.getField14()));
			disbListEntity.setMsdamt(Double.valueOf(bean.getField15()));
			disbListEntity.setMrebateamt(Double.valueOf(bean.getField16()));
			disbListEntity.setMchargesamt(Double.valueOf(bean.getField17()));
			disbListEntity.setMdisbursedamtcoltd(Double.valueOf(bean.getField18()));
			disbListEntity.setMsdamtcoltd(Double.valueOf(bean.getField19()));
			disbListEntity.setMrebateamtcoltd(Integer.valueOf(bean.getField20()));
			disbListEntity.setMchargesamtcoltd(Integer.valueOf(bean.getField21()));
			disbListEntity.setMdisbursedamtflag(Integer.valueOf(bean.getField22()));
			disbListEntity.setMsdamtflag(Integer.valueOf(bean.getField23()));
			disbListEntity.setMrebateamtflag(Integer.valueOf(bean.getField24()));
			disbListEntity.setMchargesamtflag(Integer.valueOf(bean.getField25()));
			disbListEntity.setMreason(bean.getField26());
			disbListEntity.setMsetno(Integer.valueOf(bean.getField27()));
			disbListEntity.setMscrollno(Integer.valueOf(bean.getField28()));
			disbListEntity.setMentrydate(Utility.changeToDt(bean.getField29()));
			disbListEntity.setMbatchcd(bean.getField30());
			disbListEntity.setMmainscrollno(Integer.valueOf(bean.getField31()));
			 disbListEntity.setMbatchnumber(bean.getField32());
			  disbListEntity.setMnarration(bean.getField33()); 
			  disbListEntity.setMcenterid(Integer.valueOf(bean.getField34())); 
			  disbListEntity.setMcrs(bean.getField35());
			  disbListEntity.setMsuspbatchcd(bean.getField36());
			  disbListEntity.setMsuspsetno(Integer.valueOf(bean.getField37()));
			  disbListEntity.setMsuspscrollno(Integer.valueOf(bean.getField38()));
			  disbListEntity.setMsspmainscrollno(Integer.valueOf(bean.getField39()));
			  disbListEntity.setMpartcashamount(Double.valueOf(bean.getField40())); 
			  disbListEntity.setMpartcashbatchcd(bean.getField41()); 
			  disbListEntity.setMpartcashsetno(Integer.valueOf(bean.getField42())); 
			  disbListEntity.setMpartcashscrollno(Integer.valueOf(bean.getField43()));
			  disbListEntity.setMpartcashmainscrollno(Integer.valueOf(bean.getField44()));
			  disbListEntity.setMneftclsrbatchcd(bean.getField45()); 
			  disbListEntity.setMneftclsrsetno(Integer.valueOf(bean.getField46()));
			  disbListEntity.setMneftclsrscrollno(Integer.valueOf(bean.getField47()));
			  disbListEntity.setMneftclsrmainscrollno(Integer.valueOf(bean.getField48())); 
			  disbListEntity.setMcreateddt(Utility.changeToDt(bean.getField49())); 
			  disbListEntity.setMcreatedby(bean.getField50());
				disbListEntity.setMdisbamount(Double.valueOf(bean.getField51())); 
				disbListEntity.setMcustno(Integer.valueOf(bean.getField52()));
				disbListEntity.setTrefno(Integer.valueOf(bean.getField53()));
				disbListEntity.setMchargesamt0(Double.valueOf(bean.getField54())); 
				disbListEntity.setMchargesamt1(Double.valueOf(bean.getField55())); 
				disbListEntity.setMchargesamt2(Double.valueOf(bean.getField56()));
				 disbListEntity.setMchargesamt3(Double.valueOf(bean.getField57()));
				 disbListEntity.setMchargesamt4(Double.valueOf(bean.getField57()));
				 disbListEntity.setMchargesamt5(Double.valueOf(bean.getField58()));
				 disbListEntity.setMchargesamt6(Double.valueOf(bean.getField59()));
				 disbListEntity.setMchargesamt7(Double.valueOf(bean.getField60()));
				 disbListEntity.setMchargesamt8(Double.valueOf(bean.getField61()));
				 disbListEntity.setMchargesamt9(Double.valueOf(bean.getField62()));
				 disbListEntity.setMchargescollectiontype(Integer.valueOf(bean.getField63()));
				 disbListEntity.setMsdcollectiontype(Integer.valueOf(bean.getField64()));
				 disbListEntity.setMthirdpartyamount(Double.valueOf(bean.getField65()));
				 disbListEntity.setMissynctocoresys(1);
				 
				
			  
			
			
			
		}catch(Exception e) {
			System.out.println("error in CIF DisbursmentServiceImpl cath");
			disbListEntity = new DisbursmentListEntity();
			disbListEntity.setMissynctocoresys(2);
			disbListEntity.setMerrormessage("Account Not Found");
		}
			
		
		 return disbListEntity;
	}

}
