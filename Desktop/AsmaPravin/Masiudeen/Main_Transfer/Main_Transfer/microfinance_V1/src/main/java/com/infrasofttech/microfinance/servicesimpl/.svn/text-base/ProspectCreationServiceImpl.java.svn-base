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
import com.infrasofttech.microfinance.entityBeans.master.CreditBereauLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.CreditBereauResultMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProspectCreationEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.ProspectHolderBean;
import com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities.Constants;
import com.infrasofttech.microfinance.repository.CreditBereauLoanRepository;
import com.infrasofttech.microfinance.repository.CreditBereauResultMasterRepository;
import com.infrasofttech.microfinance.repository.ProspectCreationRepository;
import com.infrasofttech.microfinance.repository.UserMasterDetailsRepository;
import com.infrasofttech.microfinance.services.ProspectCreationService;

@Service
@Transactional
public class ProspectCreationServiceImpl implements ProspectCreationService {

	@Autowired
	ProspectCreationRepository prospectCreationRepository;
	@Autowired
	CreditBereauResultMasterRepository creditBereauResultMasterRepository;
	@Autowired
	CreditBereauLoanRepository creditBereauLoanRepository;
	@Autowired
	UserMasterDetailsRepository userRepository;



	@Override
	public ResponseEntity<?> getAllProspectData() {
		try {
			List<ProspectCreationEntity> prospectList=prospectCreationRepository.findAll();
			if(prospectList.isEmpty()) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<List<ProspectCreationEntity>>(prospectList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			//logger.error("No Record Found."+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	@Override
	public ResponseEntity<?> addList(List<ProspectCreationEntity> prospect) {
		try {	 

			return new ResponseEntity<Object>(prospectCreationRepository.saveAll(prospect),new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	@Override
	public ResponseEntity<?> addProspectListByHolder(List<ProspectHolderBean> prospectList) {
		try { 		
			System.out.println("inside try");
			ProspectCreationEntity entityBean = new ProspectCreationEntity();		

			List<CreditBereauLoanEntity> addCreditBereauLoanEntityList;
			CreditBereauResultMasterEntity cbResultEntity  ;
			List<ProspectCreationEntity> prospectReturnList = new ArrayList<ProspectCreationEntity>();
			if(null != prospectList) {
				for(ProspectHolderBean bean :prospectList) {
					/*if(bean.getMlastupdateby()==bean.getMroutedto()) {
						prospectCreationRepository.updateNocCheckResult(bean.getMrefno()
						,bean.getMprospectstatus(),bean.getMlastupdateby(),bean.getMlastupdatedt()
								);




					}*/





					cbResultEntity= bean.getCbResultMasterDetails();




					entityBean = new ProspectCreationEntity();
					addCreditBereauLoanEntityList=new ArrayList<CreditBereauLoanEntity>();

					if(bean.getMrefno()>0) {
						entityBean.setMrefno(bean.getMrefno());
						creditBereauLoanRepository.deleteExistingRecords(bean.getMrefno());
						creditBereauResultMasterRepository.deleteExistingRecords(bean.getMrefno());

					}
					entityBean.setTrefno(bean.getTrefno());
					//entityBean.setMrefno(bean.getMrefno());
					entityBean.setMqueueno(bean.getMqueueno());
					entityBean.setMlbrcode(bean.getMlbrcode());
					entityBean.setMprospectdt(bean.getMprospectdt());
					entityBean.setMnametitle(bean.getMnametitle());
					entityBean.setMprospectname(bean.getMprospectname());
					entityBean.setMmobno(bean.getMmobno());
					entityBean.setMdob(bean.getMdob());
					entityBean.setMotpverified(bean.getMotpverified());
					entityBean.setMcbcheckstatus(bean.getMcbcheckstatus());
					entityBean.setMprospectstatus(bean.getMprospectstatus());
					entityBean.setMadd1(bean.getMadd1());
					entityBean.setMadd2(bean.getMadd2());
					entityBean.setMadd3(bean.getMadd3());
					entityBean.setMhomeloc(bean.getMhomeloc());
					entityBean.setMareacd(bean.getMareacd());
					entityBean.setMvillage(bean.getMvillage());
					entityBean.setMdistcd(bean.getMdistcd());
					entityBean.setMstatecd(bean.getMstatecd());
					entityBean.setMcountrycd(bean.getMcountrycd());
					entityBean.setMpincode(bean.getMpincode());
					entityBean.setMcountryoforigin(bean.getMcountryoforigin());
					entityBean.setMnationality(bean.getMnationality());
					entityBean.setMpanno(bean.getMpanno());
					entityBean.setMpannodesc(bean.getMpannodesc());
					entityBean.setMisuploaded(bean.getMisuploaded());
					entityBean.setMspousename(bean.getMspousename());
					entityBean.setMspouserelation(bean.getMspouserelation());
					entityBean.setMnomineename(bean.getMnomineename());
					entityBean.setMnomineerelation(bean.getMnomineerelation());
					entityBean.setMcreditreporttransdatetype(bean.getMcreditreporttransdatetype());
					entityBean.setMcreditequstage(bean.getMcreditequstage());
					entityBean.setMcreditreporttransdatetype(bean.getMcreditreporttransdatetype());
					entityBean.setMcreditreporttransid(bean.getMcreditreporttransid());
					entityBean.setMcreditrequesttype(bean.getMcreditrequesttype());
					entityBean.setMcreateddt(bean.getMcreateddt());
					entityBean.setMcreatedby(bean.getMcreatedby());

					entityBean.setMlastupdatedt(bean.getMlastupdatedt());		
					entityBean.setMlastupdateby(bean.getMlastupdateby());		
					entityBean.setMgeolocation(bean.getMgeolocation());	
					entityBean.setMgeolatd(bean.getMgeolatd());	
					entityBean.setMgeologd(bean.getMgeologd());	
					entityBean.setMlastsynsdate(bean.getMlastsynsdate());
					entityBean.setMstreet(bean.getMstreet());		
					entityBean.setMhouse(bean.getMhouse());
					entityBean.setMstate(bean.getMstate());
					entityBean.setMcity(bean.getMcity());
					entityBean.setMid1(bean.getMid1());
					entityBean.setMid1desc(bean.getMid1desc());
					entityBean.setMroutedto(bean.getMroutedto());
					entityBean.setIscustcreated(bean.getMiscustcreated());
					entityBean.setMtier(bean.getMtier());
					entityBean.setMcustno(bean.getMcustno());
					entityBean.setMhighmarkchkdt(bean.getMhighmarkchkdt());

					System.out.println(entityBean);
					for(CreditBereauLoanEntity cbLoanEntityBean :  bean.getCbLoanDetails()) {
						System.out.println(" hello");
						cbLoanEntityBean.setLoanDetailsProspectEntity (entityBean);
						addCreditBereauLoanEntityList.add(cbLoanEntityBean);						
					}
					if(bean.getCbResultMasterDetails()!=null) {


						cbResultEntity.setResultDetailsProspectEntity(entityBean);
						entityBean.setCbResultMasterDetails(cbResultEntity);
					}
					entityBean.setCbLoanDetails(addCreditBereauLoanEntityList);


					prospectReturnList.add(prospectCreationRepository.save(entityBean));
				}


				System.out.println("Data Inserted");
			}
			return new ResponseEntity<Object>(prospectReturnList,new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {

			System.out.println("Exception Occured");
			e.printStackTrace();
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}
	/*@Override
	public List<ProspectCreationEntity> getListProspectList(LocalDateTime lastUpdateDt, String agentName) {
		return null;
	}*/
	@Transactional
	@Override
	public ResponseEntity<?> getProspect(LocalDateTime lastSynsTime, String agentName) { 
		// TODO Auto-generated method stub

		try { 
			List<ProspectCreationEntity> prospectReturnList;
			List<UserMasterEntity> userList = userRepository.getHerarchy(agentName);
			int prospectValidityDays;
			if(!Constants.prospectValidityDays.equals("0")) {
				try {
					prospectValidityDays = Integer.parseInt(Constants.prospectValidityDays);
					
				}catch(Exception e) {
					prospectValidityDays = 30;
				}
				
			
				
			}else {
				prospectValidityDays = 30;
			}
			
			LocalDateTime upToDate = LocalDateTime.now().minusDays(prospectValidityDays);


			System.out.println("(Inside it");
			//boolean isNeedWithLastSyncDate=false;

			prospectReturnList = new ArrayList<ProspectCreationEntity>();

			for(UserMasterEntity userEntity:userList) {	 	
				System.out.println("retutned item is " + userEntity.getMusrcode());
				List<ProspectCreationEntity> prospectList =null;
				System.out.println("Upto Date "+ upToDate);
				if(lastSynsTime==null && userList.size()==1) {
					prospectList = prospectCreationRepository.getProspectFromCreatedBy(userEntity.getMusrcode(),upToDate );
				
				}else if(lastSynsTime==null && userList.size()>1) {
					prospectList = prospectCreationRepository.getprspctfrmcrtdByAndprspctstatus(userEntity.getMusrcode(),4,upToDate);
				}else if(lastSynsTime!=null && userList.size()==1) {
					prospectList = prospectCreationRepository.getProspectFromCreatedByAndLastSyncedDate(userEntity.getMusrcode(),lastSynsTime,upToDate);
				
				}else if(lastSynsTime!=null && userList.size()>1) {
					prospectList = prospectCreationRepository.getprspctfrmcrtdByAndprspctstatusAndLastSyncedDate(userEntity.getMusrcode(),4,lastSynsTime, upToDate);
				}
				if(prospectList!=null && !prospectList.isEmpty()) {
					prospectReturnList.addAll(prospectList);
				}
			}
			return new ResponseEntity<List<ProspectCreationEntity>>(prospectReturnList,new HttpHeaders(),HttpStatus.OK);
		}catch(Exception e) {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}

	}
	@Override
	public ResponseEntity<?> addProspectCheckedResult(List<ProspectHolderBean> prospectList) {

		try { 		
			System.out.println("inside try");
			ProspectCreationEntity entityBean = new ProspectCreationEntity();
			List<ProspectCreationEntity> prospectReturnList = new ArrayList<ProspectCreationEntity>();
			for(ProspectHolderBean bean : prospectList) {

				if(bean.getCbResultMasterDetails()!=null) {
					if(bean.getCbResultMasterDetails().getMexpsramt()!=null
							&&bean.getCbResultMasterDetails().getMexpsramt()!=0) {
						
						creditBereauResultMasterRepository.updateExposureAmt
						(bean.getCbResultMasterDetails().getMexpsramt(), bean.getMrefno());
						System.out.println("Exposure Amount updated");
						System.out.println(bean.getCbResultMasterDetails().getMexpsramt());
					}
				}
				for(CreditBereauLoanEntity creditBereauLoanEntity: bean.getCbLoanDetails()) {
					System.out.println("inside");
					
					
					if(creditBereauLoanEntity.getMnocimagestring()!=(null)
							&&!creditBereauLoanEntity.getMnocimagestring().toString().trim().equals("")
							)
					creditBereauLoanRepository.updateNocImageString(creditBereauLoanEntity.getMrefsrno(), creditBereauLoanEntity.getMnocimagestring());

				}
				System.out.println(bean.getMlastupdatedt());
				prospectCreationRepository.updateNocCheckResult(bean.getMrefno(),
						bean.getMprospectstatus(),bean.getMlastupdateby(),
						bean.getMlastupdatedt(),bean.getMlastsynsdate()
						);


			}





			return new ResponseEntity<Object>(prospectReturnList,new HttpHeaders(),HttpStatus.CREATED);
		} catch (Exception e) {

			System.out.println("Exception Occured");
			e.printStackTrace();
			//logger.error("Error While Persisting Object"+e.getMessage());
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}



		// TODO Auto-generated method stu
	}
}
