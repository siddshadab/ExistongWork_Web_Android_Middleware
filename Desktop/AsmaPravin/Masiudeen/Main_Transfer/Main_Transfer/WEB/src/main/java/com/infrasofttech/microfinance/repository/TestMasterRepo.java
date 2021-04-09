package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.TestMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;

public interface TestMasterRepo extends JpaRepository<TestMasterEntity, Long>{

	@Query(value="SELECT * FROM  test_master where categoryId=?1",nativeQuery = true)
	List<TestMasterEntity> getTestMaster(int categoryId);
	
	@Query(value="SELECT * FROM  test_master where categoryId=?1",nativeQuery = true)
	List<TestMasterEntity> findByCatId(int categoryId);
	
	@Query(value="SELECT * FROM  test_master where parentId=?1",nativeQuery = true)
	List<TestMasterEntity> findByParId(int categoryId);
	
	@Query(value="SELECT * FROM  test_master where parentId=?1",nativeQuery = true)
	List<TestMasterEntity> findByParent(int parentId);
	
	@Query(value="delte from test_master where categoryId=?",nativeQuery = true)
	List<TestMasterEntity> deleteById(int categoryId);
	
	
	
	@Query(value="from UserMasterEntity where musrcode =?1")
	public UserMasterEntity findByMusrcode(String musrcode);
	
			
		
	@Query(value="with rcte (categoryId,title,parentId) as ( select title from test_master where parentId = 0  UnionAll select * from test_master t INNNER JOIN rcte r ON r.categpryId= t.parentId ) select * from rcte order by categoryId ",nativeQuery = true)		
	List<TestMasterEntity> getHirachy();
}
