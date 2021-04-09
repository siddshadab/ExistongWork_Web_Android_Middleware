package com.infrasofttech.microfinance.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;
import com.infrasofttech.microfinance.servicesimpl.ImagesMasterServiceImpl;
import com.sun.istack.NotNull;

@RestController
@RequestMapping("/customerImagesMaster")
public class ImageMasterController {
	
	@Autowired
	ImagesMasterServiceImpl imagesMasterServiceImpl;
	
	
	@GetMapping(value = "/getlistOfImages", produces = "application/json")
	public ResponseEntity<?> getAll(){
		return imagesMasterServiceImpl.getAllCustomerImageData();
	}
	
	
	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<?>  addlist(@RequestBody List<ImageMasterEntity> customer){
		if(null != customer)
			return imagesMasterServiceImpl.addImageList(customer);
		return null;
	}
	


	
	 
	 @PostMapping("/addImage/{mCustRefno}")
	 public ResponseEntity<?> addMultiLineImagesDetails(@PathVariable (value = "mCustRefno") int mCustRefno ,
	                                 @Valid @RequestBody List<ImageMasterEntity> entity) {		 
		 /*CustomerCompositePrimaryEntity compositeCustomerEntity = new CustomerCompositePrimaryEntity();
		 compositeCustomerEntity.setCustomerNumberOfTab(customerIdOfTab);
		 compositeCustomerEntity.setUsrCode(customerUsrCode);*/
		 return imagesMasterServiceImpl.addimage(entity, mCustRefno)	;			
	        
	    }
	 
	 
	 
	 @PostMapping(value = "/addImageInJson/{mCustRefno}")
	 public ResponseEntity<?> addMultiLineImagesDetails(@PathVariable (value = "mCustRefno") int mCustRefno ,
	                                 @Valid @RequestBody ImageMasterEntity entity) {		 
/*		 CustomerCompositePrimaryEntity compositeCustomerEntity = new CustomerCompositePrimaryEntity();
		 compositeCustomerEntity.setCustomerNumberOfTab(customerIdOfTab);
		 compositeCustomerEntity.setUsrCode(customerUsrCode);*/
		 return imagesMasterServiceImpl.addimageAndStore(entity, mCustRefno)	;			
	        
	    }
	 
	 
	 @ExceptionHandler({Exception.class})
	 public void resolveException(Exception e) {
	     e.printStackTrace();
	 }
	 
		
/*	 @PostMapping("/uploadMultipleFiles/{customerIdOfTab}/{customerUsrCode}")
	    public ResponseEntity<?> uploadMultipleFiles(@PathVariable (value = "customerIdOfTab") long customerIdOfTab ,@PathVariable (value = "customerUsrCode") String customerUsrCode , @RequestParam("imgString") MultipartFile[] filesData) {
	        return Arrays.asList(filesData)
	                .stream()
	                .map(file -> uploadFile(file))
	                .collect(Collectors.toList());
	    }*/
	 
/*	   @RequestMapping(value = "/uploadFile/{customerIdOfTab}/{customerUsrCode}/" ,  headers = ("content-type=multipart/form-data;boundary=032a1ab685934650abbe059cb45d6ff3"), method = RequestMethod.POST)
	    public String uploadFile(@PathVariable (value = "customerIdOfTab") long customerIdOfTab ,@PathVariable (value = "customerUsrCode") String customerUsrCode , @RequestParam("imgString") MultipartFile filesData) {
		   System.out.println("byters data hawa baba "+filesData.getContentType().toString());
		   ImageMasterEntity entity = new ImageMasterEntity();
			 CustomerCompositePrimaryEntity compositeCustomerEntity = new CustomerCompositePrimaryEntity();
			 compositeCustomerEntity.setCustomerNumberOfTab(customerIdOfTab);
			 compositeCustomerEntity.setUsrCode(customerUsrCode);
		   ImageMasterEntity dbFile = imagesMasterServiceImpl.storeFile(entity,filesData,compositeCustomerEntity);
		   	return "yes dumped by me ";
	        String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
	                .path("/downloadFile/")
	                .path(dbFile.getId())
	                .toUriString();

	        return new UploadFileResponse(dbFile.getFileName(), fileDownloadUri,
	                file.getContentType(), file.getSize());
	    }*/
	 
	 
    
	 
	 @RequestMapping(value = "/uploadFile/{mCustRefno}" ,method = RequestMethod.POST, consumes = "application/octet-stream")
	    public String uploadFile(@PathVariable (value = "mCustRefno") int mCustRefno ,@RequestPart("properties") @Valid ImageMasterEntity entity, @RequestPart("imgStringFile") @Valid @NotNull @NotBlank MultipartFile file,
	                                   RedirectAttributes redirectAttributes) {

		  System.out.println("byters data hawa baba "+file.getContentType().toString());
	        if (file.isEmpty()) {
	            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
	            return "redirect:uploadStatus";
	        }

			   System.out.println("byters data hawa baba "+file.getContentType().toString());
			  
			/*	 CustomerCompositePrimaryEntity compositeCustomerEntity = new CustomerCompositePrimaryEntity();
				 compositeCustomerEntity.setCustomerNumberOfTab(customerIdOfTab);
				 compositeCustomerEntity.setUsrCode(customerUsrCode);*/
			   ImageMasterEntity dbFile = imagesMasterServiceImpl.storeFile(entity,file,mCustRefno);
	        
	        try {

	            // Get the file and save it somewhere
	            byte[] bytes = file.getBytes();
	            Path path = Paths.get("c://" + file.getOriginalFilename());
	            Files.write(path, bytes);

	            redirectAttributes.addFlashAttribute("message",
	                    "You successfully uploaded '" + file.getOriginalFilename() + "'");

	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	        return "redirect:/uploadStatus";
	    }


	 
	 
}
