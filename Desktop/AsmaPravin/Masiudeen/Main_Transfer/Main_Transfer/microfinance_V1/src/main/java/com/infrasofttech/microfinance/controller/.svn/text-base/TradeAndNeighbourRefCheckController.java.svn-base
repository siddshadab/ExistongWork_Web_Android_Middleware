package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCPVBusinessRecordEntity;
import com.infrasofttech.microfinance.entityBeans.master.TradeAndNeighbourRefCheckEntity;
import com.infrasofttech.microfinance.services.TradeAndNeighbourRefCheckService;

@RestController
@RequestMapping("/tradeAndNeighbourRefCheck")
public class TradeAndNeighbourRefCheckController {
	
	@Autowired 
	TradeAndNeighbourRefCheckService service;
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<TradeAndNeighbourRefCheckEntity> group){
		if(null != group)
			return service.addList(group);;
		return null;
	}
	
	@PostMapping(value = "/getTrcNrcByCreatedByAndLastSyncedTiming",produces = "application/json")
	public ResponseEntity<?>  getTrcNrcList(@RequestBody TradeAndNeighbourRefCheckEntity  trcNrcEntity){
		
	System.out.println("syncing method me aa rha hai..."); 
	
	if(null != trcNrcEntity.getMcreatedby()) {
			
		  System.out.println(trcNrcEntity.getMlastsynsdate()!=null ?  trcNrcEntity.getMlastsynsdate():"printng yha aa gya");
		  
		  return  service.findByCreatedByAndLastSyncedTime(trcNrcEntity);
	  }
	
	  return null; 
 }
	
}
