package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.UserAccressRightsCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuAndAccessRightsHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.UserAccessRightsHolder;

public interface UserAccessRightsService {
	public ResponseEntity<?> getDataUserByMUserCode(String musrcode,int mgrpcd);
	
	public ResponseEntity<?> addList(UserAccessRightsHolder userAccessRights);
	
	//public  List<MenuHolderBean> getDataMenu(UserAccessRightsEntity userAccessRightsEntity);

	List<MenuHolderBean> getDataMenu(UserAccressRightsCompositeEntity userAccressRightsCompositeEntity);
	
	public ResponseEntity<?> getAllUserAccessRightsFromMaster();
	
	//public ResponseEntity<?> updateUserRights(UserAccessRightsEntity userAccessRightsEntity);
	
	public ResponseEntity<?> updateUserRights(UserAccessRightsHolder userAccessRightsHolder);

	public ResponseEntity<?> deleteData(List<UserAccessRightsHolder> code );
	
	//charts
	public List<MenuAndAccessRightsHolderBean> getChartsIdOnMenuAndAccessJoin(String musrcode,int mgrpcd);
	
	public ResponseEntity <?> findRecByPrmKey(UserAccessRightsHolder userAccessHoler);
	}
