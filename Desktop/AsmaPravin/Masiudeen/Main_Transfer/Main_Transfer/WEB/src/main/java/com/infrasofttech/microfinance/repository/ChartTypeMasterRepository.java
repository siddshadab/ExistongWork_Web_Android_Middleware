package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.ChartTypesMasterEntity;
@Repository
public interface ChartTypeMasterRepository extends JpaRepository<ChartTypesMasterEntity, String>{

	 @Query(value="SELECT * FROM  chart_types_master where mcharttypes=?1",nativeQuery =true) 
	public List<ChartTypesMasterEntity> findCharts(String mcharttypes);
}
