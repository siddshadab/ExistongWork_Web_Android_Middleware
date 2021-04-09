package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.JsonMenuEntity;
import com.infrasofttech.microfinance.entityBeans.master.TestMasterEntity;
import com.infrasofttech.microfinance.repository.JsonMenuRepository;
import com.infrasofttech.microfinance.repository.MenuMasterRepository;
import com.infrasofttech.microfinance.repository.MenuMasterRepository.JsonMenuMasterHolderInterface;
import com.infrasofttech.microfinance.repository.TestMasterRepo;
import com.infrasofttech.microfinance.services.TestMasterService;


@Service
@Transactional
public class TestMasterServiceImpl implements TestMasterService{
	
	@Autowired
	TestMasterRepo repo;

	List<String> child = new ArrayList<String>();
	JSONObject json = new JSONObject();
			
	public String getTestMaster() {
		List<TestMasterEntity> listMaster = new ArrayList<TestMasterEntity>();
		
		List<TestMasterEntity> main = new ArrayList<TestMasterEntity>();
			
		//testing code				
//		List<TestMasterEntity> ListByPar = repo.findByParId(0);
//		
//		System.out.println("hirarachy" +repo.getHirachy());
//		
//		for(int incrt =0;incrt< ListByPar.size();incrt++ ) {			
//			if(ListByPar.get(incrt).getParentid()==0)
//				child.add(ListByPar.get(incrt).getTitle());	
//				createMenuItem(ListByPar.get(incrt).getCategoryid());
//		}
//		
//		System.out.println("child with 0 parId"+child);
//
//		return json.toString();
//	}
//
//	public String createMenuItem(int parentMenuId) {
//
//		List<TestMasterEntity> subList =new ArrayList<TestMasterEntity>();			
//		
//		subList= repo.findByParId(parentMenuId);
//		
//		if(subList.size()==0)
//		{
//			return null;
//		}			
//		
//
//		for(int par=0;par<subList.size();par++) {			
//			if(subList.get(par).getParentid() == parentMenuId) {
//				child.add(subList.get(par).getTitle());
//
//			}
//			int currentMenuId = subList.get(par).getCategoryid();			
//			subList= repo.findByParId(parentMenuId);
//			
//			if(subList.size()!=0) {				
//				createMenuItem(currentMenuId);
//			}			
//		}	
//		
//		
//		for(int par=0;par<subList.size();par++) {			
//			if(subList.get(par).getParentid() == parentMenuId) {
//				child.add(subList.get(par).getTitle());
//
//			}
//			int currentMenuId = subList.get(par).getCategoryid();			
//			subList= repo.findByParId(parentMenuId);
//			
//			if(subList.size()!=0) {				
//				createMenuItem(currentMenuId);
//			}			
//		}	
//		
//		System.out.println("allData"+child);
//		
//		
//		for(int j = child.size() - 1;j > 0;j--) {
//		
//			JSONObject obj = new JSONObject();			
//			if(j == child.size() - 1) {					
//				obj.put(child.get(j),"");
//				json.put(child.get(j-1), obj);				
//			}else{
//				obj.put(child.get(j-1), json);
//				json = obj;
//			}
//					
//		}
//		
//		System.out.println("json is"+ json);
//		
//		return json.toString();
		//end testing code
//		return null;

		int k=0;

		List<TestMasterEntity> dataByCatId = repo.findByCatId(k);			
		
		List<TestMasterEntity> parentList = null;	

		List<String> masterList = new ArrayList<String>();	

		int catId = dataByCatId.get(0).getCategoryid();

		
		if(dataByCatId.get(0).getParentid() == 0) {
			String master = dataByCatId.get(0).getTitle();
			masterList.add(master);				 
		}	
			
		for(int i=0;catId!=0;i++) {	

			parentList = repo.findByParId(catId);
			System.out.println("Parent List "+parentList);
				
			try{
				catId= parentList.get(0).getCategoryid();
					
			}catch(Exception e) {
					break;
			}						
				
			String parent = parentList.get(0).getTitle();	
			System.out.println("Parent "+parent);				
			masterList.add(parent);
		}
		System.out.println("MasterList"+masterList);		
			
		JSONObject json = new JSONObject();
		
		
		for(int j = masterList.size() - 1;j > 0;j--) {
			JSONObject obj = new JSONObject();
			
			if(j == masterList.size() - 1) {
					
				obj.put(masterList.get(j),"");
				json.put(masterList.get(j-1), obj);
				
			}else{
				obj.put(masterList.get(j-1), json);
				json = obj;
			}
					
		}
		System.out.println("Final Json"+json);		
			
	
		return json.toString();

			
	}

	

				
	
