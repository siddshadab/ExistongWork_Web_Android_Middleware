package com.infrasofttech.microfinance.servicesimpl;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.SecondaryUserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.UserDetailsMasterHolder;
import com.infrasofttech.microfinance.repository.LookupMasterRepository;
import com.infrasofttech.microfinance.repository.SecondaryUserMasterRepository;
import com.infrasofttech.microfinance.repository.SystemParameterRepository;
import com.infrasofttech.microfinance.repository.UserMasterDetailsRepository;
import com.infrasofttech.microfinance.repository.UserMasterDetailsRepository.UserMasterHolderInterface;
import com.infrasofttech.microfinance.services.UserMasterDetailsService;


@Service
@Transactional
public class UserMasterDetailsSeviceImpl implements UserMasterDetailsService{

	@Autowired
	UserMasterDetailsRepository userRepository;

	@Autowired
	SecondaryUserMasterRepository secondaryUserMasterRepo;

	@Autowired
	SystemParameterRepository systemParameterRepo;;



	@Autowired
	LookupMasterRepository lookupRepo;

	@Override	 
	@Transactional
	public ResponseEntity<UserMasterEntity> loadUserByMusrcode( String musrcode, String musrpass) {
		int merror = 99;
		
		UserMasterEntity user = null ;
		SecondaryUserMasterEntity secondaryUserMaster = null;
		SystemParameterEntity systemParameterEntity = null;

	//	System.out.println("after passwrod changed :" +musrcode+ " and "+ musrpass+" and "+mRegDevMacId);
	//	System.out.println("Password recieved as  : "+ musrpass +" and "+ musrcode );	


		try {
			System.out.println("trying to find user");
			user  = (UserMasterEntity) userRepository.findByMusrcode(musrcode);
			System.out.println("User found process end");

			if(null == user) {
				String merrormessage = "UserId Is not Valid";
				user = null;
				user= new UserMasterEntity();
				setUserEntityErrors(merror,merrormessage,user );				
			} 
			else if(user.getMstatus()!=1&&user.getMstatus()!=7) {
				String merrormessage = "UserId Status is not Valid";
				user = null;
				user= new UserMasterEntity();
				merror =  99;
				setUserEntityErrors(merror,merrormessage,user );				
			}
//			else if(mRegDevMacId==null||mRegDevMacId.trim()==""||mRegDevMacId.trim()=="null") {
//				String merrormessage = "Login From Latest Apk";
//				user = null;
//				user= new UserMasterEntity();
//				merror =  99;
//				setUserEntityErrors(merror,merrormessage,user );				
//			}
			else {

				System.out.println("User Found");
				secondaryUserMaster = secondaryUserMasterRepo.findDataByUsrCode(musrcode);
				System.out.println("secondary user naster search complete");

				if(secondaryUserMaster == null) {
					secondaryUserMaster = new SecondaryUserMasterEntity();
					System.out.println("Secondary master is empty");

					if(!checkIfUserisValidated(user,musrpass)) {				
						System.out.println("no secondary noer pass valid");
						String merrormessage = "User Name or password is incorrect";
						user = null;
						user= new UserMasterEntity();
						setUserEntityErrors(merror,merrormessage,user );	
					}else {
						
						System.out.println("no secondary user");
						secondaryUserMaster.setMusrcode(user.getMusrcode().trim());
						System.out.println("UserCode set");
						secondaryUserMaster.setMusrpass(user.getMusrpass());
						System.out.println("Userpass set");
						secondaryUserMaster.setMstatus(1);
						System.out.println("status set");
						//secondaryUserMaster.setMregdevicemacid(mRegDevMacId);
						System.out.println("trying to save");
						secondaryUserMaster.setMcreateddt(LocalDateTime.now());
						secondaryUserMaster.setMlastpwdchgdt(LocalDateTime.now());
						systemParameterEntity = systemParameterRepo.findByCode("4");
						int days = Integer.parseInt(systemParameterEntity.getMcodevalue().trim());
						LocalDateTime endDate = LocalDateTime.now().plusDays(days);
						secondaryUserMaster.setMnextpwdchgdt(endDate);
						System.out.println(secondaryUserMaster);
						secondaryUserMasterRepo.save(secondaryUserMaster);
						System.out.println("Saved");
						//String merrormessage = "Please Change Password";	
						String merrormessage = "Sucessfully LoggedIn";
						setUserEntityErrors(50,merrormessage,user );	
						user.setMlastpwdchgdt(LocalDateTime.now());
						user.setMnextpwdchgdt(endDate);
						user.setMstatus(7);
						user.setMerror(50);
					}
				}
				else { 
					System.out.println(secondaryUserMaster);
					System.out.println(musrpass);
					//System.out.println(mRegDevMacId);
					if(secondaryUserMaster.getMusrpass().equals(musrpass)&&secondaryUserMaster.getMstatus()==7
							//&&secondaryUserMaster.getMregdevicemacid().equals(mRegDevMacId)
							) {
						System.out.println("new User alredy created");
						user.setMnextpwdchgdt(secondaryUserMaster.getMnextpwdchgdt());
						user.setMusrpass(secondaryUserMaster.getMusrpass());
						user.setMerrormessage(" New User need to change password");
						user.setMerror(50);
						//user.setMusrpass(secondaryUserMaster.getMusrpass());
						//user.setMregdevicemacid(secondaryUserMaster.getMregdevicemacid());
					}
					else if(LocalDateTime.now().isAfter(secondaryUserMaster.getMnextpwdchgdt())
							&&musrpass.equals(secondaryUserMaster.getMusrpass())){
							//&&secondaryUserMaster.getMregdevicemacid().equals(mRegDevMacId)) {
						System.out.println("Next Passwroed CHange Date exceeded");
						user.setMerrormessage(" Password Change Required");
						user.setMnextpwdchgdt(secondaryUserMaster.getMnextpwdchgdt());
						user.setMusrpass(secondaryUserMaster.getMusrpass());
						user.setMerror(50);
						user.setMusrpass(secondaryUserMaster.getMusrpass());
						//user.setMregdevicemacid(secondaryUserMaster.getMregdevicemacid());
					}
					else if(secondaryUserMaster.getMusrpass().equals(musrpass)&& secondaryUserMaster.getMstatus()==1//&&
							) {//secondaryUserMaster.getMregdevicemacid().equals(mRegDevMacId)	) {
						
						System.out.println("all conditions matched");
						user.setMerrormessage("Sucessfully LoggedIn");
						user.setMerror(0);
						user.setMusrpass(secondaryUserMaster.getMusrpass());
						//user.setMregdevicemacid(secondaryUserMaster.getMregdevicemacid());
						user.setMnextpwdchgdt(secondaryUserMaster.getMnextpwdchgdt());
						user.setMstatus(1);		
							
					}
					else if(secondaryUserMaster.getMusrpass().equals(musrpass)&& (secondaryUserMaster.getMstatus()==1||
							secondaryUserMaster.getMstatus()==7
							))
							//&&!secondaryUserMaster.getMregdevicemacid().equals(mRegDevMacId)	) 
							{
						System.out.println("Different MAC ID");	
						String merrormessage = "Login from registered device";
						user = null;
						user= new UserMasterEntity();
						setUserEntityErrors(merror,merrormessage,user );	
					}
					else {
						System.out.println("passswod"+musrpass+" and "+"username"+musrcode);
						System.out.println("No conditions matched");
						String merrormessage = "User Name or password is incorrect";
						user = null;
						user= new UserMasterEntity();
						setUserEntityErrors(merror,merrormessage,user );	
					}
				}
				System.out.println("error in " + merror + "object error"+ user.getMerrormessage());
				//return new ResponseEntity<UserMasterEntity>(user,new HttpHeaders(),HttpStatus.OK);
			}

		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			System.out.println("Exception occured");
			String merrormessage = "No Records found for this activity";
			user = null;
			user= new UserMasterEntity();
			setUserEntityErrors(merror,merrormessage,user );	
			return new ResponseEntity<UserMasterEntity>(user,new HttpHeaders(),HttpStatus.OK);
		}
		return new ResponseEntity<UserMasterEntity>(user,new HttpHeaders(),HttpStatus.OK);


	}


