package com.infrasofttech.microfinance.repository;




import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.PathTrackerMasterEntity;


@Repository
public interface PathTrackerMasterRepository extends JpaRepository<PathTrackerMasterEntity, Long> {

	 @Query(value = "Select * from  path_Tracker_Master  WHERE musrcode = ?1 AND  convert(varchar(10), mcreateddt, 102)  = convert(varchar(10), getdate(), 102) AND mgeolatd IS NOT NULL AND mgeologd IS NOT NULL order by mcreateddt ",nativeQuery = true)
		List<PathTrackerMasterEntity> findBymusrcodeByLOcationNotNull(String mcreatedby);
	 

}