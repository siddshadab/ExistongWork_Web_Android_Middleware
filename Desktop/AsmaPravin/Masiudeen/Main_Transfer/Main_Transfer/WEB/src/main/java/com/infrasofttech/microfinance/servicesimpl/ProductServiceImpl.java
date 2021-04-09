package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.ProductComposieEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.ProductMasterHolder;
import com.infrasofttech.microfinance.repository.ProductRepository;
import com.infrasofttech.microfinance.repository.ProductRepository.ProductHolderInterface;
import com.infrasofttech.microfinance.services.ProductService;


@Service
@Transactional
public class ProductServiceImpl implements ProductService {


	@Autowired
	ProductRepository repo;


	@Transactional
	@Override
	public ResponseEntity<?> getAllProductData() {
		try {
			List<ProductEntity> productList=repo.findAll(Sort.by(Sort.Direction.DESC,"mcreateddt"));
			if(productList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(productList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	@Transactional
	@Override
	public ResponseEntity<?> getDataUserByLbrCode(int mlbrcode) {		
		try {

			List<ProductEntity> productList=repo.findBymlbrcode(mlbrcode);
			if(productList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<ProductEntity>>(productList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	@Override
	public ResponseEntity<?> addList(ProductEntity productEntity) {
		try {
			List<ProductEntity> prd = repo.findProduct(productEntity.getProductComposieEntity().getMlbrcode(),
					productEntity.getProductComposieEntity().getMprdcd());
			
			if((productEntity.getProductComposieEntity().getMlbrcode() != prd.get(0).getProductComposieEntity().getMlbrcode()  
					&& productEntity.getProductComposieEntity().getMprdcd() !=  prd.get(0).getProductComposieEntity().getMprdcd())){
				return new ResponseEntity<Object>(repo.save(productEntity),new HttpHeaders(),HttpStatus.CREATED);
			}else {
				return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.CONFLICT);
			}
			
		} catch (Exception e) {
		
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	public ResponseEntity<?> verifyProduct(ProductComposieEntity productComposieEntity) {
		List <ProductEntity> productList=null;		
		try {
			if(productComposieEntity !=null)
				productList = repo.findProduct(productComposieEntity.getMlbrcode(),
						productComposieEntity.getMprdcd());
			System.out.println(productList);
			 if(productList.isEmpty()) 
				 return ResponseEntity.notFound().build();				
			 	 return  new ResponseEntity<List<ProductEntity>>(productList,new HttpHeaders(),HttpStatus.OK);
			}
			
			catch(Exception e) {
		  		return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		   }	
	}

	@Override
	public ResponseEntity<?> addPrd(ProductMasterHolder productHodler) {
		try {
			
			ProductEntity productEnt = repo.findProd(productHodler.getMlbrcode(),productHodler.getMprdcd());
			System.out.println("prod ent"+productEnt);	
					if(productEnt ==null) {			
					ProductEntity prdEntity= new ProductEntity();			
					ProductComposieEntity prdComposite = new ProductComposieEntity();
						
					prdComposite.setMlbrcode(productHodler.getMlbrcode());		
					prdComposite.setMprdcd(productHodler.getMprdcd());
					
					prdEntity.setProductComposieEntity(prdComposite);
					prdEntity.setMcurcd(productHodler.getMcurcd());
					prdEntity.setMdivisiontype(productHodler.getMdivisiontype());
					prdEntity.setMintrate(productHodler.getMintrate());
					prdEntity.setMmoduletype(productHodler.getMmoduletype());
					prdEntity.setMname(productHodler.getMname());
					prdEntity.setMnoofguaranter(productHodler.getMnoofguaranter());
					prdEntity.setMcreatedby(productHodler.getMcreatedby());
					prdEntity.setMcreateddt(LocalDateTime.now());
					productHodler.setMerror(200);
					productHodler.setMerrormsg("Record added Successfully");
					repo.save(prdEntity);
					return new ResponseEntity<Object>(productHodler, new HttpHeaders(),HttpStatus.OK);			
				}else {
					productHodler.setMerror(409);
					productHodler.setMerrormsg("Record Already Exists");
					return new ResponseEntity<Object>(productHodler,new HttpHeaders(),HttpStatus.CONFLICT);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Object>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
			
	}

	@Override
	public ResponseEntity<?> updatePrd(ProductMasterHolder productHodler) {
		 try {
			ProductEntity prdEntity = new ProductEntity();
			
			 ProductComposieEntity prdCompo = new ProductComposieEntity();
			
			 prdCompo.setMlbrcode(productHodler.getMlbrcode());
			 prdCompo.setMprdcd(productHodler.getMprdcd());
			 
			 prdEntity.setProductComposieEntity(prdCompo);
			 
			 prdEntity.setMname(productHodler.getMname());
			 prdEntity.setMintrate(productHodler.getMintrate());
			 prdEntity.setMmoduletype(productHodler.getMmoduletype());
			 prdEntity.setMcurcd(productHodler.getMcurcd());
			 prdEntity.setMlastsynsdate(productHodler.getMlastsynsdate());
			 prdEntity.setMdivisiontype(productHodler.getMdivisiontype());
			 prdEntity.setMnoofguaranter(productHodler.getMnoofguaranter());
			 prdEntity.setMlastupdateby(productHodler.getMlastupdateby());
			 prdEntity.setMlastupdatedt(LocalDateTime.now());
			 productHodler.setMerror(200);
			 productHodler.setMerrormsg("Record Updated SuccessFully");
			 repo.save(prdEntity);
			 return new ResponseEntity<Object>(productHodler,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}

	@Override
	public ResponseEntity<?> deletePrd(List<ProductMasterHolder> code) {
			
			try {
				ProductMasterHolder hld = new ProductMasterHolder();
				
				for(int i=0;i<code.size();i++) {
					repo.deleteByBulk(code.get(i).getMlbrcode(),code.get(i).getMprdcd());	
				}		
				
				//repo.deleteByBulk(productHodler.getCode(), productHodler.getCode());
				hld.setMerror(200);
				hld.setMerrormsg("Record delete successfully");
				return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
			}
			
//		 try {
//			ProductEntity prdEntity = new ProductEntity();
//			
//			 ProductComposieEntity prdCompo = new ProductComposieEntity();
//			
//			 prdCompo.setMlbrcode(productHodler.getMlbrcode());
//			 prdCompo.setMprdcd(productHodler.getMprdcd());
//			 
//			 prdEntity.setProductComposieEntity(prdCompo);
//			 prdEntity.setMname(productHodler.getMname());
//			 prdEntity.setMintrate(productHodler.getMintrate());
//			 prdEntity.setMmoduletype(productHodler.getMmoduletype());
//			 prdEntity.setMcurcd(productHodler.getMcurcd());
//			 prdEntity.setMlastsynsdate(productHodler.getMlastsynsdate());
//			 prdEntity.setMdivisiontype(productHodler.getMdivisiontype());
//			 prdEntity.setMnoofguaranter(productHodler.getMnoofguaranter());
//			 repo.deleteByBulk(productHodler.getCompoEnt(),productHodler.getCompoEnt());
//			 productHodler.setMerror(200);
//			 productHodler.setMerrormsg("Record Deleted SuccessFully");
//			 
//			 //repo.deleteProduct(productHodler.getMlbrcode(), productHodler.getMprdcd());
//			 
//			 return new ResponseEntity<Object>(productHodler,new HttpHeaders(),HttpStatus.OK);
//		} catch (Exception e) {
//			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}
//		
	}

	@Override
	public ResponseEntity<?> getPrdCdDesc() {
		List<ProductHolderInterface> prdObj = repo.findByProductCd();
		try {					
			if(prdObj == null) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object> (prdObj,new HttpHeaders(),HttpStatus.OK);			
		} catch (Exception e) {				
			e.printStackTrace();
			return new ResponseEntity<> (new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
			
	}

	@Override
	public ResponseEntity<?> findByMlbrcode(ProductMasterHolder productHodler) {
		try {
			ProductEntity prdEnt = repo.findProd(productHodler.getMlbrcode(), productHodler.getMprdcd());
			
			if(prdEnt == null) {
				productHodler.setMerror(0);
				productHodler.setMerrormsg("null");
				return new ResponseEntity<Object>(productHodler,new HttpHeaders(),HttpStatus.OK);
			}else{
				productHodler.setMerror(200);
				productHodler.setMerrormsg("Product code and Branch Code Already Exists");
				return new ResponseEntity<Object>(productHodler,new HttpHeaders(),HttpStatus.OK);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	
	
}