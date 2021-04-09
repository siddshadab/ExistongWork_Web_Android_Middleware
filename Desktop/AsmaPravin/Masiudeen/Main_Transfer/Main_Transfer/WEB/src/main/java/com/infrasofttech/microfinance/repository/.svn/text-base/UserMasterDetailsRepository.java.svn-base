package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.ProspectCreationEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.HerarchyHolderBean;


@Repository
public interface UserMasterDetailsRepository extends JpaRepository<UserMasterEntity, String> {    
    
	@Query(value="from UserMasterEntity where musrcode =?1")

	public UserMasterEntity findByMusrcode(String musrcode);
	
	
	
	@Query(value="with rcte (musrcode           ," + 
			"	mcreatedby         ," + 
			"	mcreateddt         ," + 
			"	mgeolatd           ," + 
			"	mgeolocation       ," + 
			"	mgeologd           ," + 
			"	missynctocoresys   ," + 
			"	mlastsynsdate      ," + 
			"	mlastupdateby      ," + 
			"	mlastupdatedt      ," + 
			"	mactiveinstn       ," + 
			"	mautologoutperiod  ," + 
			"	mautologoutyn      ," + 
			"	mbadloginsdt       ," + 
			"	mcustaccesslvl     ," + 
			"	memailid           ," + 
			"	merror             ," + 
			"	merrormessage      ," + 
			"	mextnno            ," + 
			"	mgender            ," + 
			"	mgrpcd             ," + 
			"	misloggedinyn      ," + 
			"	mjoindate          ," + 
			"	mlastpwdchgdt      ," + 
			"	mlastsyslidt       ," + 
			"	mmaxbadlginperday  ," + 
			"	mmaxbadlginperinst ," + 
			"	mmobile            ," + 
			"	mnextpwdchgdt      ," + 
			"	mnextsyslgindt     ," + 
			"	mnoofbadlogins     ," + 
			"	mpwdchgforcedyn    ," + 
			"	mpwdchgperioddays  ," + 
			"	mreason            ," + 
			"	mregdevicemacid    ," + 
			"	mreportinguser     ," + 
			"	mstatus            ," + 
			"	msusdate           ," + 
			"	musrbrcode         ," + 
			"	musrdesignation    ," + 
			"	musrname           ," + 
			"	musrpass           ," + 
			"	musrshortname      ) as" + 
			"(select  e.musrcode           ," + 
			"	e.mcreatedby         ," + 
			"	e.mcreateddt         ," + 
			"	e.mgeolatd           ," + 
			"	e.mgeolocation       ," + 
			"	e.mgeologd           ," + 
			"	e.missynctocoresys   ," + 
			"	e.mlastsynsdate      ," + 
			"	e.mlastupdateby      ," + 
			"	e.mlastupdatedt      ," + 
			"	e.mactiveinstn       ," + 
			"	e.mautologoutperiod  ," + 
			"	e.mautologoutyn      ," + 
			"	e.mbadloginsdt       ," + 
			"	e.mcustaccesslvl     ," + 
			"	e.memailid           ," + 
			"	e.merror             ," + 
			"	e.merrormessage      ," + 
			"	e.mextnno            ," + 
			"	e.mgender            ," + 
			"	e.mgrpcd             ," + 
			"	e.misloggedinyn      ," + 
			"	e.mjoindate          ," + 
			"	e.mlastpwdchgdt      ," + 
			"	e.mlastsyslidt       ," + 
			"	e.mmaxbadlginperday  ," + 
			"	e.mmaxbadlginperinst ," + 
			"	e.mmobile            ," + 
			"	e.mnextpwdchgdt      ," + 
			"	e.mnextsyslgindt     ," + 
			"	e.mnoofbadlogins     ," + 
			"	e.mpwdchgforcedyn    ," + 
			"	e.mpwdchgperioddays  ," + 
			"	e.mreason            ," + 
			"	e.mregdevicemacid    ," + 
			"	e.mreportinguser     ," + 
			"	e.mstatus            ," + 
			"	e.msusdate           ," + 
			"	e.musrbrcode         ," + 
			"	e.musrdesignation    ," + 
			"	e.musrname           ," + 
			"	e.musrpass           ," + 
			"	e.musrshortname      " + 
			" from md002001 e, md002001 m where e.mreportinguser" + 
			" = m.musrcode and e.musrcode = ?1 " + 
			"Union all" + 
			"  SELECT  d.musrcode           ," + 
			"	d.mcreatedby         ," + 
			"	d.mcreateddt         ," + 
			"	d.mgeolatd           ," + 
			"	d.mgeolocation       ," + 
			"	d.mgeologd           ," + 
			"	d.missynctocoresys   ," + 
			"	d.mlastsynsdate      ," + 
			"	d.mlastupdateby      ," + 
			"	d.mlastupdatedt      ," + 
			"	d.mactiveinstn       ," + 
			"	d.mautologoutperiod  ," + 
			"	d.mautologoutyn      ," + 
			"	d.mbadloginsdt       ," + 
			"	d.mcustaccesslvl     ," + 
			"	d.memailid           ," + 
			"	d.merror             ," + 
			"	d.merrormessage      ," + 
			"	d.mextnno            ," + 
			"	d.mgender            ," + 
			"	d.mgrpcd             ," + 
			"	d.misloggedinyn      ," + 
			"	d.mjoindate          ," + 
			"	d.mlastpwdchgdt      ," + 
			"	d.mlastsyslidt       ," + 
			"	d.mmaxbadlginperday  ," + 
			"	d.mmaxbadlginperinst ," + 
			"	d.mmobile            ," + 
			"	d.mnextpwdchgdt      ," + 
			"	d.mnextsyslgindt     ," + 
			"	d.mnoofbadlogins     ," + 
			"	d.mpwdchgforcedyn    ," + 
			"	d.mpwdchgperioddays  ," + 
			"	d.mreason            ," + 
			"	d.mregdevicemacid    ," + 
			"	d.mreportinguser     ," + 
			"	d.mstatus            ," + 
			"	d.msusdate           ," + 
			"	d.musrbrcode         ," + 
			"	d.musrdesignation    ," + 
			"	d.musrname           ," + 
			"	d.musrpass           ," + 
			"	d.musrshortname " + 
			"  FROM md002001 d" + 
			"    , rcte r" + 
			"      where  d.mreportinguser = r.musrcode" + 
			")" + 
			"select * from rcte",nativeQuery = true)
	public List<UserMasterEntity> getHerarchy(String userCode);