	private void setUserEntityErrors(int merror, String merrormessage,UserMasterEntity user ) {
		user.setMerror(merror);
		user.setMerrormessage(merrormessage);
		System.out.println("error in " + merrormessage + "object error"+ user.getMerrormessage());

	}

	private boolean checkIfUserisValidated(UserMasterEntity user,String musrpass) {
		System.out.println("userpas in entity  recieved as  : "+ user!=null?user.getMusrpass():"");
		return user.getMusrpass().equals(musrpass);
	}
	private boolean checkIfSecondaryUserisValidated(UserMasterEntity user,String musrpass) {
		System.out.println("userpas in entity  recieved as  : "+ user!=null?user.getMusrpass():"");
		return user.getMusrpass().equals(musrpass);
	}
	
	

	/*
	 * @Override public ResponseEntity<UserMasterEntity> changePassword(String
	 * muserCode, String oldPass, String newPass, String mregisterdMacId) { int
	 * merror = 99; UserMasterEntity user = null ; SecondaryUserMasterEntity
	 * secondaryUserMaster = null; System.out.println("Password recieved as  : "+
	 * oldPass+"and User Code "+ muserCode ); try { secondaryUserMaster =
	 * secondaryUserMasterRepo.findDataByUsrCode(muserCode );
	 * System.out.println("trying to find user"); user = (UserMasterEntity)
	 * userRepository.findByMusrcode(muserCode);
	 * System.out.println("User found process end");
	 * 
	 * if(null==user) {
	 * 
	 * String merrormessage = "UserId Is not Valid"; user = null; user= new
	 * UserMasterEntity(); setUserEntityErrors(merror,merrormessage,user); }else {
	 * if(null == secondaryUserMaster) {
	 * System.out.println("Inside null secondary user master"); } else {
	 * 
	 * String oldPass1 = secondaryUserMaster.getMoldpass1(); String oldPass2 =
	 * secondaryUserMaster.getMoldpass2(); String oldPass3 =
	 * secondaryUserMaster.getMoldpass3();
	 * 
	 * System.out.println("Old Pass 1 is "+oldPass1);
	 * System.out.println("Old Pass 2 is "+oldPass2);
	 * System.out.println("Old Pass 3 is "+oldPass3);
	 * System.out.println("Sent password "+newPass);
	 * if(newPass.equals(oldPass1)||newPass.equals(oldPass2)||
	 * newPass.equals(oldPass3)) {
	 * System.out.println("New Passwaord should not match old 3 passwords"); String
	 * merrormessage = "New Passwaord should not match old 3 passwords"; merror =
	 * 99; user = null; user= new UserMasterEntity();
	 * setUserEntityErrors(merror,merrormessage,user );
	 * 
	 * 
	 * } else if(!mregisterdMacId.equals(secondaryUserMaster.getMregdevicemacid()))
	 * { System.out.println("Mac Id do not match"); String merrormessage =
	 * "Mac Id do Not match"; merror = 99; user = null; user= new
	 * UserMasterEntity(); setUserEntityErrors(merror,merrormessage,user );
	 * 
	 * 
	 * }
	 * 
	 * else if(secondaryUserMaster.getMusrpass().equals(oldPass)&&
	 * secondaryUserMaster.getMregdevicemacid().equals(mregisterdMacId) ) { int days
	 * = 7; try { SystemParameterEntity systemParameterEntity =
	 * systemParameterRepo.findByCode("4"); days =
	 * Integer.parseInt(systemParameterEntity.getMcodevalue().trim());
	 * }catch(Exception e) { days =7; }
	 * 
	 * LocalDateTime endDate = LocalDateTime.now().plusDays(days);
	 * secondaryUserMaster.setMnextpwdchgdt(endDate); int i = 0;
	 * System.out.println("oldPass"+ oldPass); System.out.println("trying to save");
	 * if(oldPass1==null) { i =
	 * secondaryUserMasterRepo.updateUserPassOneBlank(muserCode, newPass,
	 * mregisterdMacId,1,oldPass); } else if(oldPass2 == null) { i =
	 * secondaryUserMasterRepo.updateUserPassTwoBlank(muserCode, newPass,
	 * mregisterdMacId,1,oldPass,oldPass1); } else { i =
	 * secondaryUserMasterRepo.updateUserPassThreeBlank(muserCode, newPass,
	 * mregisterdMacId,1,oldPass,oldPass1,oldPass2); }
	 * 
	 * System.out.println(i); user.setMerrormessage("Password Changed");
	 * user.setMerror(0); user.setMusrpass(secondaryUserMaster.getMusrpass());
	 * user.setMregdevicemacid(secondaryUserMaster.getMregdevicemacid());
	 * user.setMstatus(secondaryUserMaster.getMstatus()); }
	 * 
	 * else { System.out.println("no Condition matched"); String merrormessage =
	 * "Mac Id do Not match"; merror = 99; user = null; merrormessage =
	 * "Old Password Not right"; user= new UserMasterEntity();
	 * setUserEntityErrors(merror,merrormessage,user );
	 * 
	 * 
	 * }
	 * 
	 * }
	 * 
	 * }
	 * 
	 * 
	 * 
	 * } catch (Exception e) {
	 * 
	 * //logger.error("Error While Persisting Object"+e.getMessage()); String
	 * merrormessage = "No Records found for this activity"; user = null; user= new
	 * UserMasterEntity(); setUserEntityErrors(merror,merrormessage,user ); return
	 * new ResponseEntity<UserMasterEntity>(user,new HttpHeaders(),HttpStatus.OK); }
	 * return new ResponseEntity<UserMasterEntity>(user,new
	 * HttpHeaders(),HttpStatus.OK);
	 * 
	 * }
	 */


