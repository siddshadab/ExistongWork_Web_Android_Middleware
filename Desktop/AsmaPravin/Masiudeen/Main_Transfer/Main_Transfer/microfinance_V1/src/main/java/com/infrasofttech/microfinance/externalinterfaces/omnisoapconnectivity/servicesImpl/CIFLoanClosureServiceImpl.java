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
public class CIFLoanClosureServiceImpl implements CIFLoanClosureService {

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
		
		if( cifLoanClosureHolderBean.getMentrydate() != null)     // EntryDate+Flag
			inParam.setField2(String.valueOf(cifLoanClosureHolderBean.getMentrydate())+"~C");	
		
		if( cifLoanClosureHolderBean.getMlbrcode() != 0)
			inParam.setField3(String.valueOf(cifLoanClosureHolderBean.getMlbrcode()));
		
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

	public List<CIFLoanClosureHolderBean> omniSoapServicesCifLoanDetailList(CIFLoanClosureHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "6", 45200, inParams);
			
			
			
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
			
			if(bean!=null && bean.getField1() !=null) {
				cifLoanClosureHolderBean.setMloandetailsgrid(bean.getField1()); }
			if(bean!=null && bean.getField2() !=null) {
				cifLoanClosureHolderBean.setMapplicationdt(bean.getField2()); }
			if(bean!=null && bean.getField3() !=null) {
				cifLoanClosureHolderBean.setMappliedamt(bean.getField3()); }
			if(bean!=null && bean.getField4() !=null) {
				cifLoanClosureHolderBean.setMapproveddt(bean.getField4()); }
			if(bean!=null && bean.getField5() !=null) {
				cifLoanClosureHolderBean.setMapprovedamt(bean.getField5()); }
			if(bean!=null && bean.getField6() !=null) {
				cifLoanClosureHolderBean.setMstartdt(bean.getField6()); }
			if(bean!=null && bean.getField7() !=null) {
				cifLoanClosureHolderBean.setMdisbursementdt(bean.getField7()); }
			if(bean!=null && bean.getField8() !=null) {
				cifLoanClosureHolderBean.setMdisbursementamt(bean.getField8()); }
			if(bean!=null && bean.getField9() !=null) {
				cifLoanClosureHolderBean.setMinstallmentstartdt(bean.getField9()); }
			if(bean!=null && bean.getField10() !=null) {
				cifLoanClosureHolderBean.setMinstallmentamt(bean.getField10()); }
			if(bean!=null && bean.getField11() !=null) {
				cifLoanClosureHolderBean.setMinstallmentfrequency(bean.getField11()); }
			if(bean!=null && bean.getField12() !=null) {
				cifLoanClosureHolderBean.setMnoofinstallments(bean.getField12()); }
			if(bean!=null && bean.getField13() !=null) {
				cifLoanClosureHolderBean.setMrateofinterest(bean.getField13()); }
			if(bean!=null && bean.getField14() !=null) {
				cifLoanClosureHolderBean.setMenddt(bean.getField14()); }
			if(bean!=null && bean.getField15() !=null) {
				cifLoanClosureHolderBean.setMinsurancepremiumamt(bean.getField15()); }
			if(bean!=null && bean.getField16() !=null) {
				cifLoanClosureHolderBean.setMsecuritydetailsgrid(bean.getField16()); }
			if(bean!=null && bean.getField17() !=null) {
				cifLoanClosureHolderBean.setMsecuritydepositdt(bean.getField17()); }
			if(bean!=null && bean.getField18() !=null) {
				cifLoanClosureHolderBean.setMamtondepositcreation(bean.getField18()); }
			if(bean!=null && bean.getField19() !=null) {
				cifLoanClosureHolderBean.setMcurrentbal(bean.getField19()); }
			if(bean!=null && bean.getField20() !=null) {
				cifLoanClosureHolderBean.setMexcessbal(bean.getField20()); }
			if(bean!=null && bean.getField21() !=null) {
				cifLoanClosureHolderBean.setMclosuredetailsgrid(bean.getField21()); }
			if(bean!=null && bean.getField22() !=null) {
				cifLoanClosureHolderBean.setMinterestaccruedtilldt(bean.getField22()); }
			if(bean!=null && bean.getField23() !=null) {
				cifLoanClosureHolderBean.setMclosurecharges(bean.getField23()); }
			if(bean!=null && bean.getField24() !=null) {
				cifLoanClosureHolderBean.setMclosureamtasondate(bean.getField24()); }
			if(bean!=null && bean.getField25() !=null) {
				cifLoanClosureHolderBean.setMwaiveoffamt(bean.getField25()); }
			if(bean!=null && bean.getField26() !=null) {
				cifLoanClosureHolderBean.setMamttobepaidforclosure(bean.getField26()); }
			// 27 is |END|
			if(bean!=null && bean.getField28() !=null) {
				cifLoanClosureHolderBean.setMtotaloutstandinggrid(bean.getField28()); }
			if(bean!=null && bean.getField29() !=null) {
				cifLoanClosureHolderBean.setMprincipalos(bean.getField29()); }
			if(bean!=null && bean.getField30() !=null) {
				cifLoanClosureHolderBean.setMinterestos(bean.getField30()); }
			if(bean!=null && bean.getField31() !=null) {
				cifLoanClosureHolderBean.setMpenalos(bean.getField31()); }
			if(bean!=null && bean.getField32() !=null) {
				cifLoanClosureHolderBean.setMotherchargesos(bean.getField32()); }
			if(bean!=null && bean.getField33() !=null) {
				cifLoanClosureHolderBean.setMtotaloutstanding(bean.getField33()); }
			if(bean!=null && bean.getField34() !=null) {
				cifLoanClosureHolderBean.setMtotalpaymentgrid(bean.getField34()); }
			if(bean!=null && bean.getField35() !=null) {
				cifLoanClosureHolderBean.setMprincipalpaid(bean.getField35()); }
			if(bean!=null && bean.getField36() !=null) {
				cifLoanClosureHolderBean.setMinterestpaid(bean.getField36()); }
			if(bean!=null && bean.getField37() !=null) {
				cifLoanClosureHolderBean.setMpenalpaid(bean.getField37()); }
			if(bean!=null && bean.getField38() !=null) {
				cifLoanClosureHolderBean.setMotherchargespaid(bean.getField38()); }
			if(bean!=null && bean.getField39() !=null) {
				cifLoanClosureHolderBean.setMnoofinslpaid(bean.getField39()); }
			if(bean!=null && bean.getField40() !=null) {
				cifLoanClosureHolderBean.setMnoofdefaults(bean.getField40()); }
			if(bean!=null && bean.getField41() !=null) {
				cifLoanClosureHolderBean.setMtotalpaid(bean.getField41()); }
			if(bean!=null && bean.getField42() !=null) {
				cifLoanClosureHolderBean.setMduebutnotpaidgrid(bean.getField42()); }
			if(bean!=null && bean.getField43() !=null) {
				cifLoanClosureHolderBean.setMprincipalosdue(bean.getField43()); }
			if(bean!=null && bean.getField44() !=null) {
				cifLoanClosureHolderBean.setMinterestosdue(bean.getField44()); }
			if(bean!=null && bean.getField45() !=null) {
				cifLoanClosureHolderBean.setMpenalosdue(bean.getField45()); }
			if(bean!=null && bean.getField46() !=null) {
				cifLoanClosureHolderBean.setMotherchargesosdue(bean.getField46()); }
			if(bean!=null && bean.getField47() !=null) {
				cifLoanClosureHolderBean.setMtotaldue(bean.getField47()); }
			if(bean!=null && bean.getField203() !=null ) {
				cifLoanClosureHolderBean.setMerror(bean.getField203());
			}
				
			retBeanList.add(cifLoanClosureHolderBean);			
			return retBeanList;
		}
		catch (SecurityException e){
		}
		return null;
	}
	
}
