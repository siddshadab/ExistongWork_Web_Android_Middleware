package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.CentersFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;
import com.infrasofttech.microfinance.repository.CentersFoundationsRepository;
import com.infrasofttech.microfinance.services.CentersFoundationService;

@Service
@Transactional
public class CentersFoundationServiceImpl implements CentersFoundationService {

	@Autowired
	CentersFoundationsRepository centerFoundationRepo;

	@Transactional
	@Override
	public ResponseEntity<?> getAllUsersData() {
		try {
			List<CentersFoundationEntity> centerList = centerFoundationRepo.findAll();
			if (centerList.isEmpty())
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CentersFoundationEntity>>(centerList, new HttpHeaders(), HttpStatus.OK);
		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	@Transactional
	@Override
	public ResponseEntity<?> addList(List<CentersFoundationEntity> centerList) {

		/*
		 * try {
		 */
		System.out.println("Yhan aaya");
		System.out.println(centerList.toString());

		return new ResponseEntity<Object>(centerFoundationRepo.saveAll(centerList), new HttpHeaders(),
				HttpStatus.CREATED);
		/*
		 * } catch (Exception e) {
		 * //logger.error("Error While Persisting Object"+e.getMessage()); return new
		 * ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY); }
		 */
	}

	@Transactional
	@Override
	public ResponseEntity<?> getDataByCreatedBy(String mCreatedBy) {
		try {
			List<CentersFoundationEntity> centerList = centerFoundationRepo.findByMcreatedBy(mCreatedBy);
			if (centerList.isEmpty())
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CentersFoundationEntity>>(centerList, new HttpHeaders(), HttpStatus.OK);
		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> getDataUserByMcenterNameAndMrefno(String mcentername, int mrefno) {
		try {
			List<CentersFoundationEntity> centerList = centerFoundationRepo.findByMcenternameAndMrefno(mcentername,
					mrefno);
			if (centerList.isEmpty())
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CentersFoundationEntity>>(centerList, new HttpHeaders(), HttpStatus.OK);
		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> getDataByMcreatedByAndMlbrCode(String mCreatedBy, int mLbrcode) {
		try {
			List<CentersFoundationEntity> centerList = centerFoundationRepo.findByMcreatedByAndMlbrCode(mCreatedBy,
					mLbrcode);
			if (centerList.isEmpty())
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<CentersFoundationEntity>>(centerList, new HttpHeaders(), HttpStatus.OK);
		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public List<CentersFoundationEntity> isDataSynced(int isDataSynced) {
		System.out.println("Inside is Data Synced");
		List<CentersFoundationEntity> centersFoundation = null;
		try {
			centersFoundation = new ArrayList<CentersFoundationEntity>();
			centersFoundation = centerFoundationRepo.findDataByisDataSynced(isDataSynced);
			System.out.println("centers Foundation 1ist is " + centersFoundation);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return centersFoundation;
	}

	@Transactional
	public int updateCentersFoundation(int mrefno, int mcenterid) {
		System.out.println("Inside Update Centers Foundation");
		int isCentersFoundationUpdated = 0;
		try {
			System.out.println("isCentersFoundationUpdated" + isCentersFoundationUpdated);
			isCentersFoundationUpdated = centerFoundationRepo.updateCentersFoundation(mrefno, mcenterid);

		} catch (Exception e) {
			System.out.println("dhsgfvccdcjdj");
			return isCentersFoundationUpdated;
		}
		return isCentersFoundationUpdated;
	}

	@Transactional
	@Override
	public int updateCentersErrorfromOmni(int mCenterRefNo, String errorFromOmni) {
		System.out.println("Center Error :( " + errorFromOmni);
		int isCentersListUpdated = 0;
		try {
			System.out.println("Try Me");
			LocalDateTime updatedDt = LocalDateTime.now();
			isCentersListUpdated = centerFoundationRepo.updateCentersErrorfromOmni(mCenterRefNo, errorFromOmni,
					updatedDt);

		} catch (Exception e) {
			// logger.error("No Record Found."+e.getMessage());
			return isCentersListUpdated;
		}
		return isCentersListUpdated;
	}

	@Transactional
	@Override
	public CentersFoundationEntity findByTrefAndMcreatedByAndIsSynced(int trefNo, String mCreatedBy, int mrefno,
			int isSynced) {
		CentersFoundationEntity center = new CentersFoundationEntity();
		try {

			center = centerFoundationRepo.findByTrefAndMcreatedByAndIsSynced(trefNo, mCreatedBy, mrefno, isSynced);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return center;
	}

}
