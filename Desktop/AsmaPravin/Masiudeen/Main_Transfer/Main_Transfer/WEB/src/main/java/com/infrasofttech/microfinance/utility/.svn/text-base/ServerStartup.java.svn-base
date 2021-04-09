package com.infrasofttech.microfinance.utility;

import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.util.json.JSONParser;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.infrasofttech.microfinance.entityBeans.master.JsonMenuEntity;
import com.infrasofttech.microfinance.repository.JsonMenuRepository;
import com.infrasofttech.microfinance.repository.MenuMasterRepository;
import com.infrasofttech.microfinance.repository.MenuMasterRepository.JsonMenuMasterHolderInterface;

@Component
public class ServerStartup implements ApplicationRunner {

	private MenuMasterRepository menuRepo;
	private	JsonMenuRepository jsonRepo;
	
	private String menuTreeString="";
	private String intendation="\t";
	
	
	private List<List<JsonMenuMasterHolderInterface>> retList = new ArrayList<List<JsonMenuMasterHolderInterface>>();
	private List<JsonMenuMasterHolderInterface> retAdd = new ArrayList<JsonMenuMasterHolderInterface>();
	private List<JsonMenuMasterHolderInterface> jsoHolder = new ArrayList<JsonMenuMasterHolderInterface>();	

	
	
	@Autowired
	public ServerStartup(MenuMasterRepository menuRepo,JsonMenuRepository jsonRepo) {	
		this.menuRepo = menuRepo;
		this.jsonRepo = jsonRepo;
		
	}


	public void run(ApplicationArguments args) {  	
		
		selectAndInsertUserAccessToJsonMenu();
		callAndGenerateJsonAndUpdate();
		//truncateJsonMenuMaster();

	}

	private void truncateJsonMenuMaster() {
		jsonRepo.trucateJson();

	}
	
	private  void selectAndInsertUserAccessToJsonMenu() {    	
		List<JsonMenuEntity> jsonMenuEntity=jsonRepo.selectDistinct();			
		saveAllJsonMenu(jsonMenuEntity);   	

	}

	private  void callAndGenerateJsonAndUpdate() {

		List<JsonMenuEntity> listJsonEntity = findMenu();			
		menuByGrpCd(listJsonEntity);//all distinct menu,from groupcd , user code
	}

	public void saveAllJsonMenu(List<JsonMenuEntity> jsonMenuEntity) {
		try {			
			jsonRepo.saveAll(jsonMenuEntity);			

		}catch(Exception e) {


		}
	}


	public  List<JsonMenuEntity> findMenu(){
		return jsonRepo.findMenu();
	}


