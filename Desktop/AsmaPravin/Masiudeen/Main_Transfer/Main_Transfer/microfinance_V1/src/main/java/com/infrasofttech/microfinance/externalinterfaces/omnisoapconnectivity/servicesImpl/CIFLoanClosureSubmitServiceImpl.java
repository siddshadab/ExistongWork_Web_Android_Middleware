package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFLoanClosureHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFLoanClosureService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;


@Service
@Transactional
public class CIFLoanClosureSubmitServiceImpl implements CIFLoanClosureService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CIFLoanClosureHolderBean cifLoanClosureHolderBean = (CIFLoanClosureHolderBean) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		System.out.println("prdaccid--" + cifLoanClosureHolderBean.getMprdacctid());
		if(cifLoanClosureHolderBean.getMprdacctid() != null)  // PrdAccId
		{
			String mprdcd  = cifLoanClosureHolderBean.getMprdacctid().substring(0, 8);
			String mcustno = cifLoanClosureHolderBean.getMprdacctid().substring(9, 16);
			String acctid  = cifLoanClosureHolderBean.getMprdacctid().substring(17, 24);			
			String mprcdacctid = mcustno+"~"+mprdcd+"~"+acctid+"~";
			System.out.println("contractid--" + mprcdacctid);
			inParam.setField1(mprcdacctid);
		}
		
		if( cifLoanClosureHolderBean.getMentrydate() != null)     // EntryDate
			inParam.setField2(cifLoanClosureHolderBean.getMentrydate());	
		
		if( cifLoanClosureHolderBean.getMstartdt() != null)     // Start Date
			inParam.setField3(cifLoanClosureHolderBean.getMstartdt());
		
		if( cifLoanClosureHolderBean.getMinterestaccruedtilldt() != null)     // 
			inParam.setField4(cifLoanClosureHolderBean.getMinterestaccruedtilldt());

		if( cifLoanClosureHolderBean.getMclosurecharges() != null)     // 
			inParam.setField5(cifLoanClosureHolderBean.getMclosurecharges());
		
		if( cifLoanClosureHolderBean.getMclosureamtasondate() != null)     // 
			inParam.setField6(cifLoanClosureHolderBean.getMclosureamtasondate());
		
		//wave of amt 
		if( cifLoanClosureHolderBean.getMwaiveoffamt() != null)     // 
			inParam.setField7(cifLoanClosureHolderBean.getMwaiveoffamt());
		
		if( cifLoanClosureHolderBean.getMamttobepaidforclosure() != null)     // Closure Amount Paid
			inParam.setField8(cifLoanClosureHolderBean.getMamttobepaidforclosure());
		
		if( cifLoanClosureHolderBean.getMprincipalos() != null)     // 
			inParam.setField9(cifLoanClosureHolderBean.getMprincipalos());
		
		if( cifLoanClosureHolderBean.getMinterestos() != null)     // 
			inParam.setField10(cifLoanClosureHolderBean.getMinterestos());
		
		if( cifLoanClosureHolderBean.getMpenalos() != null)     // 
			inParam.setField11(cifLoanClosureHolderBean.getMpenalos());
		
		if( cifLoanClosureHolderBean.getMotherchargesos() != null)     // 
			inParam.setField12(cifLoanClosureHolderBean.getMotherchargesos());
		
		if( cifLoanClosureHolderBean.getMprincipalpaid() != null)     // 
			inParam.setField13(cifLoanClosureHolderBean.getMprincipalpaid());
		
		if( cifLoanClosureHolderBean.getMinterestpaid() != null)     // 
			inParam.setField14(cifLoanClosureHolderBean.getMinterestpaid());
		
		if( cifLoanClosureHolderBean.getMpenalpaid() != null)     // 
			inParam.setField15(cifLoanClosureHolderBean.getMpenalpaid());
		
		if( cifLoanClosureHolderBean.getMotherchargespaid() != null)     // 
			inParam.setField16(cifLoanClosureHolderBean.getMotherchargespaid());
		
		if( cifLoanClosureHolderBean.getMnoofinslpaid() != null)     // 
			inParam.setField17(cifLoanClosureHolderBean.getMnoofinslpaid());
		
		if( cifLoanClosureHolderBean.getMnoofdefaults() != null)     // 
			inParam.setField18(cifLoanClosureHolderBean.getMnoofdefaults());
		
		if( cifLoanClosureHolderBean.getMprincipalosdue() != null)     // 
			inParam.setField19(cifLoanClosureHolderBean.getMprincipalosdue());
		
		if( cifLoanClosureHolderBean.getMinterestosdue() != null)     // 
			inParam.setField20(cifLoanClosureHolderBean.getMinterestosdue());
		
		if( cifLoanClosureHolderBean.getMpenalosdue() != null)     // 
			inParam.setField21(cifLoanClosureHolderBean.getMpenalosdue());
		
		if( cifLoanClosureHolderBean.getMotherchargesosdue() != null)     // 
			inParam.setField22(cifLoanClosureHolderBean.getMotherchargesosdue());
		
		if( cifLoanClosureHolderBean.getMremark() != null)     // Remark
			inParam.setField23(cifLoanClosureHolderBean.getMremark());	
		
		if( cifLoanClosureHolderBean.getMpaymntmode() != 0)     // Payment Mode
			inParam.setField25(String.valueOf(cifLoanClosureHolderBean.getMpaymntmode()));	
		
		if( cifLoanClosureHolderBean.getMlbrcode() != 0)     // Branch Code
			inParam.setField38(String.valueOf(cifLoanClosureHolderBean.getMlbrcode()));
		
		inParam.setField39(String.valueOf(cifLoanClosureHolderBean.getMcreatedby()));
		
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;

	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	List<CIFLoanClosureHolderBean> beanList;

	public List<CIFLoanClosureHolderBean> omniSoapServicesCifPostLoanClosureVoucher(CIFLoanClosureHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 45200, inParams);
			
			return prepareResponseRecievedFromOmniForLoanDetail(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<CIFLoanClosureHolderBean> prepareResponseRecievedFromOmniForLoanDetail(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CIFLoanClosureHolderBean> retBeanList = new ArrayList<CIFLoanClosureHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		CIFLoanClosureHolderBean cifLoanClosureHolderBean;
		cifLoanClosureHolderBean = new CIFLoanClosureHolderBean();	
		
		try
		{
			if( bean.getField1() !=null&& !("").equals(bean.getField1())) {
				cifLoanClosureHolderBean.setMentrydate(bean.getField1());
			}
			if( bean.getField2() !=null&&! ("").equals(bean.getField2())) {
				cifLoanClosureHolderBean.setMbatchcd(bean.getField2());
			}
			if( bean.getField3() !=null&& !("").equals(bean.getField3())) {
				cifLoanClosureHolderBean.setMsetno(Integer.valueOf(bean.getField3()));
			}
			if( bean.getField4() !=null&& !("").equals(bean.getField4())) {
				cifLoanClosureHolderBean.setMamt(Double.valueOf(bean.getField4()));
			}
			if( bean.getField5() !=null&& !("").equals(bean.getField5())) {
				cifLoanClosureHolderBean.setMscrollno(Integer.valueOf(bean.getField5()));
			}
			if( bean.getField6() !=null&&! ("").equals(bean.getField6())) {
				cifLoanClosureHolderBean.setMcurcd(bean.getField6());
			}
			if(bean!=null && bean.getField203() !=null) {
				cifLoanClosureHolderBean.setMomnimsg(bean.getField203());
			}			
				
			retBeanList.add(cifLoanClosureHolderBean);			
			return retBeanList;
		}
		catch (SecurityException e){
		}
		return null;
	}
	
}