	@Override
	public ResponseEntity<List<UserMasterEntity>> getHerarchy(String musrcode) {
		// TODO Auto-generated method stub
		return null;
	}


	@Transactional
	@Override
	public ResponseEntity<?> addList(UserMasterEntity userMasterEntity) {

		//return new ResponseEntity<Object>(userRepository.save(userMasterEntity),new HttpHeaders(),HttpStatus.CREATED);
		UserMasterEntity userEnt =  userRepository.findByUserCode(userMasterEntity.getMusrcode());		
		System.out.println("UserEnt"+userEnt);
		
		SecondaryUserMasterEntity secondaryEntity = new SecondaryUserMasterEntity();
		UserDetailsMasterHolder hld = new UserDetailsMasterHolder();
		try {
			if(userEnt != null ) {
				userMasterEntity.setMerror(200);
				userMasterEntity.setMerrormessage("Record Already Exists");
				return new ResponseEntity<UserMasterEntity>(userMasterEntity,new HttpHeaders(),HttpStatus.OK);
			}else {				
					userMasterEntity.setMusrpass("Infra#123");
					userMasterEntity.setMcreateddt(LocalDateTime.now());
					userMasterEntity.setMcreatedby(userMasterEntity.getMusrcode());
					userRepository.save(userMasterEntity);
					

					//secondary user master
					hld.setMusrcd(userMasterEntity.getMusrcode());
					hld.setMusrpass(userMasterEntity.getMusrpass());
					hld.setMstatus(userMasterEntity.getMstatus());
					hld.setMnextpwdchgdt(userMasterEntity.getMnextpwdchgdt());
					
					hld.setMcreatedby(userMasterEntity.getMusrcode());
					
					secondaryEntity.setMusrcode(hld.getMusrcd());
					secondaryEntity.setMusrpass(hld.getMusrpass());
					secondaryEntity.setMstatus(hld.getMstatus());
					secondaryEntity.setMnextpwdchgdt(hld.getMnextpwdchgdt());
					secondaryEntity.setMcreateddt(LocalDateTime.now());
					secondaryEntity.setMcreatedby(hld.getMcreatedby());
					secondaryUserMasterRepo.save(secondaryEntity);
					userMasterEntity.setMerror(200);
					userMasterEntity.setMerrormessage("Record Saved Successfully");
					return new ResponseEntity<Object>(userMasterEntity,new HttpHeaders(),HttpStatus.OK);	
				
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}	
	}


	@Override
	public ResponseEntity<UserMasterEntity> changePassword(String musrcode, String newPass, String oldPass, 
			String mregisterdMacId) {

		int merror = 99;
		UserMasterEntity user = null ;
		SecondaryUserMasterEntity secondaryUserMaster = null;

		System.out.println("inside service impl");
		System.out.println("user codexxxxxx: "+musrcode);
		System.out.println("old passxxxxxx: "+oldPass);
		System.out.println("new passxxxxxxx: "+newPass);
		System.out.println("mac idxxxxxxxxx: "+mregisterdMacId);


		System.out.println("Password recieved as  : "+ oldPass+"and User Code "+ musrcode );
		try {
			secondaryUserMaster = secondaryUserMasterRepo.findDataByUsrCode(musrcode ); 
			System.out.println("trying to find user");
			user  = (UserMasterEntity) userRepository.findByMusrcode(musrcode);
			System.out.println("User found process end");

			if(null==user) {

				String merrormessage = "UserId Is not Valid";
				user = null;
				user= new UserMasterEntity();
				setUserEntityErrors(merror,merrormessage,user);
			}else {
				if(null == secondaryUserMaster) {
					System.out.println("Inside null secondary user master");
				}
				else {


					String oldPass1 = secondaryUserMaster.getMoldpass1();
					oldPass1 = user.getMusrpass();					
					String oldPass2 = secondaryUserMaster.getMoldpass2();
					//oldPass1= secondaryUserMaster.getMoldpass2();--main
					oldPass2= secondaryUserMaster.getMoldpass1();
					String oldPass3 = secondaryUserMaster.getMoldpass3();
					///new change  7/8/20
					oldPass3= secondaryUserMaster.getMoldpass2();

					System.out.println("Old Pass 1 is "+oldPass1);
					System.out.println("Old Pass 2 is "+oldPass2);
					System.out.println("Old Pass 3 is "+oldPass3);
					System.out.println("Sent password "+newPass);

					if(newPass.equals(oldPass1)||newPass.equals(oldPass2)||
							newPass.equals(oldPass3)) {
						System.out.println("New Passwaord should not match old 3 passwords");
						String merrormessage = "New Passwaord should not match old 3 passwords";
						merror = 99;
						user = null;
						user= new UserMasterEntity();
						setUserEntityErrors(merror,merrormessage,user );


					}
					else if(!mregisterdMacId.equals(secondaryUserMaster.getMregdevicemacid())) {
						System.out.println("Mac Id do not match");
						String merrormessage = "Mac Id do Not match";
						merror = 99;
						user = null;
						user= new UserMasterEntity();
						setUserEntityErrors(merror,merrormessage,user );


					}

					else if(secondaryUserMaster.getMusrpass().equals(oldPass)&&
							secondaryUserMaster.getMregdevicemacid().equals(mregisterdMacId)
							) {
						int days = 7;
						try {
							SystemParameterEntity systemParameterEntity = systemParameterRepo.findByCode("4");
							days = Integer.parseInt(systemParameterEntity.getMcodevalue().trim());	
						}catch(Exception e) {
							days =7;
						}

						LocalDateTime endDate = LocalDateTime.now().plusDays(days);
						secondaryUserMaster.setMnextpwdchgdt(endDate);
						int i = 0;
						System.out.println("oldPass"+ oldPass);
						System.out.println("trying to save");
						if(oldPass1==null) {
							i = secondaryUserMasterRepo.updateUserPassOneBlank(musrcode, newPass, mregisterdMacId,1,oldPass);	
						}
						else if(oldPass2 == null) {
							i = secondaryUserMasterRepo.updateUserPassTwoBlank(musrcode, newPass, mregisterdMacId,1,oldPass,oldPass1);
						}
						else {
							i = secondaryUserMasterRepo.updateUserPassThreeBlank(musrcode, newPass, mregisterdMacId,1,oldPass,oldPass1,oldPass2);
						}

						System.out.println(i);
						user.setMerrormessage("Password Changed");
						user.setMerror(0);
						user.setMusrpass(secondaryUserMaster.getMusrpass());
						user.setMregdevicemacid(secondaryUserMaster.getMregdevicemacid());
						user.setMstatus(secondaryUserMaster.getMstatus());
					}

					else  {
						System.out.println("no Condition matched");
						String merrormessage = "Mac Id do Not match";
						merror = 99;
						user = null;
						merrormessage = "Old Password Not right";
						user= new UserMasterEntity();
						setUserEntityErrors(merror,merrormessage,user );


					}

				}

			}



		} catch (Exception e) {

			//logger.error("Error While Persisting Object"+e.getMessage());
			String merrormessage = "No Records found for this activity";
			user = null;
			user= new UserMasterEntity();
			setUserEntityErrors(merror,merrormessage,user );	
			return new ResponseEntity<UserMasterEntity>(user,new HttpHeaders(),HttpStatus.OK);
		}
		return new ResponseEntity<UserMasterEntity>(user,new HttpHeaders(),HttpStatus.OK);

	}

	@Transactional
	@Override
	public List<UserMasterEntity> getUserData(UserMasterEntity userMasterEntity) {

		try {
			List<UserMasterEntity> userEntity = userRepository.getDataByUsrCd(userMasterEntity.getMusrcode());
			
			if(userEntity != null) {		
			
				List<UserMasterEntity> userByGrpCd = userRepository.findUserByGrpCd(userEntity.get(0).getMgrpcd());
				return userByGrpCd;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
		

	}

//	@Override
//	public ResponseEntity<?> getUserData(UserMasterEntity userMasterEntity){
//		List<UserMasterEntity> userEnt = userRepository.getHerarchy(userMasterEntity.getMusrcode());
//		return new ResponseEntity<Object>(userEnt,new HttpHeaders(),HttpStatus.OK);
//	}
	
//	@Override
//	public ResponseEntity<?> deleteUser(UserMasterEntity userMasterEntity) {
//		List<UserMasterEntity> userEnt = userRepository.getDataByUsrCd(userMasterEntity.getMusrcode());
//		System.out.println("userEnt"+userEnt);
//		SecondaryUserMasterEntity secondaryEntity = secondaryUserMasterRepo.findDataByUsrCode(userMasterEntity.getMusrcode());
//		if(userEnt.isEmpty()) {
//			userMasterEntity.setMerrormessage("No Data Found");			
//			return new ResponseEntity<UserMasterEntity>(userMasterEntity,new HttpHeaders(),HttpStatus.ALREADY_REPORTED);
//		}else {			
//			
//			if(userMasterEntity.getMusrcode().equals(secondaryEntity.getMusrcode())) {						
//				//userRepository.deleteByUsrCd(userMasterEntity.getMusrcode());
//				userRepository.delete(userMasterEntity);
//				secondaryUserMasterRepo.delete(secondaryEntity);
//				userMasterEntity.setMerrormessage("Sucessfully Data deleted from primary and secondary Master ");
//				userMasterEntity.setMerror(200);
//			}
//			return new ResponseEntity<UserMasterEntity>(userMasterEntity,new HttpHeaders(),HttpStatus.OK);
//		}		
//		
//	}
	@Override
	public ResponseEntity<?> deleteUser(UserDetailsMasterHolder userHolder) {		
		
		try {
			UserMasterEntity userEnt = new UserMasterEntity();
			
			userRepository.deleteByBulk(userHolder.getMusrcode());
			//secondaryUserMasterRepo.deleteByBulk(userHolder.getMusrcode());
			userEnt.setMerror(200);
			userEnt.setMerrormessage("Record Deleted Successfully from Primary and secondary Master");
			return new ResponseEntity<Object>(userEnt,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(), HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
		
		
		
//		UserMasterEntity userEnt = new UserMasterEntity();
//		
//		List<UserMasterEntity> preUser = userRepository.getDataByUsrCode(userHolder.getMusrcode());
//		List<SecondaryUserMasterEntity> secUsrEnt = secondaryUserMasterRepo.getSecDataUsrCode(userHolder.getMusrcode());
//		if(preUser.isEmpty()  && secUsrEnt.isEmpty()) {
//			userEnt.setMerror(200);
//			userEnt.setMerrormessage("Record Not Found");
//			return new ResponseEntity<UserMasterEntity>(userEnt,new HttpHeaders(),HttpStatus.OK);
//			
//		}else {
//			userEnt.setMerror(200);
//			userEnt.setMerrormessage("Sucessfully Data deleted from primary and secondary Master ");
//			userRepository.deleteByBulk(userHolder.getMusrcode());
//			return new ResponseEntity<UserMasterEntity>(userEnt,new HttpHeaders(),HttpStatus.OK);
//		}
	}
	@Override
	public ResponseEntity<?> updateUser(UserMasterEntity userMasterEntity) {

			SecondaryUserMasterEntity secondaryEntity = secondaryUserMasterRepo.findDataByUsrCode(userMasterEntity.getMusrcode());

			if(userMasterEntity!=null) {
				userMasterEntity.setMcreatedby(userMasterEntity.getMcreatedby());
				userMasterEntity.setMcreateddt(LocalDateTime.now());
				userRepository.save(userMasterEntity);
				userMasterEntity.setMerrormessage("Sucessfully Data Saved In primary Master");
				userMasterEntity.setMerror(200);
				if(userMasterEntity.getMusrcode().equals(userMasterEntity.getMusrcode())) {
					if(secondaryEntity!=null) {
						secondaryEntity.setMlastsynsdate(userMasterEntity.getMlastsynsdate());
						secondaryEntity.setMlastupdateby(userMasterEntity.getMlastupdateby());
						secondaryEntity.setMlastupdatedt(userMasterEntity.getMlastupdatedt());
						secondaryEntity.setMlastpwdchgdt(userMasterEntity.getMlastpwdchgdt());
						secondaryEntity.setMnextpwdchgdt(userMasterEntity.getMnextpwdchgdt());
						
						secondaryUserMasterRepo.save(secondaryEntity);
						userMasterEntity.setMerrormessage("Sucessfully Data Saved In primary and secondary Master");
					}
				}

			}
			return new ResponseEntity<UserMasterEntity>(userMasterEntity,new HttpHeaders(),HttpStatus.OK);
		}


	@Override
	public ResponseEntity<?> getUsrCdDesc() {
		List<UserMasterHolderInterface> userDesc = userRepository.getUsrCdDesc();
		try {
			if(userDesc == null) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(userDesc,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}


	@Override
	public ResponseEntity<?> getAllUsrByGrpCd() {
		try {
			
			//PageRequest pageable = PageRequest.of(0, 10);
			//Page<UserMasterEntity> userEnt=userRepository.findAll(pageable);
			//List<UserMasterEntity> userEnt= pages.getPageable();
			//System.out.println("pagesize"+userEnt.size());
			List<UserMasterEntity> userEnt= userRepository.findAll(Sort.by(Sort.Direction.DESC,"mcreateddt"));
			
			//System.out.println("xxxxxxxxx"+userEnt.getSize());
			if(userEnt.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(userEnt,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {			
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}


	@Override
	public ResponseEntity<?> findRecByUsrCd(UserMasterEntity userMasterEntity) {
		
			
				try {
					UserMasterEntity userEnt = userRepository.findByMusrcode(userMasterEntity.getMusrcode());
					SecondaryUserMasterEntity secEnt = secondaryUserMasterRepo.findDataByUsrCode(userMasterEntity.getMusrcode());
					
					if(userEnt ==null && secEnt ==null) {
						userMasterEntity.setMerror(0);
						userMasterEntity.setMerrormessage("null");		
						return new ResponseEntity<Object>(userMasterEntity,new HttpHeaders(),HttpStatus.OK);
					}
					else {
						userMasterEntity.setMerror(200);
						userMasterEntity.setMerrormessage("User Code already exists");		
						return new ResponseEntity<Object>(userMasterEntity,new HttpHeaders(),HttpStatus.OK);
					}
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
					
				}
					
				
			
				
	} 
	


	/*
	 * @Transactional
	 * 
	 * @Override public ResponseEntity<?> addList(UserMasterEntity userMasterEntity)
	 * {
	 * 
	 * try { return new
	 * ResponseEntity<Object>(userRepository.save(userMasterEntity),new
	 * HttpHeaders(),HttpStatus.CREATED); } catch (Exception e) {
	 * //logger.error("Error While Persisting Object"+e.getMessage()); return new
	 * ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY); } }
	 * 
	 */	

}



