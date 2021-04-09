package com.infrasofttech.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;
import com.infrasofttech.microfinance.services.GroupsFoundationService;

@RestController
@RequestMapping("/createGroupsFoundations")
public class GroupsFoundationsController {
	
	@Autowired 
	GroupsFoundationService groupsFoundationService;
	
	
	@GetMapping(value = "/getlistOfGroupData", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return groupsFoundationService.getAllUsersData();
	}
	
	
	@PostMapping(value = "/addGroup", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<GroupsFoundationEntity> group){
		if(null != group)
			return groupsFoundationService.addList(group);;
		return null;
	}
	
	
	
	
	
	
	  @PostMapping(value = "/getGroupDataByCreatedBy", produces =
	  "application/json")	 
	public ResponseEntity<?>  getDataByMcreatedBy(@RequestBody GroupsFoundationEntity group){
		if(null != group) {
			return groupsFoundationService.getDataByCreatedBy(group.getMcreatedby());
		}
		return null;
	}
	
	  
	  @PostMapping(value = "/getGroupDataByCreatedByAndMlbrCode", produces =
			  "application/json")	 
			public ResponseEntity<?>  getDataByMcreatedByAndMlbrCode(@RequestBody GroupsFoundationEntity group){
				if(null != group) {
					return groupsFoundationService.getDataByMcreatedByAndMlbrCode(group.getMcreatedby(),group.getMlbrcode());
				}
				return null;
			}
	

/*	@PostMapping(value = "/getGroupDataByAgentUserNameAndIdAndCenterName", produces = "application/json")
	public ResponseEntity<?>  getDataByAgentUserNameAndIdAndGroupName(@RequestBody GroupsFoundationEntity group){
		if(null != group) {
			return groupsFoundationService.getDataByGroupNumberAndCenterCodeAndAgentUserName(group.getGroupNumber(),group.getCenterCode(),group.getAgentUserName());
		}
		return null;
	}*/
}
