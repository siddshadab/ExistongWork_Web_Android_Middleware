package com.infrasofttech.microfinance.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.DistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.entityBeans.SubDistrictsEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AreaHolder;
import com.infrasofttech.microfinance.repository.DistrictsRepository;
import com.infrasofttech.microfinance.services.AreaServices;
import com.infrasofttech.microfinance.services.DistrictsServices;
import com.infrasofttech.microfinance.services.StatesServices;
import com.infrasofttech.microfinance.services.SubDistrictsServices;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/area")
public class AreaController {

	
	@Autowired 
	AreaServices area;

	/*
	 * @PostMapping("/addSubDistricts/{districtsID}/") public ResponseEntity<?>
	 * createComment(@PathVariable (value = "districtsID") Long districtId,
	 * 
	 * @Valid @RequestBody SubDistrictsEntity entity) { return
	 * subdist.addSubDistricts(entity,districtId);
	 * 
	 * 
	 * }
	 */
	
	@GetMapping(value = "/getlistOfData", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return area.getArea();
	}
	
	@GetMapping(value ="/getFilteredlistOfData/{mlbrcd}/" , produces = "application/json") 
	 public ResponseEntity<?> getAll(@PathVariable (value = "mlbrcd") int mlbrcd){
		 return area.getArea(mlbrcd);
	 }
	
	@PostMapping(value="/addArea",produces="applcation/json")
	public ResponseEntity<?> addArea(@RequestBody AreaHolder areaHolder){
		if(null!= areaHolder) {
			return area.addArea(areaHolder);
		}
		return null;
	}
	
	@PostMapping(value="/editArea",produces="applcation/json")
	public ResponseEntity<?> editArea(@RequestBody AreaHolder areaHolder){
		if(null!= areaHolder) {
			return area.editArea(areaHolder);
		}
		return null;
	}
	
	@PostMapping(value="/deleteArea",produces="applcation/json")
	public ResponseEntity<?> deleteArea(@RequestBody AreaHolder areaHolder){
		if(null!= areaHolder) {
			return area.deleteArea(areaHolder);
		}
		return null;
	}

}
