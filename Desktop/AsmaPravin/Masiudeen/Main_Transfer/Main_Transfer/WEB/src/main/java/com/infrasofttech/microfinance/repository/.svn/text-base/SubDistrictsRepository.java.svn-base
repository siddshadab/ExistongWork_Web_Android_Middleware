package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.SubDistrictsEntity;

public interface SubDistrictsRepository extends JpaRepository<SubDistrictsEntity, Long> {
	
	/*
	 * List<SubDistrictsEntity> findBySubDistrictsID(String subDistrictsname);
	 * SubDistrictsEntity findBySubDistrictsID(Long subDistrictsid);
	 */
	
	@Query(value="Select * from md500028 where mplacecd=?1",nativeQuery=true)
	public SubDistrictsEntity findByMplaceCd(String mplacecd);
	
	@Modifying
	@Query(value="Delele from md500028 where mplacecd=?1",nativeQuery=true)
	public void deleteByMplacecd(String mplacecd);
	
	@Query(value="Select * from md500028 where mdistcd=?1",nativeQuery=true)
	List<SubDistrictsEntity> findByMplaceCode(int mdistccd);
	
	
	@Modifying
	@Query(value="Delete from md500028 where mplacecd IN (?1)",nativeQuery=true)
	public void bulkDelete(List<String> mplacecd);
}
