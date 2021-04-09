package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.GuarantorEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniGuarantorDetailService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;


@Service
public class OmniGuarantorDetailServiceImpl implements OmniGuarantorDetailService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		return null;
	}

	int mLoanMrefno=0;
	List<GuarantorEntity> beanList ;
	
	public OmniSoapResultBean omniSoapServicesGuarantorList(List<GuarantorEntity> beanList) {
		this.beanList= beanList;
		
		System.out.println("this.beanList " +this.beanList.size());
		TMsgInParam inParams = prepareRequestToOmni(null);
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 45244, inParams);
			System.out.println("here starts");
			System.out.println(outparam.getField1());
			System.out.println(outparam.getField2());
			System.out.println(outparam.getField101());
			System.out.println(outparam.getField102());
			System.out.println(outparam.getField103());
			System.out.println(outparam.getField104());
			System.out.println(outparam.getField201());
			System.out.println(outparam.getField204());
			System.out.println(outparam.getField203());
			System.out.println(outparam.getField202());
			System.out.println("here ends");
			
			retBean = prepareResponseRecievedFromOmni(outparam);
			retBean = new OmniSoapResultBean();	
			retBean.setMLoanRefNo(mLoanMrefno);
			if (!outparam.getField201().equals("0")) {
				retBean.setStatus(1);
				retBean.setError(outparam.getField203());
				return retBean;
			}
			if(outparam!=null && outparam.getField1() !=null) {
				retBean.setStatus(0);
				//retBean.setMRefno(beanList.getMrefno());
			} else {
				retBean.setStatus(1);
				retBean.setError(outparam.getField203());
			}
			return retBean;
			
		} catch (RemoteException e) {

		}

		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		TMsgInParam inParam = new TMsgInParam();
		
		String temp = "";		
		Field f1=null;
		int inparamsCount = 0;
		
		if (beanList.get(inparamsCount).getMleadsid() != "") {
			inParam.setField1(String.valueOf(beanList.get(inparamsCount).getMleadsid()));
		}
		inParam.setField2("|END1|");

		try {
		int	fieldCount =3;
		if(beanList!=null && beanList.size()>0){
			this.mLoanMrefno = this.beanList.get(0).getMloanmrefno(); 

	
			for( inparamsCount =0;inparamsCount<this.beanList.size();inparamsCount++) {	
				
				String isCustYn="N";
				if(beanList.get(inparamsCount).getMcustno()>0) {
					isCustYn="Y";
				}
				
				
				temp="";	
				
				temp=temp+(beanList.get(inparamsCount).getMapplicanttype())+Constants.TILDA+isCustYn+Constants.TILDA+
						beanList.get(inparamsCount).getMcustno()+Constants.TILDA+beanList.get(inparamsCount).getMnameofguar()+Constants.TILDA+
						beanList.get(inparamsCount).getMgender()+Constants.TILDA+beanList.get(inparamsCount).getMrelationwithcust();
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, temp);
				fieldCount++;
			}
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END2|");
			fieldCount++;
		}else{
			f1= TMsgInParam.class.getDeclaredField("field" + ""+inparamsCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END2|");
			fieldCount++;
		}
		
		if(beanList!=null && beanList.size()>0){

			for( inparamsCount =0;inparamsCount<this.beanList.size();inparamsCount++) {	
				temp="";	
				
				temp=temp+(beanList.get(inparamsCount).getMage())+Constants.TILDA+beanList.get(inparamsCount).getMphone()+Constants.TILDA+
						beanList.get(inparamsCount).getMmobile()+Constants.TILDA+beanList.get(inparamsCount).getMaddress()+Constants.TILDA+
						beanList.get(inparamsCount).getMmonthlyincome()+Constants.TILDA+Utility.unFormateDt(beanList.get(inparamsCount).getMdob());
				
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, temp);
				fieldCount++;
			}
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END3|");
			fieldCount++;
		}else{
			f1= TMsgInParam.class.getDeclaredField("field" + ""+inparamsCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END3|");
			fieldCount++;
		}
		
		if(beanList!=null && beanList.size()>0){

			for( inparamsCount =0;inparamsCount<this.beanList.size();inparamsCount++) {	
				temp="";	
				
				temp=temp+(beanList.get(inparamsCount).getMhousetype())+Constants.TILDA+beanList.get(inparamsCount).getMoccupationtype()+Constants.TILDA+
						beanList.get(inparamsCount).getMmainoccupation()+Constants.TILDA+beanList.get(inparamsCount).getMworkexpinyrs()+Constants.TILDA+
						beanList.get(inparamsCount).getMworkingaddress()+Constants.TILDA+beanList.get(inparamsCount).getMworkphoneno();
				
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, temp);
				fieldCount++;
			}
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END4|");
			fieldCount++;
		}else{
			f1= TMsgInParam.class.getDeclaredField("field" + ""+inparamsCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END4|");
			fieldCount++;
		}
		
		if(beanList!=null && beanList.size()>0){

			for( inparamsCount =0;inparamsCount<this.beanList.size();inparamsCount++) {	
				temp="";	
				
				temp=temp+(beanList.get(inparamsCount).getMincomeothsources())+Constants.TILDA+beanList.get(inparamsCount).getMtotalincome()+Constants.TILDA+
						beanList.get(inparamsCount).getMrelationsince()+Constants.TILDA+beanList.get(inparamsCount).getMmothermaidenname()+Constants.TILDA+
						beanList.get(inparamsCount).getMpromissorynote()+Constants.TILDA+beanList.get(inparamsCount).getMnationalid();
				
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, temp);
				fieldCount++;
			}
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END5|");
			fieldCount++;
		}else{
			f1= TMsgInParam.class.getDeclaredField("field" + ""+inparamsCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END5|");
			fieldCount++;
		}
		
		if(beanList!=null && beanList.size()>0){

			for( inparamsCount =0;inparamsCount<this.beanList.size();inparamsCount++) {	
				temp="";	
				
				temp=temp+(beanList.get(inparamsCount).getMnationaliddesc())+Constants.TILDA+beanList.get(inparamsCount).getMaddress2()+Constants.TILDA+
						beanList.get(inparamsCount).getMaddress3()+Constants.TILDA+beanList.get(inparamsCount).getMaddress4()+Constants.TILDA+
						beanList.get(inparamsCount).getMmaritalstatus()+Constants.TILDA+beanList.get(inparamsCount).getMreligioncd();
				
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, temp);
				fieldCount++;
			}
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END6|");
			fieldCount++;
		}else{
			f1= TMsgInParam.class.getDeclaredField("field" + ""+inparamsCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END6|");
			fieldCount++;
		}
		
		if(beanList!=null && beanList.size()>0){

			for( inparamsCount =0;inparamsCount<this.beanList.size();inparamsCount++) {	
				temp="";	
				
				temp=temp+(beanList.get(inparamsCount).getMeducationalqual())+Constants.TILDA+beanList.get(inparamsCount).getMemailaddr()+Constants.TILDA+
						beanList.get(inparamsCount).getMemployername()+Constants.TILDA+beanList.get(inparamsCount).getMbusinessname()+Constants.TILDA+
						beanList.get(inparamsCount).getMspousename()+Constants.TILDA+beanList.get(inparamsCount).getMsamevillageorward();
				
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, temp);
				fieldCount++;
			}
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END7|");
			fieldCount++;
		}else{
			f1= TMsgInParam.class.getDeclaredField("field" + ""+inparamsCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END7|");
			fieldCount++;
		}
		
		if(beanList!=null && beanList.size()>0){

			for( inparamsCount =0;inparamsCount<this.beanList.size();inparamsCount++) {	
				temp="";	
				
				temp=temp+(beanList.get(inparamsCount).getMvillage())+Constants.TILDA+beanList.get(inparamsCount).getMwardno()+Constants.TILDA+
						beanList.get(inparamsCount).getMstatecd()+Constants.TILDA+beanList.get(inparamsCount).getMtownship()+Constants.TILDA+
						beanList.get(inparamsCount).getMbuspropownership()+Constants.TILDA+beanList.get(inparamsCount).getMbusownership();
				
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, temp);
				fieldCount++;
			}
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END8|");
			fieldCount++;
		}else{
			f1= TMsgInParam.class.getDeclaredField("field" + ""+inparamsCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END8|");
			fieldCount++;
		}
		
		if(beanList!=null && beanList.size()>0){

			for( inparamsCount =0;inparamsCount<this.beanList.size();inparamsCount++) {	
				temp="";	
				
				temp=temp+(beanList.get(inparamsCount).getMbustoaassetval())+Constants.TILDA+beanList.get(inparamsCount).getMbusleninyears()+Constants.TILDA+
						beanList.get(inparamsCount).getMbusmonexpense()+Constants.TILDA+beanList.get(inparamsCount).getMbusmonhlynetprof();
				
				f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
				f1.setAccessible(true);
				f1.set(inParam, temp);
				fieldCount++;
			}
			f1= TMsgInParam.class.getDeclaredField("field" + ""+fieldCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END9|");
			fieldCount++;
		}else{
			f1= TMsgInParam.class.getDeclaredField("field" + ""+inparamsCount);
			f1.setAccessible(true);
			f1.set(inParam, "|END9|");
			fieldCount++;
		}
		
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
		
		inParam.setField202("99");	
		inParam.setField204(Constants.Field204);
		return inParam;
	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	

}
