package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.JsonMenuEntity;
import com.infrasofttech.microfinance.entityBeans.master.MenuMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.JsonMenuMasterHolder;

@Repository
public interface MenuMasterRepository extends JpaRepository<MenuMasterEntity, Integer > {

	
	/*
	 * @Query(
	 * value="SELECT A.menuid as menuid, B.parentid as parentid ,  A.menudesc, A.menutype,A.murl,A.parenttype FROM menu_master A, menu_master B WHERE A.menuid = B.parentid AND A.menuid =?1 "
	 * ,nativeQuery = true) public List<MenuMasterEntity> findByMenuIdSelfJoin(int
	 * menuId);
	 */
	
	@Query(value="with rcte (menuid,parentId,menudesc,menutype,murl,parenttype ) as (select e.menuid , e.parentId ,e.menudesc ,e.menutype"
			+ " ,e.murl,e.parenttype from menu_master e where e.menuid = ?1  Union all  SELECT "
			+ "d.menuid,d.parentId ,d.menudesc,d.menutype,d.murl,d.parenttype FROM menu_master d  JOIN rcte AS a\r\n" + 
			"                      ON d.Parentid = a.menuid) "
			+ "select * from rcte option (maxrecursion 0)",nativeQuery = true)
	public List<MenuMasterEntity> findByMenuIdSelfJoin(int menuId);
	
	
	@Query(value="Select * from menu_master where menuid=?1",nativeQuery = true)
	public List<MenuMasterEntity> findByMenuId(int menuId);
	
	@Query(value="SELECT * FROM  menu_master where parentId=?1",nativeQuery = true)
	List<JsonMenuEntity> findByParId(int menuId);
	
//	@Query(value="SELECT * FROM  menu_master where parentId=?1",nativeQuery = true)
//	List<MenuMasterEntity> findByParIdMenu(int menuId);
	
	@Query(value="SELECT * FROM  menu_master where parentId=?1",nativeQuery = true)
	List<JsonMenuMasterHolderInterface> findByParIdMenu(int menuId);
	
	
	@Query(value="SELECT * FROM   Menu_Master  menu INNER JOIN User_Access_Rights  userAccess  ON menu.menuid = userAccess.menuid where "
			+ "userAccess.mgrpcd = ?2 AND (userAccess.musrcode =?1 OR userAccess.musrcode ='ALLUSERS') ",nativeQuery = true)
	List<MenuMasterEntity> findBysBasedOnAccessWrites(String musercode,int mgrpcd);
	
	
	
	@Query(value="SELECT menu.murl as murl,menu.parenttype as parenttype, menu.menutype as menutype, menu.parentid as parentid,menu.menudesc as menudesc,menu.miconname as miconname,userAccess.authoritye as authoritye,userAccess.menuid as menuid,userAccess.musrcode as musrcode,userAccess.mgrpcd as mgrpcd,userAccess.createe as createe,"
			+ "userAccess.browsee as browsee,userAccess.deletee as deletee ,userAccess.modifye as modifye  FROM   Menu_Master  menu INNER JOIN User_Access_Rights  userAccess  ON menu.menuid = userAccess.menuid where "
			+ "userAccess.mgrpcd = ?2 AND (userAccess.musrcode =?1 OR userAccess.musrcode ='ALLUSERS') AND menu.mapplicationtype='Web' ",nativeQuery = true)
	public List<JsonMenuMasterHolderInterface> findByUsrCdAndGrpCd(String musercode,int mgrpcd);
	
	
	public static  interface JsonMenuMasterHolderInterface {	

		 public int getParentid();
		 public String getMenudesc();
		 public int getAuthoritye();
		 public int getMenuid();
		 public String getMusrcode();
		 public int getMgrpcd();
		 public int getCreatee();
		 public int getBrowsee();
		 public int getDeletee();
		 public int getModifye();		
		 public String getMurl();
		 public String getMiconname();
		 public String parenttype();	
		 public String menutype();
		
		 
		 
		 
	
		 
	}
	  
	
	 
}