	@Query(value="Select TOP 50 * from md002001 with (NOLOCK))",nativeQuery=true)
	List<UserMasterEntity> allUsers();
	
	@Query(value="Select * from md002001 where musrcode=?1",nativeQuery= true)
	public List<UserMasterEntity> getDataByUsrCd(String musrcode);


	@Query(value="Select * from md002001 where mgrpcd=?1",nativeQuery= true)
	public List<UserMasterEntity> findUserByGrpCd(int mgrpcd);
	
	@Query(value="delete musrcode FROM md002001 a JOIN md002026 b ON a.musrcode = b.musrcode WHERE a.musrcode =?1",nativeQuery= true)
	public List<UserMasterEntity> deleteByUsrCd(String  musrcode);	
	
	
	@Query(value = "UPDATE md002001 SET mprdacctid = ?2 ,mlastupdatedt =?3, missynctocoresys=3 WHERE mrefno = ?1  ",nativeQuery = true)
	public List<UserMasterEntity> updateByUsrCd(String  musrcode);
	
	@Query(value = "select * FROM md002001 WHERE musrcode =?1 ", nativeQuery=true)
	public UserMasterEntity findByUserCode(String musrcode);

	
	@Query(value="select musrcode, musrname from md002001",nativeQuery=true)
	public List<UserMasterHolderInterface> getUsrCdDesc();
	
	public static  interface UserMasterHolderInterface {
		public String getMusrcode();		
		public String getMusrName();
	}
	
	@Query(value="select musrcode FROM md002001",nativeQuery=true)
	public List<Object> getUsrCd();
	
	
	@Query(value="select * from md002001 WITH (NOLOCK) Order BY mcreateddt desc",nativeQuery=true)
	public List<UserMasterEntity> findAllUser();
	//multiple delete
	
	@Modifying
	@Query(value="Delete  FROM  md002001  where musrcode IN (?1) ",nativeQuery = true)
	void deleteByBulk(List<String> musrcode);

	@Query(value="Select * from md002001 where musrcode IN (?1) ",nativeQuery= true)
	public List<UserMasterEntity> getDataByUsrCode(List<String> musrcode);
}
