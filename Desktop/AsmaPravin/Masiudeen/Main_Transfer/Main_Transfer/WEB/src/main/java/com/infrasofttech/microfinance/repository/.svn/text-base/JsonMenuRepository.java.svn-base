package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.JsonMenuCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.JsonMenuEntity;

@Repository
@Transactional
public interface JsonMenuRepository extends JpaRepository<JsonMenuEntity,JsonMenuCompositeEntity> {
	
	@Query(value="SELECT * FROM  menu_master where parentId=?1",nativeQuery = true)
	List<JsonMenuEntity> findByParId(int menuId);
	
	
	@Modifying
    @Query(value = "UPDATE json_menu_master SET mcachingvalue = ?3 WHERE musrcode = ?2 AND mgrpcd=?1 ",nativeQuery = true)
    int updateJson( int mgrpcd,String musrcode,String mcachingvalue);

	@Modifying
	@Query(value="delete from  json_menu_master", nativeQuery = true)
	List<JsonMenuEntity> trucateJson();
	
	
	@Query(value="SELECT DISTINCT mgrpcd as mgrpcd ,musrcode as musrcode,'' as mcachingvalue FROM user_access_rights", nativeQuery = true)
	List<JsonMenuEntity> selectDistinct();

	@Query(value="SELECT * FROM json_menu_master ", nativeQuery = true)
	List<JsonMenuEntity> findMenu();
	
	@Query(value="Select * from json_menu_master where mgrpcd=?1 ",nativeQuery=true )
	List<JsonMenuEntity> getMenuList(int mgrpcd);
	
}
