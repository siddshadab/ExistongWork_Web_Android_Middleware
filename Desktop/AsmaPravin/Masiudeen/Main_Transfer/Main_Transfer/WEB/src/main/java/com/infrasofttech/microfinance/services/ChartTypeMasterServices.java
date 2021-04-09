package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.ChartTypesMasterEntity;

public interface ChartTypeMasterServices {

	public ResponseEntity<?> addChartType(ChartTypesMasterEntity chartTypesMasterEntity);
	public ResponseEntity<?> editChartType(ChartTypesMasterEntity chartTypesMasterEntity);
	public ResponseEntity<?> deleteChartType(ChartTypesMasterEntity chartTypesMasterEntity);
	public ResponseEntity<?> getcharts(ChartTypesMasterEntity chartTypesMasterEntity);
	public ResponseEntity<?> addChartTypes(ChartTypesMasterEntity chartTypesMasterEntity);
	public ResponseEntity<?> editChartTypes(ChartTypesMasterEntity chartTypesMasterEntity);
	public ResponseEntity<?> deleteChartTypes(ChartTypesMasterEntity chartTypesMasterEntity);
	public ResponseEntity<?> getAllChartTypes();
}
