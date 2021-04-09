package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterPrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;



@Repository
public interface LoanCycleParameterPrimaryRepository  extends JpaRepository<LoanCycleParameterPrimaryEntity, Long> {
	
	 @Query(value = "Select * from  md045275  WHERE mlbrcode= ?1",nativeQuery = true)
  	 List<LoanCycleParameterPrimaryEntity> findByMlbrCode(int mLbrcode);
	 	
	 @Query(value = "Select * from  md045275  WHERE mcusttype=?1 and meffdate=?2 and mgrtype=?3 and mlbrcode=?4 and mloancycle=?5 and mprdcd=?6",nativeQuery = true)
	 public LoanCycleParameterPrimaryEntity findLoanCycleData(int mcusttype,LocalDateTime meffdate,int mgrtype,int mlbrcode,int mloancycle,String mprdcd);
	 
	 @Modifying
	 @Query(value = "Delete from  md045275  WHERE mcusttype IN (?1) and meffdate IN (?2) and mgrtype IN (?3) and mlbrcode IN (?4) and mloancycle IN (?5) and mprdcd IN (?6)",nativeQuery = true)
	 public void deleteByLoanCycleData(int mcusttype,LocalDateTime meffdate,int mgrtype,int mlbrcode,int mloancycle,String mprdcd);
	  
	 @Query(value = "Delete from  md045275  WHERE mcusttype IN (?1) and meffdate IN (?2) and mgrtype IN (?3) and mlbrcode IN (?4) and mloancycle IN (?5) and mprdcd IN (?6)",nativeQuery = true)
	 public LoanCycleParameterSecondaryEntity deleteAllSecData(int mcusttype,LocalDateTime meffdate,int mgrtype,int mlbrcode,int mloancycle,String mprdcd);
	 
	 @Query(value="SELECT prm.mlbrcode,prm.mprdcd,prm.meffdate,prm.mloancycle,prm.mcusttype,prm.mgrtype,prm.mminamount,prm.mmaxamount,\r\n" + 
	 		"prm.mminperiod,prm.mmaxperiod,prm.mminnoofgrpmems,prm.mmaxnoofgrpmems,prm.mgender,prm.mminage,prm.mmaxage,\r\n" + 
	 		"prm.mgrpcycyn,prm.mlogic,prm.mtenor,prm.mfrequency,prm.mincramount,prm.mnoofinstlclosure,prm.mmultiplefactor,\r\n" + 
	 		"sec.mruletype,sec.msrno,sec.muptoamount FROM md045275 prm INNER JOIN md045375 sec ON prm.mcusttype = sec.mcusttype\r\n" + 
	 		"AND prm.meffdate = sec.meffdate AND prm.mgrtype= sec.mgrtype AND prm.mlbrcode = sec.mlbrcode \r\n" + 
	 		"AND prm.mloancycle = sec.mloancycle AND prm.mprdcd = sec.mprdcd",nativeQuery=true)
	 List<LoanCycleInterface> comboList();
	 
	
	 
	 
	 @Query(value="select * from md045275 ",nativeQuery= true)
	 List<LoanCycleInterface> primaryLoan();
	 
	 @Query(value="select * from md045375 ",nativeQuery= true)
	 List<LoanCycleInterface> secondaryLoan();
	 
	 @Query(value="select * from md045375 where mcusttype=?1 and meffdate=?2 and mgrtype=?3 and mlbrcode=?4 and mloancycle=?5 and mprdcd=?6",nativeQuery = true)
	 List<LoanCycleParameterSecondaryEntity> secondaryLoan(int mcusttype,LocalDateTime meffdate,int mgrtype,int mlbrcode,int mloancycle,String mprdcd);
	 
	 
	 public interface LoanCycleInterface{
		
		 public int getMlbrcode();	
		 
		 public String getMprdcd();
		 
		 public LocalDateTime getMeffdate();		    
		    
		 public int getMloancycle();
			
		 public int getMcusttype();      	

		 public int getMgrtype();	
			
		 public Double getMminamount();			
			
		 public Double getMmaxamount(); 		          	
			
		 public String getMfrequency(); 
			
		 public int getMruletype();	//secondary
        	
		 public int getMsrno();	
			   	
		 public Double getMuptoamount(); 
	 }


}
