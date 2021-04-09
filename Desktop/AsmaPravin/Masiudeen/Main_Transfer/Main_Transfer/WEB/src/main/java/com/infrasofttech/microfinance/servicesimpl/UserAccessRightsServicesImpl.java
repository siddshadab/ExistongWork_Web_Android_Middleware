package com.infrasofttech.microfinance.servicesimpl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.MenuMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductComposieEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;
import com.infrasofttech.microfinance.entityBeans.master.SecondaryUserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccessRightsEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserAccressRightsCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuAndAccessRightsHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuHolderBean;
import com.infrasofttech.microfinance.entityBeans.master.holder.ProductMasterHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.UserAccessRightsHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.UserDetailsMasterHolder;
import com.infrasofttech.microfinance.repository.MenuMasterRepository;
import com.infrasofttech.microfinance.repository.UserAccressRightsRepository;
import com.infrasofttech.microfinance.repository.UserAccressRightsRepository.UserAccessHolderInterface;
import com.infrasofttech.microfinance.services.UserAccessRightsService;



@Service
@Transactional
public class UserAccessRightsServicesImpl implements UserAccessRightsService {


	@Autowired
	UserAccressRightsRepository repo;
	
	@Autowired
	MenuMasterRepository menuRepo;	
	@Transactional
	@Override
	public ResponseEntity<?> getDataUserByMUserCode(String musrcode,int mgrpcd) {		
		try {
			List<UserAccessRightsEntity> userAccessRightsEntity=repo.findByMUserCode(musrcode,mgrpcd);				
			
			if(userAccessRightsEntity.isEmpty()) 
				return ResponseEntity.notFound().build();
				return new ResponseEntity<List<UserAccessRightsEntity>>(userAccessRightsEntity,new HttpHeaders(),HttpStatus.OK);
				
		}catch(Exception e) {
		
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}

	@Override
	public List<MenuHolderBean> getDataMenu(UserAccressRightsCompositeEntity userAccressRightsCompositeEntity) {
	
			MenuHolderBean menuBean= new MenuHolderBean();
			
			MenuMasterEntity menuMasterEntity= new MenuMasterEntity();
			
			ArrayList<MenuHolderBean> menuList= new ArrayList<MenuHolderBean>();
			
			List<UserAccessRightsEntity> menu = repo.findData(userAccressRightsCompositeEntity.getusrcode());
			
			List<MenuMasterEntity> menuMaster = new ArrayList<MenuMasterEntity>();
			
			for(int i=0; i< menu.size();i++) {
				
				 menuMaster.addAll(menuRepo.findByMenuId(menu.get(i).getUserAccressRightsCompositeEntity().getMenuid()));
				 
			}

			System.out.println("Menu" +menu);
			
			System.out.println(menuMaster);
			
		    for(int i=0;i<menu.size();i++) {
				 System.out.println(menu.get(i).getUserAccressRightsCompositeEntity().getMenuid());			 

				menuBean.setMusrcode(menu.get(i).getUserAccressRightsCompositeEntity().getusrcode());
				menuBean.setMenuid(menu.get(i).getUserAccressRightsCompositeEntity().getMenuid());
				menuBean.setMgrpcd(menu.get(i).getUserAccressRightsCompositeEntity().getMgrpcd());			
				menuBean.setCreatee(menu.get(i).getCreatee());
				menuBean.setDeletee(menu.get(i).getDeletee());
				menuBean.setAuthoritye(menu.get(i).getAuthoritye());
				menuBean.setBrowsee(menu.get(i).getBrowsee());
				
				menuBean.setMenutype(menuMaster.get(i).getMenutype());
				menuBean.setParentid(menuMaster.get(i).getParentid());
				menuBean.setParenttype(menuMaster.get(i).getParenttype());
				menuBean.setMenutype(menuMaster.get(i).getMenutype());				
				menuBean.setMurl(menuMaster.get(i).getMurl());
				menuBean.setMenudesc(menuMaster.get(i).getMenudesc());
				System.out.println("MenuBean "+menuBean);					
				
			 }
		    menuList.add(menuBean);
			 System.out.println("MenuList "+menuList);	
			 return menuList;
		}
	
	@Override
	public ResponseEntity<?> addList(UserAccessRightsHolder userAccessRights) {
		
		UserAccessRightsEntity  userEnt = repo.findByMenuIdAndGrpCdAndUsrCd(userAccessRights.getMenuid(), userAccessRights.getMgrpcd(), userAccessRights.getMusrcode());
		try {
			
			if(userEnt == null) {
				UserAccessRightsEntity userEntity= new UserAccessRightsEntity();	
				
				UserAccressRightsCompositeEntity uarComposite = new UserAccressRightsCompositeEntity();
				
				uarComposite.setMgrpcd(userAccessRights.getMgrpcd());			
				uarComposite.setMenuid(userAccessRights.getMenuid());
				uarComposite.setMusrcode(userAccessRights.getMusrcode());		
				
				userEntity.setUserAccressRightsCompositeEntity(uarComposite);
				userEntity.setAuthoritye(userAccessRights.getAuthoritye());
				userEntity.setBrowsee(userAccessRights.getBrowsee());
				userEntity.setCreatee(userAccessRights.getCreatee());
				userEntity.setDeletee(userAccessRights.getDeletee());
				userEntity.setModifye(userAccessRights.getModifye());					
				
				userAccessRights.setMerror(200);
				userAccessRights.setMerrormsg("Record Added SuccessFully");
				repo.save(userEntity);
				return new ResponseEntity<Object>(userAccessRights, new HttpHeaders(),HttpStatus.OK);
				
			}else {
				userAccessRights.setMerror(200);
				userAccessRights.setMerrormsg("Record Already Exists");
				return new ResponseEntity<Object>(userAccessRights, new HttpHeaders(),HttpStatus.OK);
			}
			
		}catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}

	@Transactional
	@Override
	public ResponseEntity<?> getAllUserAccessRightsFromMaster() {
		try {
			//List<UserAccessHolderInterface> userAccessRightsEntity=repo.getAll();
			List<UserAccessRightsEntity> userAccessRightsEntity=repo.findAll();
			if(userAccessRightsEntity.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(userAccessRightsEntity,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	@Override
	public ResponseEntity<?> deleteData(List<UserAccessRightsHolder> code) {		
		System.out.println("codessssssssssssss"+code);
		try {
			UserAccessRightsHolder hld = new UserAccessRightsHolder();
			for(int i=0;i<code.size();i++) {
				repo.deleteByBulk(code.get(i).getMenuid(),code.get(i).getMgrpcd(),code.get(i).getMusrcode());			
			}			
			hld.setMerror(200);
			hld.setMerrormsg("Record Deleted Successfully");
			return new ResponseEntity<Object>(hld,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
				
//		try {
//			
//			UserAccessRightsEntity userEntity= new UserAccessRightsEntity();	
//		
//			UserAccressRightsCompositeEntity uarComposite = new UserAccressRightsCompositeEntity();
//			
//			uarComposite.setMgrpcd(userAccessRights.getMgrpcd());			
//			uarComposite.setMenuid(userAccessRights.getMenuid());
//			uarComposite.setMusrcode(userAccessRights.getMusrcode());		
//			
//			userEntity.setUserAccressRightsCompositeEntity(uarComposite);
//			userEntity.setAuthoritye(userAccessRights.getAuthoritye());
//			userEntity.setBrowsee(userAccessRights.getBrowsee());
//			userEntity.setCreatee(userAccessRights.getCreatee());
//			userEntity.setDeletee(userAccessRights.getDeletee());
//			userEntity.setModifye(userAccessRights.getModifye());	
//			
//			userAccessRights.setMerror(200);
//			userAccessRights.setMerrormsg("Record Deleted SuccessFully");
//			
//			
//			System.out.println("userAccessRights.getMenuid() "+userAccessRights.getMenuid());
//			System.out.println("userAccessRights.getMgrpcd() "+userAccessRights.getMgrpcd());
//			System.out.println("userAccessRights.getMusrcode() "+userAccessRights.getMusrcode());
//			System.out.println("userAccessRights.getMusrcode() "+userAccessRights.getMusrcode());
//			
//			repo.deleteByGrpCdUsrCd(userAccessRights.getMenuid(), userAccessRights.getMgrpcd(), userAccessRights.getMusrcode());
//			//repo.deleteByBulk(menuid, mgrpcd, musrcode);
//			
//			UserAccessRightsEntity usrDeletedOrNot = repo.findByMenuIdAndGrpCdAndUsrCd(userAccessRights.getMenuid(), userAccessRights.getMgrpcd(), userAccessRights.getMusrcode());
//			if( usrDeletedOrNot ==null) {
//				return new ResponseEntity<UserAccessRightsHolder>(userAccessRights,new HttpHeaders(),HttpStatus.OK);			
//			}else {
//				return new ResponseEntity<String>("Something went wrong while deleteing records",new HttpHeaders(),HttpStatus.OK);
//			}
//		}catch(Exception e) {
//			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
//		}	
	
	}

	
	@Override
	public ResponseEntity<?> updateUserRights(UserAccessRightsHolder userAccessRights){
		
		try {
			
			UserAccessRightsEntity userEntity= new UserAccessRightsEntity();	
		
			UserAccressRightsCompositeEntity uarComposite = new UserAccressRightsCompositeEntity();
			
			uarComposite.setMgrpcd(userAccessRights.getMgrpcd());			
			uarComposite.setMenuid(userAccessRights.getMenuid());
			uarComposite.setMusrcode(userAccessRights.getMusrcode());		
			
			userEntity.setUserAccressRightsCompositeEntity(uarComposite);
			userEntity.setAuthoritye(userAccessRights.getAuthoritye());
			userEntity.setBrowsee(userAccessRights.getBrowsee());
			userEntity.setCreatee(userAccessRights.getCreatee());
			userEntity.setDeletee(userAccessRights.getDeletee());
			userEntity.setModifye(userAccessRights.getModifye());		
			userAccessRights.setMerror(200);
			userAccessRights.setMerrormsg("Record Updated SuccessFully");
		
			repo.save(userEntity);		
			
			return new ResponseEntity<Object>(userAccessRights,new HttpHeaders(),HttpStatus.OK);
//			return new ResponseEntity<Object>(repo.updateByGrpCdUsrCd(userEntity.getUserAccressRightsCompositeEntity().getMenuid(),
//											  userEntity.getUserAccressRightsCompositeEntity().getMgrpcd(),
//											  userEntity.getUserAccressRightsCompositeEntity().getusrcode()),
//											  new HttpHeaders(),HttpStatus.CREATED);
		}catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
		
		
		
		
//		System.out.println("holder"+userAccessRightsHolder);
//		List <UserAccessRightsEntity> accessList=null;
//		if(userAccessRightsHolder !=null) {		
//			
//			UserAccessRightsEntity userAccessRightsEntity = new UserAccessRightsEntity();
//			
//			UserAccressRightsCompositeEntity usrComposite = new UserAccressRightsCompositeEntity();			
//			
//			usrComposite.setMenuid(userAccessRightsHolder.getMenuid());	
//			usrComposite.setMgrpcd(userAccessRightsHolder.getMgrpcd());
//			usrComposite.setMusrcode(userAccessRightsHolder.getMusrcode());
//		
//			userAccessRightsEntity.setUserAccressRightsCompositeEntity(usrComposite);
//			userAccessRightsEntity.setAuthoritye(userAccessRightsHolder.getAuthoritye());
//			userAccessRightsEntity.setBrowsee(userAccessRightsHolder.getBrowsee());
//			userAccessRightsEntity.setCreatee(userAccessRightsHolder.getCreatee());
//			userAccessRightsEntity.setDeletee(userAccessRightsHolder.getDeletee());
//			userAccessRightsEntity.setModifye(userAccessRightsHolder.getModifye());
//			
//			return new ResponseEntity<Object>(repo.save(userAccessRightsEntity), new HttpHeaders(),HttpStatus.OK);		
//		
//	
//	  }
//		return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
			
	}

	@Override
	public ResponseEntity<?> findRecByPrmKey(UserAccessRightsHolder userAccessHoler) {
		try {
			UserAccessRightsEntity userEnt = repo.findByMenuIdAndGrpCdAndUsrCd(userAccessHoler.getMenuid(),userAccessHoler.getMgrpcd(),userAccessHoler.getMusrcode());
			if(userEnt == null) {
				userAccessHoler.setMerror(0);
				userAccessHoler.setMerrormsg("null");
				return new ResponseEntity<Object>(userAccessHoler,new HttpHeaders(),HttpStatus.OK);
			}
			else {
				userAccessHoler.setMerror(200);
				userAccessHoler.setMerrormsg("Menu Id, Group Code and User Code Already Exists");
				return new ResponseEntity<Object>(userAccessHoler,new HttpHeaders(),HttpStatus.OK);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<> (new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	
	
	//charts
	@Transactional
	@Override
	public List<MenuAndAccessRightsHolderBean> getChartsIdOnMenuAndAccessJoin(String musrcode,int mgrpcd) {	
		List<MenuAndAccessRightsHolderBean> retEntityList = null;
		
		try {
			retEntityList = repo.getChartsIdOnMenuAndAccessJoin(musrcode,mgrpcd);
			
		}catch(Exception e) {
			retEntityList=null;
		}
		
		return retEntityList;
	}
	
}	
