package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.AreaEntity;
import com.infrasofttech.microfinance.entityBeans.DistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.SubDistrictsEntity;

public interface AreaRepository extends JpaRepository<AreaEntity, Long> {
	
	/*
	 * List<SubDistrictsEntity> findBySubDistrictsID(String subDistrictsname);
	 * SubDistrictsEntity findBySubDistrictsID(Long subDistrictsid);
	 */

	
	@Query(value=" SELECT  A.mareacd,A.mplacecd,A.mareadesc,A.mlastsynsdate FROM  md500024 A inner JOIN md500028 B ON A.mplacecd=b.mplacecd INNER JOIN md001003 C ON B.mstatecd=C.mstate  WHERE C.mpbrcode=?1  " ,nativeQuery = true)
	List<AreaEntity> findByMpbrcd(int mpbrcode);
}
