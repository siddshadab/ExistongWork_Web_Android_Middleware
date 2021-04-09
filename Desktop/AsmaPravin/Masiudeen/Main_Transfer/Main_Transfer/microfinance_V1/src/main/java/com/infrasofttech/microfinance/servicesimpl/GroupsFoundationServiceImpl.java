package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;
import com.infrasofttech.microfinance.repository.GroupsFoundationsRepository;
import com.infrasofttech.microfinance.services.GroupsFoundationService;


@Service
@Transactional
public class GroupsFoundationServiceImpl implements GroupsFoundationService{

	@Autowired
	GroupsFoundationsRepository GroupFoundationRepo;
	
	@Override	
	public ResponseEntity<?> getAllUsersData() {
		try {
			List<GroupsFoundationEntity> groupList=GroupFoundationRepo.findAll();
			if(groupList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<GroupsFoundationEntity>>(groupList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
	}
	
	
	@Transactional
	@Override
		public ResponseEntity<?> addList(List<GroupsFoundationEntity> group) {

		try {
			
			List<GroupsFoundationEntity> returningEntity = new  ArrayList<GroupsFoundationEntity>();
			for( GroupsFoundationEntity grpEntity : group ) {
				
				if(grpEntity.getMcenterid()==0&&grpEntity.getMrefno()!=0) {
					GroupsFoundationEntity grp  = GroupFoundationRepo.findBymrefno(grpEntity.getMrefno());
					if(grp!=null&&grp.getMcenterid()!=0) {
						grpEntity.setMcenterid(grp.getMcenterid());
						returningEntity.add(grp);
					}
					else {
						returningEntity.add(grpEntity);	
					}
					
					
					
				}else {
					
					returningEntity.add(grpEntity);
					
				}
				
			}
			
			
			return new ResponseEntity<Object>(GroupFoundationRepo.saveAll(returningEntity),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

/*	@Override
	public ResponseEntity<?> getDataUserByMrefno(int mrefno) {
		try {
			List<GroupsFoundationEntity> GroupList=GroupFoundationRepo.findByMrefno(mrefno);
			if(GroupList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<GroupsFoundationEntity>>(GroupList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}*/
	

	@Transactional
	@Override
	public ResponseEntity<?> getDataByCreatedBy(String mCreatedBy) {
		try {
			List<GroupsFoundationEntity> GroupList=GroupFoundationRepo.findByMcreatedBy(mCreatedBy);
			if(GroupList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<GroupsFoundationEntity>>(GroupList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	
	@Transactional
	@Override
	public ResponseEntity<?> getDataByMcreatedByAndMlbrCode(String mCreatedBy, int mLbrcode) {
		try {
			List<GroupsFoundationEntity> GroupList=GroupFoundationRepo.findByMcreatedByAndMlbrCode(mCreatedBy,mLbrcode);
			if(GroupList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<GroupsFoundationEntity>>(GroupList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	@Transactional
	@Override
	public List<GroupsFoundationEntity> isDataSynced(int isDataSynced) {
		System.out.println("Inside is Data Synced");
		List<GroupsFoundationEntity> groupsFoundation = null;
		try {
			groupsFoundation = new ArrayList<GroupsFoundationEntity>();
			System.out.println("groupsFoundation" + groupsFoundation);
			groupsFoundation = GroupFoundationRepo.findDataByisDataSynced(isDataSynced);
			System.out.println("groupsFoundation1" + groupsFoundation);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return groupsFoundation;
	}
	
	
	
	@Transactional
	public int updateGroupsFoundation(int mrefno, int mgroupid) {
		System.out.println("Inside Update Groups Foundation");
		int isGroupsFoundationUpdated = 0;
		try {
			System.out.println("isGroupsFoundationUpdated" + isGroupsFoundationUpdated);
			isGroupsFoundationUpdated = GroupFoundationRepo.updateGroupsFoundation(mrefno, mgroupid);

		} catch (Exception e) {
			System.out.println("dhsgfgfgffvccdcjdj");
			return isGroupsFoundationUpdated;
		}
		return isGroupsFoundationUpdated;
	}
	
	@Transactional
	@Override
	public int updateGroupsErrorfromOmni(int mGroupRefNo, String errorFromOmni) {
		System.out.println("Group Error :( " + errorFromOmni);
		System.out.println("mrefno :( " + mGroupRefNo);
		
		int isGroupListUpdated = 0;
		try {
			System.out.println("Try Me");
			LocalDateTime updatedDt = LocalDateTime.now();
			isGroupListUpdated = GroupFoundationRepo.updateGroupsErrorfromOmni(mGroupRefNo, errorFromOmni, updatedDt);

		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return isGroupListUpdated;
		}
		return isGroupListUpdated;
	}
	
	@Transactional
	@Override
	public GroupsFoundationEntity findByTrefAndMcreatedByAndIsSynced(int trefNo, String mCreatedBy, int mrefno,
			int isSynced) {
		GroupsFoundationEntity group = new GroupsFoundationEntity();
		try {


			group = GroupFoundationRepo.findByTrefAndMcreatedByAndIsSynced(trefNo, mCreatedBy,mrefno, isSynced);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return group;
	}
	
	@Transactional
	@Override
	public int updateCenterInGroupDetails(int mrefno,int centerNumberOfCore,LocalDateTime updatedDateTime) {
		int isGroupUpdated = 0 ;
		try {

			isGroupUpdated = GroupFoundationRepo.updateCenterInGroupDetails(mrefno,centerNumberOfCore,updatedDateTime);

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return isGroupUpdated;
		}
		return isGroupUpdated;
	}
	


	@Transactional
	public int updateGroupDeatilsWithCenterID(int mrefno, int mgroupid,int centerid) {
		System.out.println("Inside Update Groups Foundation");
		int isGroupsFoundationUpdated = 0;
		try {
			System.out.println("isGroupsFoundationUpdated" + isGroupsFoundationUpdated);
			isGroupsFoundationUpdated = GroupFoundationRepo.updateGroupsFoundationWithCenterID(mrefno, mgroupid,centerid);

		} catch (Exception e) {
			System.out.println("dhsgfgfgffvccdcjdj");
			return isGroupsFoundationUpdated;
		}
		return isGroupsFoundationUpdated;
	}
	

	
	
}