	List<TestMasterEntity> parentList = new ArrayList<TestMasterEntity>();	

	List<String> masterList = new ArrayList<String>();	
	@Override
	public String getAllTitle(TestMasterEntity testMasterEntity) {
		
		// testing
		List<TestMasterEntity> dataByCatId = repo.findByCatId(testMasterEntity.getCategoryid());	

		int catId = dataByCatId.get(0).getCategoryid();

		if(dataByCatId.get(0).getParentid() == 0) {
			String master = dataByCatId.get(0).getTitle();
			masterList.add(master);				 
		}	
			
		for(int i=0;catId!=0;i++) {	

			parentList = repo.findByParId(catId);
			System.out.println("Parent List "+parentList);
				
			try{
				catId= parentList.get(0).getCategoryid();
					
			}catch(Exception e) {
				
				break;
		}						
			int menuId= parentList.get(0).getCategoryid();
			String parent = parentList.get(0).getTitle();	
			System.out.println("Parent "+parent);				
			masterList.add(parent);
			formMenu(menuId);	
		}
		
		
		System.out.println("MasterList"+masterList);		
			
		JSONObject json = new JSONObject();
		
		
		for(int j = masterList.size() - 1;j > 0;j--) {
			JSONObject obj = new JSONObject();
			
			if(j == masterList.size() - 1) {
					
				obj.put(masterList.get(j),"");
				json.put(masterList.get(j-1), obj);
				
			}else{
				obj.put(masterList.get(j-1), json);
				json = obj;
			}					
		}
		System.out.println("Final Json"+json);		
		return json.toString();

	}

	private void formMenu(int menuId) {
		parentList = repo.findByParId(menuId);
		String parentA = parentList.get(0).getTitle();	
		System.out.println("Parent "+parentA);				
		masterList.add(parentA);
		int menu= parentList.get(0).getCategoryid();
		formMenu(menu);
		
	}

	@Override
	public String menuByGrpCd() {
		// TODO Auto-generated method stub
		return null;
	}
		
		
				
//		List<TestMasterEntity> dataByCatId = repo.findByCatId(testMasterEntity.getCategoryid());
//		System.out.println("data by catId "+dataByCatId);
//		
//		ArrayList<String> masterList = new ArrayList<String>();		
//		
//		List<TestMasterEntity> parentList = null;
//		
//		ArrayList<String> mainList = new ArrayList<String>();
//		
//		int catId = dataByCatId.get(0).getCategoryid();
//		if(dataByCatId.get(0).getParentid() == 0) {
//			String master = dataByCatId.get(0).getTitle();
//			masterList.add(master);
//			}
//			for(int i=0;catId!=0;i++) {			
//				parentList = repo.findByParId(catId);
//				try{
//					catId= parentList.get(0).getCategoryid();
//					
//				}catch(Exception e) {
//					break;
//				}
//				
//				System.out.println("ParentList "+parentList);				
//				
//				String parent = parentList.get(0).getTitle();	
//				mainList.add(parent);				
//			}		
//			masterList.addAll(mainList);
//			JSONObject json = new JSONObject();
//			
//			for(int i=0;i<masterList.size();i++) {
//				//json.put(masterList.get(i)., value)
//			}
//			
//			System.out.println("MasterList " +masterList);
//			return null;
	
	}
