package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.infrasofttech.microfinance.entityBeans.master.JsonMenuEntity;
import com.infrasofttech.microfinance.entityBeans.master.MenuMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccressRightsCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.JsonMenuMasterHolder;
import com.infrasofttech.microfinance.repository.MenuMasterRepository;
import com.infrasofttech.microfinance.repository.UserAccressRightsRepository;
import com.infrasofttech.microfinance.services.MenuMasterService;


@Service
@Transactional
public class MenuMasterServiceImpl implements MenuMasterService {


	@Autowired
	MenuMasterRepository repo;


	@Autowired
	UserAccressRightsRepository repo1;

	@Transactional
	@Override
	public ResponseEntity<?> getAllMenusFromMasterData() {
		try {
			List<MenuMasterEntity> menuMasterEntity=repo.findAll();
			if(menuMasterEntity.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<MenuMasterEntity>>(menuMasterEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	@Override
	public ResponseEntity<?> addList(MenuMasterEntity menuMasterEntity) {
		try {
			return new ResponseEntity<Object>(repo.save(menuMasterEntity),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

//	List<List<MenuMasterEntity>> retList = new ArrayList<List<MenuMasterEntity>>();
//	List<MenuMasterEntity> retAdd = new ArrayList<MenuMasterEntity>();
//	
//	public String menuByGrpCd(UserAccessRightsEntity userAccessRightsEntity) {
//
//		
//		List<JsonMenuEntity> listJsonEntity = new ArrayList<JsonMenuEntity>();
//		
//		//TODO getFromRepository
//		//listJsonEntity = 
//		
//		
//		List<MenuMasterEntity> mainMet = repo.findByParIdMenu(0);	//got master 	
//		
//		menuTreeString=menuTreeString+"\n[\n";	
//		menuTreeString=menuTreeString+"\n{\n";
//		//int incrt =0;
//		//for(MenuMasterEntity met :mainMet) {
//		for(int incrt =0;incrt< mainMet.size();incrt++ ) {	
//				retAdd.add(mainMet.get(incrt));
//				menuTreeString=menuTreeString+"\n"+"\""+mainMet.get(incrt).getMenudesc()+"\""+":[{";				
//				createMenuItem(mainMet.get(incrt).getMenuid());
//				if(mainMet.size()-1==incrt){
//					System.out.println("Coming     xxxxxxxxxxxxxxx");
//					menuTreeString=menuTreeString+"}]";
//				}else {
//					menuTreeString=menuTreeString+"}],";
//				}
//				
//		}	
//		 menuTreeString=menuTreeString+"\n}\n";
//		 menuTreeString=menuTreeString+"\n]\n";
//
//		
//		 System.out.println("JsonStering "+menuTreeString);
//		
//		 //return"";
//		  Gson gson = new GsonBuilder()
//		                 .setPrettyPrinting()
//		                 .create(); 
//		 System.out.println(gson.toJson(menuTreeString));
//		 return gson.toJson(menuTreeString);
//
//	}
//
//	 String menuTreeString="";
//	 String intendation="\t";
//	public void createMenuItem(int parentMenuId) {
//
//		List<MenuMasterEntity> parentList = null;			
//		parentList= repo.findByParIdMenu(parentMenuId);
//
//		if(parentList.size()==0)
//		{
//			return;
//		}
//
//		// menuTreeString=menuTreeString+"\n[\n";
//		for(int par=0;par<parentList.size();par++) {			
//			 //menuTreeString=menuTreeString+"\n{"+parentList.get(par).getMenudesc();
//				menuTreeString=menuTreeString+"\n"+"\""+parentList.get(par).getMenudesc()+"\""+":[{";		
//			int currentMenuId=parentList.get(par).getMenuid();
//			parentList= repo.findByParIdMenu(parentMenuId);
//			if(parentList.size()!=0) {
//				createMenuItem(currentMenuId);
//			}
//			
//			if(parentList.size()-1==par){
//				System.out.println("Coming     xxxxxxxxxxxxxxx");
//				menuTreeString=menuTreeString+"}]";
//			}else {
//				menuTreeString=menuTreeString+"}],";
//			}
//		
//
//		}
//		 intendation=intendation+"\t";
//		 // menuTreeString=menuTreeString+"\n]\n";
//		 System.out.println(menuTreeString);
//	}
//

}