	public void menuByGrpCd(List<JsonMenuEntity> listJsonEntity) {

		List<JsonMenuEntity> retListEnt = new ArrayList<JsonMenuEntity>();
		JSONObject json = new JSONObject();
		//TODO select * on jsonMenuRepo below array initialize

		// listJsonEntity = new ArrayList<JsonMenuEntity>();
		// List<JsonMenuEntity> listJsonEntity = jsonRepo.findMenu();
		//listJsonEntity  -- distinct usercode, group code, josn ""
		System.out.println("listJsonEntity.tostring "+listJsonEntity.toString());

		for(JsonMenuEntity ent : listJsonEntity) {
			
			System.out.println("ent.getJsonMenuComposite().getMusrcode(), ent.getJsonMenuComposite().getMgrpcd() "+ent.getJsonMenuComposite().getMusrcode()+ ent.getJsonMenuComposite().getMgrpcd());
			menuTreeString="";
			jsoHolder = menuRepo.findByUsrCdAndGrpCd(ent.getJsonMenuComposite().getMusrcode(), ent.getJsonMenuComposite().getMgrpcd());	
			//jsoHolder -- > for one Distict usercode/Grp code --> parntid,applicationtyp .. etc
			System.out.println("xxxxxxxxxxxxxxxxxxxx"+jsoHolder.toString());
			List<JsonMenuMasterHolderInterface> mainMet = new ArrayList<JsonMenuMasterHolderInterface>();

			for(JsonMenuMasterHolderInterface JsonMenuMasterHolder :jsoHolder) {
				if(JsonMenuMasterHolder.getParentid()==0) {
					mainMet.add(JsonMenuMasterHolder);		
				}
			}

			menuTreeString=menuTreeString+"\n[\n";	
			//menuTreeString=menuTreeString+"\n{\n"; --main

			//int incrt =0;
			//for(MenuMasterEntity met :mainMet) {

			for(int incrt =0;incrt< mainMet.size();incrt++ ) {	
				retAdd.add(mainMet.get(incrt));
			//	menuTreeString=menuTreeString+"\n"+"\""+mainMet.get(incrt).getMenudesc()+"\""+":[{";				
			// main	menuTreeString=menuTreeString+"\n"+"\""+mainMet.get(incrt).getCreatee()+"\"\\"+"\""+mainMet.get(incrt).getBrowsee()+"\"\\"+"\""+mainMet.get(incrt).getDeletee()+"\""+"\\"+"\""+mainMet.get(incrt).getAuthoritye()+"\""+"\""+mainMet.get(incrt).getMenudesc()+"\""+":[{";
//				menuTreeString=menuTreeString+"\n"+"\""+mainMet.get(incrt).getMenudesc()+"\"["+"\""+mainMet.get(incrt).getCreatee()+"\","+"\""+mainMet.get(incrt).getBrowsee()+"\","+"\""+mainMet.get(incrt).getDeletee()+"\""+","+"\""+mainMet.get(incrt).getAuthoritye()+"\""+"][{";

			menuTreeString=menuTreeString+"{"+"\""+"menu"+"\":"+"\""+mainMet.get(incrt).getMenudesc()+"\","+"\""+"url"+"\":"+"\""+mainMet.get(incrt).getMurl()+"\","+"\""+"icon"+"\":"+"\""+mainMet.get(incrt).getMiconname()+"\","+"\""+"create"+"\":"+"\""+mainMet.get(incrt).getCreatee()+"\","+"\""+"browse"+"\":"+"\""+mainMet.get(incrt).getBrowsee()+"\","+"\""+"delete"+"\":"+"\""+mainMet.get(incrt).getDeletee()+"\","+"\""+"authoritye"+"\":"+"\""+mainMet.get(incrt).getAuthoritye()+"\","+"\""+"subMenu"+"\":"+"[";			
				createMenuItem(mainMet.get(incrt).getMenuid());
				
				if(mainMet.size()-1==incrt){
					System.out.println("Coming     xxxxxxxxxxxxxxx");
					//menuTreeString=menuTreeString+"}]";--main
					menuTreeString=menuTreeString+"]}";
				}else {
					//menuTreeString=menuTreeString+"}],";--main
					menuTreeString=menuTreeString+"]},";
				}
				
			}	
			//menuTreeString=menuTreeString+"\n}\n"; msin
			//menuTreeString=menuTreeString+"\n]\n";
			
			//menuTreeString=menuTreeString+"\n}\n";
			menuTreeString=menuTreeString+"\n]\n";

			
			System.out.println("JsonStering "+menuTreeString);
			
			
			json.put(menuTreeString, "");			
			System.out.println("Json "+json);
			
//			return"";
			
//			Gson gson = new GsonBuilder()
//					.setPrettyPrinting()
//					.create(); 
//			
//			
//			System.out.println("Gson"+gson);

			
//			JsonMenuEntity addEntr = new JsonMenuEntity();
//			JsonMenuCompositeEntity compo = new JsonMenuCompositeEntity();
//			
//			addEntr.setJsonMenuComposite(compo);
//			addEntr.getJsonMenuComposite().setMgrpcd(ent.getJsonMenuComposite().getMgrpcd());
//			addEntr.getJsonMenuComposite().setMusrcode(ent.getJsonMenuComposite().getMusrcode());
//			addEntr.setMcachingvalue(menuTreeString);


			//TODO UPDATE USER JSON HERE 
//			System.out.println("addEntr.getJsonMenuComposite().getMgrpcd(),addEntr.getJsonMenuComposite().getMusrcode(),addEntr.getMcachingvalue() "+addEntr.getJsonMenuComposite().getMgrpcd()+"vvvvvvvvvvvv"+addEntr.getJsonMenuComposite().getMusrcode()+"vvvvvvvvvvvv"+addEntr.getMcachingvalue());			
			System.out.println("ent  " +ent);
			
			System.out.println("update jsontable"+jsonRepo.updateJson(ent.getJsonMenuComposite().getMgrpcd(),ent.getJsonMenuComposite().getMusrcode(),menuTreeString));
			jsonRepo.updateJson(ent.getJsonMenuComposite().getMgrpcd(),ent.getJsonMenuComposite().getMusrcode(),menuTreeString);
				
			//retListEnt.add(addEntr);
			System.out.println("menuTreeString"+menuTreeString);
			//System.out.println("THEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");

		}
		//return retListEnt;
//		System.out.println("replce" +menuTreeString.replaceAll("('\n\')",""));
//		System.out.println("tostr"+json.toString().replaceAll("\n",""));
		

	}


