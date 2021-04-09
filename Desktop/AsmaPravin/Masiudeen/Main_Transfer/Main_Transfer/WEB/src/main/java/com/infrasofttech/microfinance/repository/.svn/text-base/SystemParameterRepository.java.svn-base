package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;


@Repository
public interface SystemParameterRepository  extends JpaRepository<SystemParameterEntity, Long> {

	
	@Query(value = "Select * from  md001004  WHERE mcode= ?1 and mlbrcode = 0",nativeQuery = true)
	SystemParameterEntity findByCode(String mcode);
	
	@Query(value = "Select * from  md001004  WHERE mcode= ?1 and mlbrcode = 0",nativeQuery = true)
	SystemParameterEntity findByMcodeMlbrcode(String mcode,int mlbrcode);

	@Query(value="select * from md001004  WITH (NOLOCK) Order BY mcreateddt desc",nativeQuery=true)
	List<SystemParameterEntity> findAllParam();

	@Modifying
	@Query(value="Delete From md001004 where mcode=?1, and mlbrcode=?2",nativeQuery = true)
	public void deleteByMcodeMlbrcode(String mcode,int mlbrcode);
	
	@Modifying
	@Query(value="Update md001004 SET mcodedesc = ?3,mcodevalue =?4 where mcode=?1, and mlbrcode=?2",nativeQuery = true)
	public SystemParameterEntity updateByMcodeMlbrcode(String mcode,int mlbrcode);
	
	
	@Query(value = "Select * from  md001004  WHERE mcode= ?1 and mlbrcode =?2",nativeQuery = true)
	SystemParameterEntity findByMcode(String mcode,int mlbrcode);
	//multiple delete
	
		@Modifying
		@Query(value="Delete  FROM  md001004 where mcode IN (?1) and mlbrcode IN (?2) ",nativeQuery = true)
		public void deleteByBulk(String mcode,int mlbrcode);

		@Query(value="SELECT sys.*,brn.mname FROM md001003 AS brn Right JOIN md001004 as sys ON sys.mlbrcode = brn.mpbrcode ORDER BY sys.mcreateddt desc",nativeQuery=true)
		List<SystemParamterHolder> getAll();

		
		public static interface SystemParamterHolder{
			public int getMlbrcode();			    
			public String getMcode(); 				
			public String getMcodedesc();		
			public String getMcodevalue();	
			public LocalDateTime getMcreateddt();
			public String getMname();
		}
	
}
