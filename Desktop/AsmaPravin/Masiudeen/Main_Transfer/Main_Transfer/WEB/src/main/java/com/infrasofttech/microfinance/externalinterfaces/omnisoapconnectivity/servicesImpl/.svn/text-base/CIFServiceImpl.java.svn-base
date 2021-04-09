package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.time.LocalDateTime;
import java.time.Month;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CIFHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.CIFService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;


@Service
@Transactional
public class CIFServiceImpl implements CIFService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public TMsgInParam prepareRequestToOmni(BaseEntity bean) {
		CIFHolderBean cifHolderBean = (CIFHolderBean) bean;
		TMsgInParam inParam = new TMsgInParam();
		
		if(cifHolderBean.getMcustno() != 0 ) 
			inParam.setField1(String.valueOf(cifHolderBean.getMcustno()));
		
		if( cifHolderBean.getMnid() != null)
			inParam.setField2(String.valueOf(cifHolderBean.getMnid()));
		
		if( cifHolderBean.getMusrcode() != null)
			inParam.setField3(String.valueOf(cifHolderBean.getMusrcode()));
		
		if( cifHolderBean.getMlbrcode() != 0)
			inParam.setField4(String.valueOf(cifHolderBean.getMlbrcode()));
		
		inParam.setField202("99");
		inParam.setField204(Constants.Field204);	
		return inParam;

	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}
	
	List<CIFHolderBean> beanList;

	public List<CIFHolderBean> omniSoapServicesCifDetailList(CIFHolderBean beanList) {
		
		TMsgInParam inParams = prepareRequestToOmni(beanList);	
	
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Data of in params " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910913, inParams);
			
			
			
			return prepareResponseRecievedFromOmniForCifDetail(outparam);
	
		} catch (RemoteException e) {
				e.printStackTrace();
		}

		return null;
	}
	
	
	public List<CIFHolderBean> prepareResponseRecievedFromOmniForCifDetail(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<CIFHolderBean> retBeanList = new ArrayList<CIFHolderBean>();
		
		System.out.println(" bean response here is " + bean.toString());
		CIFHolderBean cifHolderBean;
		
		System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxx");
		System.out.println(beanList);
		for (int outParams = 0; outParams < 103; outParams++) {
			cifHolderBean = new CIFHolderBean();
			try {

				
				int outParamsLength = outParams + 1;
				//System.out.println("field f1 = "+TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength));
				Field f1 = TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength);
				f1.setAccessible(true);
				String str1 = f1.get(bean).toString();
				if(str1.trim().equals("")) {
					break;
				}
				String[] resultStr = str1.split("~");
				System.out.println("Result String"+resultStr.length);

				
				cifHolderBean.setMprdacctid(resultStr[0]);
				cifHolderBean.setMlbrcode(Integer.valueOf(resultStr[1]));
				cifHolderBean.setMmoduletype(Integer.valueOf(resultStr[2]));
				cifHolderBean.setMacctstat(Integer.valueOf(resultStr[3]));
				cifHolderBean.setMtier(Integer.valueOf(resultStr[4]));
				cifHolderBean.setMshadowclearbal(Double.valueOf(resultStr[5]));
				cifHolderBean.setMshadowtotalbal(Double.valueOf(resultStr[6]));
				cifHolderBean.setMactualclearbal(Double.valueOf(resultStr[7]));
				cifHolderBean.setMactualtotalbal(Double.valueOf(resultStr[8]));
				cifHolderBean.setMlienamt(Double.valueOf(resultStr[9]));
				cifHolderBean.setMmainbal(Double.valueOf(resultStr[10]));
				cifHolderBean.setMtdsamt(Double.valueOf(resultStr[11]));
				cifHolderBean.setMinterestprov(Double.valueOf(resultStr[12]));
				cifHolderBean.setMinterestpaid(Double.valueOf(resultStr[13]));
				cifHolderBean.setMmaturityvalue(Double.valueOf(resultStr[14]));
				cifHolderBean.setMpenalprov(Double.valueOf(resultStr[15]));
				cifHolderBean.setMpenalpaid(Double.valueOf(resultStr[16]));
				cifHolderBean.setMdisbursedamt(Double.valueOf(resultStr[17]));
				cifHolderBean.setMexcessamt(Double.valueOf(resultStr[18]));
				cifHolderBean.setMnametitle(resultStr[19]);
				cifHolderBean.setMlongname(resultStr[20]);
				cifHolderBean.setMcustno(Integer.valueOf(resultStr[21]));
				cifHolderBean.setMfreezetype(Integer.valueOf(resultStr[22]));
				cifHolderBean.setMleadsid(resultStr[23]);
				cifHolderBean.setMpannodesc(resultStr[24]);
				cifHolderBean.setMbranchname(resultStr[25]);
				cifHolderBean.setMcuststatus(Integer.valueOf(resultStr[26]));
				cifHolderBean.setMprinccurrdue(Double.valueOf(resultStr[27]));
				cifHolderBean.setMprincoverdue(Double.valueOf(resultStr[28]));
				cifHolderBean.setMintdue(Double.valueOf(resultStr[29]));
				cifHolderBean.setMsetno(Integer.valueOf(resultStr[30]));
				cifHolderBean.setMbatchcd(resultStr[31]);				
				cifHolderBean.setMlcytrnamt(Double.valueOf(resultStr[32]));
				
				retBeanList.add(cifHolderBean);
				System.out.println("retBeanList--"+retBeanList);
				
			} catch (NoSuchFieldException | SecurityException e) {
				// TODO Auto-generated catch block
				System.out.print("exception here");
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