	public void createMenuItem(int parentMenuId) {

	
		//List<JsonMenuEntity> listJsonEntity = findMenu();
		List<JsonMenuMasterHolderInterface> parentList = new ArrayList<JsonMenuMasterHolderInterface>();
		
		//parentList= menuRepo.findByParIdMenu(parentMenuId);
		
		System.out.println("create menu parList"+parentList);
		
		
		
		for(JsonMenuMasterHolderInterface JsonMenuMasterHld :jsoHolder){
		
			if(JsonMenuMasterHld.getParentid() == parentMenuId) {
				parentList.add(JsonMenuMasterHld);
				//System.out.println("zzzzzz"+JsonMenuMasterHolder.getMenudesc());
			}
		
		
		
	}
		
			
//		for(JsonMenuMasterHolderInterface JsonMenuMasterHolder :parentList) {
//			jsoHolder.removeIf(n -> (n.getParentid() == JsonMenuMasterHolder.getParentid()));
//			
//		}
//			
//		parentList= repo.findByParId(parentMenuId);

		if(parentList.size()==0)
		{
			return;
 		}
//		
		
		// menuTreeString=menuTreeString+"\n[\n";
		for(int par=0;par<parentList.size();par++) {	
			System.out.println("parentList.get(par).getMenudesc() "+ parentList.get(par).getMenudesc());
			
			//menuTreeString=menuTreeString+"\n{"+parentList.get(par).getMenudesc();
			
		//	menuTreeString=menuTreeString+"\n"+"\""+parentList.get(par).getMenudesc()+"\""+":[{";  --main
			menuTreeString=menuTreeString+"{"+"\""+"menu"+"\":"+"\""+parentList.get(par).getMenudesc()+"\","+"\""+"url"+"\":"+"\""+parentList.get(par).getMurl()+"\","+"\""+"create"+"\":"+"\""+parentList.get(par).getCreatee()+"\","+"\""+"browse"+"\":"+"\""+parentList.get(par).getBrowsee()+"\","+"\""+"delete"+"\":"+"\""+parentList.get(par).getDeletee()+"\","+"\""+"authoritye"+"\":"+"\""+parentList.get(par).getAuthoritye()+"\","+"\""+"subMenu"+"\":"+"[";
			 int currentMenuId=parentList.get(par).getMenuid();
						 
//			for(JsonMenuMasterHolderInterface JsonMenuMasterHolder :jsoHolder) {
//				
//				if(JsonMenuMasterHolder.getParentid()==parentMenuId) {
//					parentList.add(JsonMenuMasterHolder);
//					
//				}
//			}
		//	System.out.println("parentlist"+parentList);
			
				System.out.println("aaaaa"+parentList.size());			 
			 
			 
			//parentList= repo.findByParId(parentMenuId);
			if(parentList.size()!=0) {
					//parentList= new ArrayList<JsonMenuMasterHolderInterface>();
					createMenuItem(currentMenuId);				
			}
			 
			 if(parentList.size()-1==par){
				System.out.println("Coming     xxxxxxxxxxxxxxx");
				//menuTreeString=menuTreeString+"}]"; --main
				
				menuTreeString=menuTreeString+"]}";
			}else {
				//menuTreeString=menuTreeString+"}],"; --main
				menuTreeString=menuTreeString+"]},";						
			}
			 
			 
			
		//}	
		
}
		
	//	menuTreeString=menuTreeString+"\n]\n";
			 
			
		
		intendation=intendation+"\t";
	
		
//		menuTreeString=menuTreeString+"\n]\n";
		
		
	}
		
	
		

}