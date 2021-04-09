package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.ChartsMasterEntity;

public interface ChartsMasterService {

	
	
	public ResponseEntity<?> getChartsDataByAccessRightAndChartsMaster(String musrcode,int mgrpcd);
	public ResponseEntity<?> getJoinAllthreeTables(String musrcode,int mgrpcd);
	public ResponseEntity<?> addChart(ChartsMasterEntity chartEntity);
	//crud
//	public ResponseEntity<?> addCharts(ChartsMasterEntity chartsMasterEntity);
//	
	public ResponseEntity<?> editCharts(ChartsMasterEntity chartsMasterEntity);
	
	public ResponseEntity<?> deleteCharts(List<Integer> mrefno);
}
