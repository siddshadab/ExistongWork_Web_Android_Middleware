package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.holder.Cgt1HolderBean;

public interface CGT1Service {
	
	public ResponseEntity<?> getAllCGT1Data();
	
	public ResponseEntity<?> addList(List<CGT1Entity> cgt1);
	
	public ResponseEntity<?> addCgt1ListByHolder(List<Cgt1HolderBean> cgt1list);
}
