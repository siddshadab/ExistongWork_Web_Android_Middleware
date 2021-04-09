package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuAndAccessRightsHolderBean;

@Repository
public interface UserAccressRightsRepository extends JpaRepository<UserAccessRightsEntity, Long> {
	
	@Query(value="SELECT * FROM  User_Access_Rights where mgrpcd = ?2 AND (musrcode =?1 OR musrcode ='ALLUSERS') ",nativeQuery = true)
	public List<UserAccessRightsEntity> findByMUserCode(String muserCode,int mgrpcd);
	
	
	
	 
	
	@Query(value="SELECT b.mchartid FROM  User_Access_Rights as a , MenuMaster as b where a.mgrpcd = ?2 "
			+ "AND (a.musrcode =?1 OR a.musrcode ='ALLUSERS') AND a.menuid=b.menuid AND b.mchartid <>0",nativeQuery = true)
	public List<MenuAndAccessRightsHolderBean> getChartsIdOnMenuAndAccessJoin(String muserCode,int mgrpcd);
	
	
	
}
