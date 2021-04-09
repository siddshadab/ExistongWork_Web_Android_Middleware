package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
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
	
	
	@Modifying
    @Query(value = "UPDATE md002001 SET  musrpass = ?1  , mnoofbadlogins = 0  WHERE musrcode = ?2  ",nativeQuery = true)
    int updateToResetPassword(String musrpass,String musrcode);

	
	@Query(value=" SELECT count(distinct(musrcode)) FROM  md002001    ",nativeQuery = true)
	int findDistinctUserCode();
}
