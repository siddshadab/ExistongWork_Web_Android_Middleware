package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.LoanApprovalLimitCompositeEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanApprovalLimitEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanApprovalCompositeHolder;



@Repository
public interface LoanApprovalLimitRepository extends JpaRepository<LoanApprovalLimitEntity, Long> {
	
	 @Query(value = "Select * from  md045286  WHERE mlbrcode= ?1 AND mgrpcd = ?2 AND (musercd =?3  OR musercd= 'ALLUSERS') ",nativeQuery = true)
	 List<LoanApprovalLimitEntity> findByMlbrCodeAndUserCd(int mLbrcode,int mgrpcd,String usrcode);
	 
	 @Query(value = "Select * from  md045286  WHERE mlbrcode= ?1 AND mgrpcd = ?2 AND (musercd =?3 OR musercd= 'ALLUSERS' OR msrno=?4) ",nativeQuery = true)
	 LoanApprovalLimitEntity findByMlbrCodeAndUserCode(int mLbrcode,int mgrpcd,String usrcode,int msrno);
	 
	 @Modifying
	 @Query(value = "DELETE from  md045286  WHERE mlbrcode= ?1 AND mgrpcd = ?2 AND (musercd =?3 OR msrno=?4) ",nativeQuery = true)
	 public void deleteByMlbrCodeAndUserCode(int mLbrcode,int mgrpcd,String usrcode,int msrno);

	 //multiple delete
	 
	 @Modifying
	 @Query(value="Delete  FROM  md045286  where mlbrcode IN (?1) AND mgrpcd IN (?2) AND musercd IN (?3) And msrno IN (?4)",nativeQuery = true)
	 void deleteByBulk(int mLbrcode, int mgrpcd,String usrcode ,int msrno);

	 @Query(value="SELECT * FROM  md045286  where mpbrcode in ?1 ",nativeQuery = true)
	 List<LoanApprovalLimitCompositeEntity> findAllById(int mpbrcode);
	 
	 @Query(value = "Select * from  md045286  WHERE mlbrcode= ?1 AND mgrpcd = ?2 AND musercd =?3 and msrno=?4",nativeQuery = true)
	 public LoanApprovalLimitEntity findByPrmKey(int mlbrcode,int mgrpcd,String musercd,int msrno);

	@Query(value="SELECT loan_approval.*,prd.mname as mprdname FROM md009021 AS prd RIGHT JOIN md045286 as loan_approval ON loan_approval.mprdcd = prd.mprdcd",nativeQuery=true)
	List<LoanApprovalHld> findAllLoanLimit();
	
	@Query(value="select NEW com.infrasofttech.microfinance.entityBeans.master.holder.LoanApprovalCompositeHolder(a.mgrpcd) from md045286 as a",nativeQuery=true)
	List<LoanApprovalCompositeHolder> findAllLimit();
	
	
	public static interface LoanApprovalHld {
		public  int getMlbrcode();	   	
		public int getMgrpcd();  	  	
		public String getMusercd();              	
		public int getMsrno(); 
		
		public String getMprdcd(); 		
		public Double getMlimitamt();		         	
		public int getMoverduedays();
		public Double getMloanacmindrbal();
		public Double getMloanacmincrbal();		
		public Double getMwriteoffamt();			
		public String getMremarks();	
		public Double getMcheqlimitamt();
		public Double getMminintrate();		
		public Double getMmaxintrate();		  	
		public LocalDateTime getMlastsynsdate();
		public String getMprdname();
	}

}