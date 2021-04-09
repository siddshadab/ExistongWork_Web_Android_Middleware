package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.ChartTypesMasterEntity;
import com.infrasofttech.microfinance.repository.ChartTypeMasterRepository;
import com.infrasofttech.microfinance.services.ChartTypeMasterServices;

@Service
@Transactional
public class ChartTypeMasterServiceImpl implements ChartTypeMasterServices{

	@Autowired
	ChartTypeMasterRepository repo;
	
	
	public ResponseEntity<?> getChartTypes(){
		
		List<ChartTypesMasterEntity> list = repo.findAll();
	
		return new ResponseEntity<Object> (list,new HttpHeaders(),HttpStatus.OK);
		
	}
		
	@Override
	public ResponseEntity<?> addChartType(ChartTypesMasterEntity chartTypesMasterEntity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity<?> editChartType(ChartTypesMasterEntity chartTypesMasterEntity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity<?> deleteChartType(ChartTypesMasterEntity chartTypesMasterEntity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity<?> getcharts(ChartTypesMasterEntity chartTypesMasterEntity) {
		
		System.out.println("xxxxxxxxxxxxxx"+chartTypesMasterEntity);
		System.out.println("xxxxxxxxxxxxxx"+chartTypesMasterEntity.getMcharttypes());
		List<ChartTypesMasterEntity> list = repo.findCharts(chartTypesMasterEntity.getMcharttypes());
		return new ResponseEntity<Object> (list,new HttpHeaders(),HttpStatus.OK);
	}
	
	@Override
	public ResponseEntity<?> getAllChartTypes() {
		List<ChartTypesMasterEntity> listEnt = repo.findAll();
		return new ResponseEntity<Object> (listEnt,new HttpHeaders(),HttpStatus.OK);
	}

	@Override
	public ResponseEntity<?> addChartTypes(ChartTypesMasterEntity chartTypesMasterEntity) {
		if(chartTypesMasterEntity!=null) {
			repo.save(chartTypesMasterEntity);
			return new ResponseEntity<Object> (chartTypesMasterEntity,new HttpHeaders(),HttpStatus.OK);
		}
		return null;
	}

	@Override
	public ResponseEntity<?> editChartTypes(ChartTypesMasterEntity chartTypesMasterEntity) {
		if(chartTypesMasterEntity!=null) {
			repo.save(chartTypesMasterEntity);
			return new ResponseEntity<Object> (chartTypesMasterEntity,new HttpHeaders(),HttpStatus.OK);
		}
		return null;
	}

	@Override
	public ResponseEntity<?> deleteChartTypes(ChartTypesMasterEntity chartTypesMasterEntity) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
