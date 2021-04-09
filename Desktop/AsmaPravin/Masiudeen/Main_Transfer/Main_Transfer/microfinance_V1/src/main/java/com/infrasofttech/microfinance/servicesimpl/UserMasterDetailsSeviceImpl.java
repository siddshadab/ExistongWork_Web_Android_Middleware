package com.infrasofttech.microfinance.servicesimpl;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.infrasofttech.microfinance.entityBeans.master.GuarantorEntity;
import com.infrasofttech.microfinance.entityBeans.master.SecondaryUserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.repository.SecondaryUserMasterRepository;
import com.infrasofttech.microfinance.repository.SystemParameterRepository;
import com.infrasofttech.microfinance.repository.UserMasterDetailsRepository;
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



	@Override	 
	@Transactional
	public ResponseEntity<UserMasterEntity> loadUserByMusrcode( String musrcode, String musrpass,String mRegDevMacId) {
		int merror = 99;
		UserMasterEntity user = null ;
		SecondaryUserMasterEntity secondaryUserMaster = null;
		SystemParameterEntity systemParameterEntity = null;
		System.out.println("Password recieved as  : "+ musrpass +"and "+ musrcode );		
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
			else if(mRegDevMacId==null||mRegDevMacId.trim()==""||mRegDevMacId.trim()=="null") {
				String merrormessage = "Login From Latest Apk";
				user = null;
				user= new UserMasterEntity();
				merror =  99;
				setUserEntityErrors(merror,merrormessage,user );				
			}
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
    				secondaryUserMaster.setMstatus(7);
    				System.out.println("status set");
    				secondaryUserMaster.setMregdevicemacid(mRegDevMacId);
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
    				String merrormessage = "Please Change Password";	
    				
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
				System.out.println(mRegDevMacId);
				int attemps = 7;
				try {
					 systemParameterEntity = systemParameterRepo.findByCode("NOOFBADLOGINS");
					 attemps = Integer.parseInt(systemParameterEntity.getMcodevalue().trim());	
				}catch(Exception e) {
					attemps =7;
				}
				
				if(secondaryUserMaster.getMnoofbadlogins()>=attemps) {
					System.out.println("No Of Bad Login exceeds");
					String merrormessage = "No Of Bad Login Exceeds";
					user = null;				
					user= new UserMasterEntity();
					setUserEntityErrors(merror,merrormessage,user );	
				}else if(secondaryUserMaster.getMusrpass().equals(musrpass)&&secondaryUserMaster.getMstatus()==7
						&&secondaryUserMaster.getMregdevicemacid().equals(mRegDevMacId)
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
						&&musrpass.equals(secondaryUserMaster.getMusrpass())
						&&secondaryUserMaster.getMregdevicemacid().equals(mRegDevMacId)) {
					System.out.println("Next Passwroed CHange Date exceeded");
					user.setMerrormessage(" Password Change Required");
					user.setMnextpwdchgdt(secondaryUserMaster.getMnextpwdchgdt());
					user.setMusrpass(secondaryUserMaster.getMusrpass());
					user.setMerror(50);
					user.setMusrpass(secondaryUserMaster.getMusrpass());
					user.setMregdevicemacid(secondaryUserMaster.getMregdevicemacid());
					updateUserMnoofbadlogins(secondaryUserMaster.getMusrcode() ,secondaryUserMaster.getMnoofbadlogins()+1);
				}
				else if(secondaryUserMaster.getMusrpass().equals(musrpass)&& secondaryUserMaster.getMstatus()==1&&
						secondaryUserMaster.getMregdevicemacid().equals(mRegDevMacId)	) {
					
					System.out.println(Constants.allowedLicenseDate);
					 Duration duration = Duration.between( LocalDateTime.now(),Constants.allowedLicenseDate);
					System.out.println("xxxxxxxxxxxxxye hai " + duration.toDays()  );
					if(duration.toDays()<10) {
						user.setMerrormessage("License Will Expire on "+ Constants.allowedLicenseDate.toLocalDate());
						user.setMerror(10);
						merror = 10;
					}else {						
						user.setMerrormessage("Sucessfully LoggedIn");
						user.setMerror(0);
						user.setMlocationtrackeronoff(secondaryUserMaster.getMlocationtrackeronoff());
						user.setMpathtrackeronoff(secondaryUserMaster.getMpathtrackeronoff());
						user.setProfileimage(secondaryUserMaster.getProfileimage());
					}
					System.out.println("all conditions matched");
					
					user.setMusrpass(secondaryUserMaster.getMusrpass());
					user.setMregdevicemacid(secondaryUserMaster.getMregdevicemacid());
					user.setMnextpwdchgdt(secondaryUserMaster.getMnextpwdchgdt());
					user.setMstatus(1);
					user.setMnoofbadlogins(secondaryUserMaster.getMnoofbadlogins());
				}
				else if(secondaryUserMaster.getMusrpass().equals(musrpass)&& (secondaryUserMaster.getMstatus()==1||
						secondaryUserMaster.getMstatus()==7
						)&&
						!secondaryUserMaster.getMregdevicemacid().equals(mRegDevMacId)	) {
						System.out.println("Different MAC ID");	
					String merrormessage = "Login from registered device";
					user = null;
					user= new UserMasterEntity();
					setUserEntityErrors(merror,merrormessage,user );	
					updateUserMnoofbadlogins(secondaryUserMaster.getMusrcode() ,secondaryUserMaster.getMnoofbadlogins()+1);
				}
				else {
					System.out.println("No conditions matched");
					String merrormessage = "User Name or password is incorrect";
					user = null;
					user= new UserMasterEntity();
					setUserEntityErrors(merror,merrormessage,user );	
					updateUserMnoofbadlogins(secondaryUserMaster.getMusrcode() ,secondaryUserMaster.getMnoofbadlogins()+1);
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

	@Override
	public ResponseEntity<UserMasterEntity> changePassword(String muserCode, String oldPass, String newPass,
			String mregisterdMacId) {
		int merror = 99;
		UserMasterEntity user = null ;
		SecondaryUserMasterEntity secondaryUserMaster = null;
		System.out.println("Password recieved as  : "+ oldPass+"and User Code "+ muserCode );
		try {
			secondaryUserMaster = secondaryUserMasterRepo.findDataByUsrCode(muserCode ); 
			System.out.println("trying to find user");
			 user  = (UserMasterEntity) userRepository.findByMusrcode(muserCode);
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
					String oldPass2 = secondaryUserMaster.getMoldpass2();
					String oldPass3 = secondaryUserMaster.getMoldpass3();
					
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
							i = secondaryUserMasterRepo.updateUserPassOneBlank(muserCode, newPass, mregisterdMacId,1,oldPass);	
						}
						else if(oldPass2 == null) {
							 i = secondaryUserMasterRepo.updateUserPassTwoBlank(muserCode, newPass, mregisterdMacId,1,oldPass,oldPass1);
						}
						else {
							i = secondaryUserMasterRepo.updateUserPassThreeBlank(muserCode, newPass, mregisterdMacId,1,oldPass,oldPass1,oldPass2);
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

	@Override
	public ResponseEntity<List<UserMasterEntity>> getHerarchy(String musrcode) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	@Transactional
	@Override
		public ResponseEntity<?> addList(UserMasterEntity userMasterEntity) {

		try {
			return new ResponseEntity<Object>(userRepository.save(userMasterEntity),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	
	@Override
	public ResponseEntity<UserMasterEntity> resetPassword(String musrcode, String resetPass) {
		// TODO Auto-generated method stub
		
		//Primary table update and reset mnoofbadlogins	
	  
	    
	    try {
	    	UserMasterEntity userMasterEntity = new UserMasterEntity();
	    	
	    	 int ifRecodeFoundAndUpdated =  userRepository.updateToResetPassword(resetPass,musrcode);
	 	    
	 	    if(ifRecodeFoundAndUpdated >0) {
	 	    	secondaryUserMasterRepo.deleteExistingRecords(musrcode);
	 	    	userMasterEntity.setMerrormessage("password reset sucessfully");
	 	    	userMasterEntity.setMerror(1);
	 	    	
	 	    }else {
	 	    	userMasterEntity.setMerrormessage("Record Not Found for this User Id");
	 	    	userMasterEntity.setMerror(2);
	 	    }
	    	
			return new ResponseEntity<UserMasterEntity>(userMasterEntity,new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}	
	}
	

	@Override
	public int updateUserMnoofbadlogins(String musrcode,int mnoofbadlogins) {
		// TODO Auto-generated method stub
		
	    try {
	    		    	
	    	 int ifRecodeFoundAndUpdated =  secondaryUserMasterRepo.updateUserMnoofbadlogins(musrcode,mnoofbadlogins);
	 	    
	    	
			return  ifRecodeFoundAndUpdated;
		} catch (Exception e) {
			
		}	
	    return 1;
	}
	

	@Transactional
	@Override
	public ResponseEntity<?> updateProfileImage(String musrcode,byte[] profileimage) {
		// TODO Auto-generated method stub
		 int ifRecodeFoundAndUpdated =1;
	    try {	    		    	
	    	ifRecodeFoundAndUpdated =  secondaryUserMasterRepo.updateProfileImage(musrcode,profileimage);
	    
		} catch (Exception e) {
			
		}	
	    return new ResponseEntity<Integer>(ifRecodeFoundAndUpdated,new HttpHeaders(),HttpStatus.OK);
	}
}
