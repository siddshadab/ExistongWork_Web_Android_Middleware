package com.infrasofttech.microfinance.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.DistrictsEntity;

@Repository
public interface DistrictsRepository extends JpaRepository<DistrictsEntity, Long>{
	
	/*
	 * List<DistrictsEntity> findByDistrictsID(String districtsname);
	 * DistrictsEntity findByDistrictsID(Long districtsid);
	 */
	
	@Query(value="select * from md500035 where mdistcd=?1", nativeQuery= true)
	public DistrictsEntity findByMdistCd(int mdistcd);
	
	@Modifying
	@Query(value="Delete from md500035 where mdistcd IN (?1)",nativeQuery=true)
	public void deleteByMdistcd(List<Integer> mdistcd);
	
	
	@Query(value="Select * from md500035 where mstatecd=?1",nativeQuery=true)
	public List<DistrictsEntity> getAllDistricts(String mstatecd);
	
	//bulk delete
	@Modifying
	@Query(value="Delete from md500035 where mdistcd IN (?1)",nativeQuery=true)
	public void bulkDelete(List<Integer> mdistcd);

}
