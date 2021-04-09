package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.SavingsCollectionListEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniSavingsCollectionListService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;

@Service
public class OmniSavingsCollectionListServiceImpl implements OmniSavingsCollectionListService {

	// DailyLoanCollectedEntity dailyLoanCollectedEntity = new
	// DailyLoanCollectedEntity();
	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		SavingsCollectionListEntity showSavingsListEntity = (SavingsCollectionListEntity) bean;

		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(showSavingsListEntity);
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "5", 910915, inParams);
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
			retBean.setMCustRefNo(showSavingsListEntity.getMrefno());
			retBean.setCreatedBy(showSavingsListEntity.getMcreatedby());
			retBean.setTRefno(showSavingsListEntity.getTrefno());
			retBean.setMentrydate(showSavingsListEntity.getMentrydate());
			retBean.setMbatchcd(showSavingsListEntity.getMbatchcd());
			retBean.setMsetno(showSavingsListEntity.getMsetno());
			retBean.setMscrollno(showSavingsListEntity.getMscrollno());

			if (!outparam.getField201().equals("0")) {
				System.out.println("Dayta of in patrams 1"+outparam.toString());
				retBean.setStatus(1);
				retBean.setMCustNo(0);				
				retBean.setError(outparam.getField203());
				return retBean;
			}
			System.out.println("Dayta of in patrams 2 "+outparam.toString());
			if(outparam!=null && outparam.getField1() !=null) {
				retBean.setStatus(0);
				retBean.setMCustNo(Integer.parseInt(outparam.getField1()));
			} else {
				retBean.setStatus(1);
				retBean.setMCustNo(0);
				retBean.setError(outparam.getField203());
			}
			return retBean;
		} catch (RemoteException e) {

		}

		return null;
	}

	List<SavingsCollectionListEntity> beanList;

	public List<SavingsCollectionListEntity> omniSoapServicesSavingsCollectedList(List<SavingsCollectionListEntity> beanList) {
		// DailyLoanCollectedEntity dailyLoanCollectedEntity =
		// (DailyLoanCollectedEntity) bean;
		// this.beanList = new ArrayList<DailyLoanCollectedEntity>();
		this.beanList = beanList;

		System.out.println("this.beanList " + this.beanList.size());
		// System.out.println("beanList " +beanList.size());
		TMsgInParam inParams = prepareRequestToOmni(null);

		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams " + inParams.toString());
			outparam = omniServiceSoapProxy.invoke(Constants.Field1, "5", 910915, inParams);
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
		// DailyLoanCollectedEntity customerLoanEntityBean = (DailyLoanCollectedEntity)
		// bean;
		TMsgInParam inParam = new TMsgInParam();

		StringBuilder temp = new StringBuilder();
		Field f1 = null;
		for (int inparamsCount = 0; inparamsCount < this.beanList.size(); inparamsCount++) {

			// changing dates to omni format
			// String lastSyncDate =
			// Utility.unFormateDt(this.beanList.get(inparamsCount).getMlastsynsdate());
			// String mcreatedDate =
			// Utility.unFormateDt(this.beanList.get(inparamsCount).getMcreateddt());

			// changing prcdacctid

			
			  String mprdcd = this.beanList.get(inparamsCount).getMprdacctid().substring(0,8);
			  String mcustno = this.beanList.get(inparamsCount).getMprdacctid().substring(9,16); 
			  String mprcdacctid = this.beanList.get(inparamsCount).getMprdacctid().substring(17,24);
			 

			// Change checkboex to YN

			/*
			 * String madjfrmsd =
			 * Utility.chngToYN(String.valueOf(this.beanList.get(inparamsCount).getMadjfrmsd
			 * ())); String madjfrmexcss =
			 * Utility.chngToYN(String.valueOf(this.beanList.get(inparamsCount).
			 * getMadjfrmexcss())); String mpaidByGrp =
			 * Utility.chngToYN(String.valueOf(this.beanList.get(inparamsCount).
			 * getMpaidbygrp())); String mattndnc =
			 * Utility.chngToYN(String.valueOf(this.beanList.get(inparamsCount).getMattndnc(
			 * )));
			 */

			temp = new StringBuilder();
			temp.append(this.beanList.get(inparamsCount).getMrefno()).append("~")
					.append(this.beanList.get(inparamsCount).getMlbrcode()).append("~")
					.append(mcustno+"/"+mprdcd+"/"+mprcdacctid).append("~")
					.append(this.beanList.get(inparamsCount).getMcollectedamount()).append("~")
					.append(this.beanList.get(inparamsCount).getMremark()).append("~")
					.append(this.beanList.get(inparamsCount).getMbatchcd()).append("~")
					.append(this.beanList.get(inparamsCount).getMcreatedby());

			// System.out.println("Net is slow here in euthopia "+temp.toString()+"
			// inparamsCount "+inparamsCount);

			try {
				int parmsCount = inparamsCount + 1;
				f1 = TMsgInParam.class.getDeclaredField("field" + "" + parmsCount);
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
		// inParam.setField204(Constants.Field204);
		inParam.setField204(Constants.Field204);
		return inParam;
	}

	@Override
	public OmniSoapResultBean prepareResponseRecievedFromOmni(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<SavingsCollectionListEntity> prepareResponseRecievedFromOmniForCollection(TMsgOutParam bean) {
		// TODO Auto-generated method stub
		List<SavingsCollectionListEntity> retBeanList = new ArrayList<SavingsCollectionListEntity>();
		System.out.println(" bean response here is " + bean.toString());
		/*
		 * Class<?> clz = TMsgOutParam.class; Method[] methods =
		 * clz.getDeclaredMethods();
		 */

		for (int outParams = 0; outParams < this.beanList.size(); outParams++) {
			SavingsCollectionListEntity savingsCollectionListEntityBean = new SavingsCollectionListEntity();
			try {
				int outParamsLength = outParams + 1;
				Field f1 = TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength);
				f1.setAccessible(true);
				System.out.println("f1-------------------"+f1);
				System.out.println("field f1 = "+TMsgOutParam.class.getDeclaredField("field" + "" + outParamsLength));

				String str = f1.get(bean).toString();
				System.out.println("bean"+bean.toString());
				System.out.println("str-----------------------"+str);
				String[] arrOfStr = str.split("/");
				for (int arrOfStringSingles = 0; arrOfStringSingles <= arrOfStr.length; arrOfStringSingles++) {		
					savingsCollectionListEntityBean.setMrefno(this.beanList.get(outParams).getMrefno());

					savingsCollectionListEntityBean
							.setMissynctocoresys(Integer.valueOf(arrOfStr[1].toString()) == 1 ? 0 : 1);
					savingsCollectionListEntityBean.setMerrormessage(arrOfStr[2]);

					// System.out.println(a);
				}
				retBeanList.add(savingsCollectionListEntityBean);
				System.out.println("Issue of str " + str);
				System.out.println("dailyCollBean getMrefno " + savingsCollectionListEntityBean.getMrefno());
				System.out.println("dailyCollBean str " + savingsCollectionListEntityBean.getMrefno());
				System.out.println(
						"dailyCollBean getMerrormessage " + savingsCollectionListEntityBean.getMerrormessage());

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
