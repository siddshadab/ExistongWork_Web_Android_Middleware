package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.SecondaryUserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;

@Repository
public interface SecondaryUserMasterRepository extends JpaRepository<SecondaryUserMasterEntity, Integer>{

	
	

	@Query(value="SELECT * FROM  md002026 WITH (NOLOCK) where musrcode =?1",nativeQuery = true)
	SecondaryUserMasterEntity findDataByUsrCode(String userCode);
	
	
	
	@Modifying
    @Query(value = "UPDATE md002026 SET musrpass = ?2,mregdevicemacid =?3,mstatus= ?4  WHERE musrcode = ?1  ",nativeQuery = true)
    int updateUserPass( String musrcode, String musrpass,String mregdevmacid,int status);

	
	@Modifying
    @Query(value = "UPDATE md002026 SET musrpass = ?2,mregdevicemacid =?3,mstatus= ?4 ,moldpass1=?5   WHERE musrcode = ?1  ",nativeQuery = true)
    int updateUserPassOneBlank( String musrcode, String musrpass,String mregdevmacid,int status,String oldPass1);

	
	@Modifying
    @Query(value = "UPDATE md002026 SET musrpass = ?2,mregdevicemacid =?3,mstatus= ?4 ,moldpass1=?5,moldpass2=?6 WHERE musrcode = ?1  ",nativeQuery = true)
    int updateUserPassTwoBlank( String musrcode, String musrpass,String mregdevmacid,int status,String oldPass1,String oldPass2);

	
	@Modifying
    @Query(value = "UPDATE md002026 SET musrpass = ?2,mregdevicemacid =?3,mstatus= ?4 ,moldpass1=?5,moldpass2=?6,moldpass3=?7 WHERE musrcode = ?1  ",nativeQuery = true)
    int updateUserPassThreeBlank( String musrcode, String musrpass,String mregdevmacid,int status,String oldPass1,String oldPass2,String oldPass3);

	
	@Modifying
	@Query(value="Delete  FROM  md002026 where musrcode =?1",nativeQuery = true)
	void deleteExistingRecords(String musrcode);
	
	
	@Modifying
    @Query(value = "UPDATE md002026 SET mnoofbadlogins = ?2  WHERE musrcode = ?1  ",nativeQuery = true)
    int updateUserMnoofbadlogins( String musrcode,int mnoofbadlogins);
	
	@Modifying
    @Query(value = "UPDATE md002026 SET profileimage = ?2  WHERE musrcode = ?1  ",nativeQuery = true)
    int updateProfileImage( String musrcode,byte[] profileimage);
	
	

}
