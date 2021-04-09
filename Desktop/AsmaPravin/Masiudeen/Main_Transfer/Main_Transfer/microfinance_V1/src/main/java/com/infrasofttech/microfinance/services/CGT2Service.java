package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CGT2Entity;
import com.infrasofttech.microfinance.entityBeans.master.holder.Cgt2HolderBean;

public interface CGT2Service {
	
	public ResponseEntity<?> getAllCGT2Data();

	public ResponseEntity<?> addList(List<CGT2Entity> cgt2);

	public ResponseEntity<?> addCgt2ListByHolder(List<Cgt2HolderBean> cgt2list);
}
