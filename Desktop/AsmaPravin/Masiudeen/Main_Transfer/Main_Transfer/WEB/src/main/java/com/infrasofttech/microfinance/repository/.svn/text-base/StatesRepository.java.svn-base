package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.StatesEntity;

@Repository
public interface StatesRepository extends JpaRepository<StatesEntity, Long>{
	
	//StatesEntity findByStatesID(Long statesid);
	
	/*
	 * List<StatesEntity> findByStatesID(String statesname); StatesEntity
	 * findByStatesID(Long statesid);
	 */
//	@Modifying
//	@Query(value="Delete from md500025 where mstatecd IN (?1)",nativeQuery=true)
//	void deleteStates(List<String> mstatecd);
	
	
	@Query(value="select * from md500025 where mcountryid=?1",nativeQuery=true)
	List<StatesEntity> getAllState(String mcountryid);
	
	
	@Query(value="select * from md500025 where mstatecd=?1",nativeQuery=true)
	StatesEntity findState(String mstatecd);
	
	
	//bulk delete
	@Modifying
	@Query(value="Delete from md500025 where mstatecd IN (?1)",nativeQuery=true)
	void bulkDelete(List<String> mstatecd);
}
