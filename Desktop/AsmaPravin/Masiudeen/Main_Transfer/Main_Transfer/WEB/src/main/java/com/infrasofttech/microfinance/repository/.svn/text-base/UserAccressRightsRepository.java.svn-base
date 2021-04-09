package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuAndAccessRightsHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.UserAccessRightsHolder;

@Repository
public interface UserAccressRightsRepository extends JpaRepository<UserAccessRightsEntity, Long> {
	
	@Query(value="SELECT * FROM  User_Access_Rights where mgrpcd = ?2 AND (musrcode =?1 OR musrcode ='ALLUSERS') ",nativeQuery = true)
	public List<UserAccessRightsEntity> findByMUserCode(String muserCode,int mgrpcd);
	
	@Query(value="SELECT * FROM  User_Access_Rights where mgrpcd = ?1 AND (musrcode =?2 OR musrcode ='ALLUSERS') ",nativeQuery = true)
	public List<UserAccessRightsEntity> findByMGrpCode(int mgrpcd,String muserCode);
	
	@Query(value="SELECT * FROM user_access_rights a INNER JOIN  menu_master b ON  a.menuid = b.menuid WHERE a.musrcode =?1 ",nativeQuery = true)
	public List<UserAccessRightsEntity> findData(String muserCode);
	
	@Query(value="SELECT * FROM  user_access_rights where mgrpcd=?1 ",nativeQuery = true)
	List<UserAccessRightsEntity> findByGrpCdAndUsrCd(int mgrpcd);
	
	@Query(value="SELECT DISTINCT mgrpcd,musrcode FROM user_access_rights where mgrpcd=?1,musrcode=?2",nativeQuery = true)
	List<UserAccessRightsEntity> findByGrpCdAndUsrcd(int mgrpcd,String musrcode);
	
	@Modifying
	@Query(value="DELETE FROM user_access_rights where menuid=?1 AND mgrpcd=?2 AND musrcode=?3",nativeQuery = true)
	public void deleteByGrpCdUsrCd(int menuid,int mgrpcd,String musrcode);
	
	@Modifying
	@Query(value="UPDATE user_access_rights SET authoritye = ?1 ,browsee =?2,createe=?3,deletee=?4, modifye=?5  WHERE menuid = ?1 AND mgrpcd=?2 AND musrcode=?3 ",nativeQuery = true)
	List<UserAccessRightsEntity> updateByGrpCdUsrCd(int menuid,int mgrpcd,String musrcode);
	
	@Query(value="SELECT * FROM  user_access_rights where menuid=?1 AND mgrpcd=?2 AND musrcode=?3",nativeQuery = true)
	UserAccessRightsEntity findByMenuIdAndGrpCdAndUsrCd(int menuid,int mgrpcd,String musrcode);

	//multiple delete
	@Modifying
	@Query(value="Delete  FROM  user_access_rights  where  menuid IN (?1) AND mgrpcd IN (?2) AND musrcode IN (?3) ",nativeQuery = true)
	void deleteByBulk(int menuid,int mgrpcd,String musrcode);
	//(List<Integer> menuid,List<Integer> mgrpcd, List<String> musrcode)

	
	@Query(value="select * from user_access_rights Order By menuid desc",nativeQuery=true)
	public List<UserAccessRightsEntity> findAllRights();
	
	
	@Query(value="SELECT b.mchartid FROM  User_Access_Rights as a , MenuMaster as b where a.mgrpcd = ?2 "
			+ "AND (a.musrcode =?1 OR a.musrcode ='ALLUSERS') AND a.menuid=b.menuid AND b.mchartid <>0",nativeQuery = true)
	public List<MenuAndAccessRightsHolderBean> getChartsIdOnMenuAndAccessJoin(String muserCode,int mgrpcd);

	@Query(value="SELECT acs.menuid,acs.musrcode,acs.mgrpcd,acs.authoritye,acs.browsee,acs.createe,acs.deletee,acs.modifye,usr.musrname FROM md002001 AS usr RIGHT JOIN user_access_rights AS acs ON usr.musrcode=acs.musrcode",nativeQuery = true)
	public List<UserAccessHolderInterface> getAll();
	
	public static  interface UserAccessHolderInterface {			
		 public int getMenuid();
		 public String getMusrcode();
		 public int getMgrpcd();
		 public int getCreatee();
		 public int getBrowsee();
		 public int getAuthoritye();
		 public int getDeletee();			
		 public String getMusrname();
	}

	@Query(value="select * from user_access_rights",nativeQuery=true)
	public List<UserAccessRightsHolder> all();
	

}


