package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.servicesImpl;

import java.lang.reflect.Field;
import java.rmi.RemoteException;
import java.util.List;

import org.apache.tomcat.util.bcel.classfile.Constant;
import org.springframework.stereotype.Service;
import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgInParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.bean.TMsgOutParam;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean.OmniSoapResultBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.impl.TOmniServiceSoapProxy;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniCustomerMasterService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.services.OmniSavingsListService;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.utility.Utility;

@Service
public class OmniGroupMasterServiceImpl implements OmniSavingsListService {

	@Override
	public OmniSoapResultBean omniSoapServices(BaseEntity bean) {
		GroupsFoundationEntity groupsFoundationEntityBean = (GroupsFoundationEntity) bean;
		System.out.println("inparams");
		TMsgInParam inParams = prepareRequestToOmni(bean);
		System.out.println("Outparams");
		// do Request
		TMsgOutParam outparam = null;
		OmniSoapResultBean retBean = null;
		TOmniServiceSoapProxy omniServiceSoapProxy = new TOmniServiceSoapProxy();
		try {
			System.out.println("Dayta of in patrams "+inParams.toString());
			if (groupsFoundationEntityBean.getMgroupid() == 0)
			  outparam = omniServiceSoapProxy.invoke(Constants.Field1, "1", 910908, inParams);
			else
				outparam = omniServiceSoapProxy.invoke(Constants.Field1, "2", 910908, inParams);
				  
			
			System.out.println("here starts");
			System.out.println("groupId"+outparam.getField1());
			
			
			System.out.println("feidl201"+outparam.getField201());
			System.out.println("feidl204"+outparam.getField204());
			System.out.println("feidl203"+outparam.getField203());
			System.out.println("feidl202"+outparam.getField202());
			System.out.println("here ends");
			retBean = prepareResponseRecievedFromOmni(outparam);
			retBean = new OmniSoapResultBean();		
			
			System.out.println("mrefno--" + retBean.getMRefno());
			
			
			
			
			if (!outparam.getField201().equals("0")) {
				System.out.println("Dayta of in patrams 1"+outparam.toString());
				retBean.setStatus(1);			
				retBean.setError(outparam.getField203());
				return retBean;
			}
			System.out.println("Dayta of in patrams 2 "+outparam.toString());
			if(outparam!=null && outparam.getField1() !=null) {
				System.out.println("outparam.getField1");
				retBean.setStatus(0);
				retBean.setMRefno(groupsFoundationEntityBean.getMrefno());
				if (groupsFoundationEntityBean.getMgroupid() == 0)
					retBean.setGroupId(Integer.parseInt(outparam.getField1()));
				
				System.out.println("getGroupId----" + retBean.getGroupId());
				
			} else {
				System.out.println("outparam.getField1 - blank");
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
		GroupsFoundationEntity groupsFoundationEntity = (GroupsFoundationEntity) bean;
		TMsgInParam inParam = new TMsgInParam();
		if (groupsFoundationEntity.getMgroupid() == 0)
			inParam.setField1("0~C~2");
		else
			inParam.setField1(String.valueOf(groupsFoundationEntity.getMgroupid()) + "~N~2");
		
		inParam.setField2(Constants.EMPTYSTRING);
		//inParam.setField2(Utility.unFormateDt(centersFoundationEntity.getMeffectivedt()) + "-" + String.valueOf(centersFoundationEntity.getMlbrcode()));
		inParam.setField3(String.valueOf(groupsFoundationEntity.getMcenterid()));
		inParam.setField4(String.valueOf(groupsFoundationEntity.getMgrouptype()));
		inParam.setField5(Utility.unFormateDt(groupsFoundationEntity.getMgrprecogtestdate()));
		inParam.setField6(Constants.EMPTYSTRING);
		inParam.setField7(Constants.EMPTYSTRING);
		inParam.setField8(Constants.EMPTYSTRING);
		inParam.setField9(Constants.EMPTYSTRING);
		inParam.setField10(String.valueOf(groupsFoundationEntity.getMlbrcode()));
		inParam.setField11("2");
		inParam.setField12("1");
		inParam.setField13(Constants.EMPTYSTRING);
		inParam.setField14(Constants.EMPTYSTRING);
		inParam.setField15("GRP");
		inParam.setField16(groupsFoundationEntity.getMgroupname());
		inParam.setField17("~~");
		inParam.setField18("~");
		inParam.setField19("99");
		inParam.setField20(Constants.EMPTYSTRING);
		inParam.setField21("1");
		inParam.setField22(Constants.EMPTYSTRING);
		inParam.setField23(Constants.EMPTYSTRING);
		inParam.setField24(Constants.EMPTYSTRING);
		inParam.setField25(Constants.EMPTYSTRING);
		inParam.setField26(Constants.EMPTYSTRING);
		inParam.setField27(Constants.EMPTYSTRING);
		inParam.setField28(Constants.EMPTYSTRING);
		inParam.setField29(Constants.EMPTYSTRING);
		inParam.setField30(Constants.EMPTYSTRING);
		inParam.setField31(Constants.EMPTYSTRING);
		inParam.setField32(Constants.EMPTYSTRING);
		inParam.setField33(Constants.EMPTYSTRING);
		inParam.setField34(Constants.EMPTYSTRING);
		inParam.setField35(Constants.EMPTYSTRING);
		inParam.setField36("~~");
		inParam.setField37("-");
		inParam.setField38(Constants.EMPTYSTRING);
		inParam.setField39(Constants.EMPTYSTRING);
		inParam.setField40(Constants.EMPTYSTRING);
		inParam.setField41(Constants.EMPTYSTRING);
		inParam.setField42(Constants.EMPTYSTRING);
		inParam.setField43(Constants.EMPTYSTRING);
		inParam.setField44(Constants.EMPTYSTRING);
		inParam.setField45(Constants.EMPTYSTRING);
		inParam.setField46(Constants.EMPTYSTRING);
		inParam.setField47(groupsFoundationEntity.getMgrtapprovedby());
		inParam.setField48(Constants.EMPTYSTRING);
		inParam.setField49(Constants.EMPTYSTRING);
		inParam.setField50(Constants.EMPTYSTRING);
		inParam.setField51(Constants.EMPTYSTRING);
		inParam.setField52(Constants.EMPTYSTRING);
		inParam.setField53(Constants.EMPTYSTRING);
		inParam.setField54(Constants.EMPTYSTRING);
		inParam.setField55(Constants.EMPTYSTRING);
		inParam.setField56(Constants.EMPTYSTRING);
		inParam.setField57(Constants.EMPTYSTRING);
		inParam.setField58(Utility.unFormateDt(groupsFoundationEntity.getMgrprecogtestdate()));
		inParam.setField59("N");
		inParam.setField60(Constants.EMPTYSTRING);
		inParam.setField61(Constants.EMPTYSTRING);
		inParam.setField62(Constants.EMPTYSTRING);
		inParam.setField63(Constants.EMPTYSTRING);
		inParam.setField64(Constants.EMPTYSTRING);
		inParam.setField65(Constants.EMPTYSTRING);
		inParam.setField66("1");
		inParam.setField67(Constants.EMPTYSTRING);
		inParam.setField68(Constants.EMPTYSTRING);
		inParam.setField69(groupsFoundationEntity.getMgroupprdcode());
		inParam.setField70(groupsFoundationEntity.getMgroupgender()+"~N~N");
		inParam.setField71(Constants.EMPTYSTRING);
		inParam.setField72(Constants.EMPTYSTRING);
		inParam.setField73(groupsFoundationEntity.getMagentcd());
		inParam.setField74(Constants.EMPTYSTRING);
		inParam.setField75(Constants.EMPTYSTRING);
		inParam.setField76(Constants.EMPTYSTRING);
		inParam.setField77(Constants.EMPTYSTRING);
		inParam.setField78(Constants.EMPTYSTRING);
		inParam.setField79(Constants.EMPTYSTRING);
		inParam.setField80(String.valueOf(groupsFoundationEntity.getMmingroupmembers()));
		inParam.setField81(String.valueOf(groupsFoundationEntity.getMmaxgroupmembers()));
		inParam.setField82(Constants.EMPTYSTRING);
		inParam.setField83(Constants.EMPTYSTRING);
		inParam.setField84(Constants.EMPTYSTRING);
		inParam.setField85("~");
		inParam.setField86(Constants.EMPTYSTRING);
		inParam.setField87(Constants.EMPTYSTRING);
		inParam.setField88(Constants.EMPTYSTRING);
		inParam.setField89(Constants.EMPTYSTRING);
		inParam.setField90(Constants.NA);
		inParam.setField91(Constants.NA);
		inParam.setField92(Constants.NA);
		inParam.setField93(Constants.NA);
		inParam.setField94(Constants.EMPTYSTRING);
		inParam.setField95(Constants.EMPTYSTRING);
		inParam.setField96(Constants.EMPTYSTRING);
		inParam.setField97(Constants.EMPTYSTRING);
		inParam.setField98("|END1|");
		inParam.setField99(Constants.EMPTYSTRING);
		
		
				//getMcustno() + Constants.TILDA + savingsListEntity.getMprdcd() + Constants.TILDA + "0");
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
