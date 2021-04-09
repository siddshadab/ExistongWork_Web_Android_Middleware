package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.ContactPointVerificationEntity;

public interface ContactPointVerificationRepository  extends JpaRepository<ContactPointVerificationEntity, Long>{

	
	@Modifying
	@Query(value="Delete  FROM  Contact_Point_Verification_Entity where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mCustRefno);
	
	@Query(value="SELECT * FROM  Contact_Point_Verification_Entity WITH (NOLOCK) where mrefno=?1 ",nativeQuery = true)
	ContactPointVerificationEntity findByMrefno(int mrefno);

}
