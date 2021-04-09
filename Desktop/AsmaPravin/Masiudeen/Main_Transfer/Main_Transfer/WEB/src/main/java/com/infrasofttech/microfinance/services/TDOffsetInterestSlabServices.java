package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.holder.TDOffsetInterstSlabHolder;

public interface TDOffsetInterestSlabServices {

	public ResponseEntity<?> getAllTDOffsetInterestSlabData() ;

	public ResponseEntity<?> addTDOffsetInterest(TDOffsetInterstSlabHolder tdOffsetInterestHld);
	
	public ResponseEntity<?> updateTDOffsetInterest(TDOffsetInterstSlabHolder tdOffsetInterestHld);
	
	public ResponseEntity<?> deleteTDOffsetInterest(TDOffsetInterstSlabHolder tdOffsetInterestHld);
}
