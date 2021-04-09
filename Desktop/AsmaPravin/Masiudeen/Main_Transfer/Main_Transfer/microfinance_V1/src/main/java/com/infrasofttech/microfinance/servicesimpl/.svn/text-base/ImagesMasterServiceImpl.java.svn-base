package com.infrasofttech.microfinance.servicesimpl;

import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;
import com.infrasofttech.microfinance.repository.CustomerRepository;
import com.infrasofttech.microfinance.repository.ImageMasterRepository;
import com.infrasofttech.microfinance.services.ImageMasterService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


@Service
@Transactional
public class ImagesMasterServiceImpl implements ImageMasterService {
	@Autowired
	ImageMasterRepository imageMasterRepository;

	@Autowired
	CustomerRepository customerRepo;

	@Override
	public ResponseEntity<?> addImageList(List<ImageMasterEntity> customer) {
		try {	 

			return new ResponseEntity<Object>(imageMasterRepository.saveAll(customer),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	@Override
	public ResponseEntity<?> getAllCustomerImageData() {
		try {
			List<ImageMasterEntity> customerList=imageMasterRepository.findAll();
			if(customerList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<ImageMasterEntity>>(customerList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}


	@Override
	public ResponseEntity<?> addimage(@Valid List<ImageMasterEntity> entityList, int mCustRefno) {
		CustomerEntity customerEntity = (CustomerEntity) customerRepo.findByMrefno(mCustRefno);
		for(ImageMasterEntity entity : entityList ) {
			entity.setImageMasterEntity(customerEntity);	
			imageMasterRepository.save(entity);
		}

		return new ResponseEntity<String>("200",new HttpHeaders(),HttpStatus.CREATED);		

	}

	
	@Override
	public ResponseEntity<?> addimageAndStore(@Valid ImageMasterEntity entity, int mCustRefno) {
		CustomerEntity customerEntity = (CustomerEntity) customerRepo.findByMrefno(mCustRefno);		
			entity.setImageMasterEntity(customerEntity);	
			imageMasterRepository.save(entity);
	

		return new ResponseEntity<String>("200",new HttpHeaders(),HttpStatus.CREATED);		

	}

	
	 public ImageMasterEntity storeFile(@Valid ImageMasterEntity entityList,MultipartFile file,int  mCustRefno) {
		 CustomerEntity customerEntity = (CustomerEntity) customerRepo.findByMrefno(mCustRefno);
		 					
	        // Normalize file name
	        String fileName = StringUtils.cleanPath(file.getOriginalFilename());
	        System.out.println("Org file Name here is "+ file.getOriginalFilename());

	    /*    try {
	            // Check if the file's name contains invalid characters
	            if(fileName.contains("..")) {
	                throw new FileStorageException("Sorry! Filename contains invalid path sequence " + fileName);
	            }
*/
	        ImageMasterEntity entity = new ImageMasterEntity();
	        try {
	        	System.out.println("comin ibn my sys "+file.getBytes());
				entity.setImgString(file.getBytes());				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			entity.setImageMasterEntity(customerEntity);				
	        return imageMasterRepository.save(entity);

/*	            
	        } catch (IOException ex) {
	            throw new FileStorageException("Could not store file " + fileName + ". Please try again!", ex);
	        }
*/	    }


	@Override
	public ResponseEntity<?> getCustomerImages(int mrefno) {
		try {
			List<ImageMasterEntity> imagesList=imageMasterRepository.findByMrefno(mrefno);
			if(imagesList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<ImageMasterEntity>>(imagesList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	

	
}
