package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.BranchMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.BranchMasterHolder;

public interface BranchMasterRepository extends JpaRepository<BranchMasterEntity, Long> {
	
	
	@Query(value="SELECT * FROM  md001003  where mpbrcode =?1 ",nativeQuery = true)
	BranchMasterEntity findByMpbrcode(int mpbrcode);	

	@Modifying
	@Query(value="DELETE FROM  md001003  where mpbrcode =?1 ",nativeQuery = true)
	public void deleteByMpbrcode(Integer [] mpbrcode);
	
	@Query(value="select mpbrcode,mname from md001003 ", nativeQuery= true)
	public List<BrnachMasterHolderInterface> findByBranchCd();	
	
	public static  interface BrnachMasterHolderInterface {
		public int getMpbrcode();		
		public String getMname();
	}
		
	
	//multiple delete
	@Modifying
	@Query(value="Delete  FROM  md001003  where mpbrcode IN (?1) ",nativeQuery = true)
	void deleteByBulk(List<Integer> mpbrcode);

	@Query(value="SELECT * FROM  md001003  where mpbrcode in ?1 ",nativeQuery = true)
	List<BranchMasterEntity> findAllById(int mpbrcode);
}
