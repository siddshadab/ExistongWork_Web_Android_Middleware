package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;



@Repository
public interface LoanCycleParameterSecondaryRepository  extends JpaRepository<LoanCycleParameterSecondaryEntity, Long> {
	
	 @Query(value = "Select * from  md045375  WHERE mlbrcode= ?1",nativeQuery = true)
		List<LoanCycleParameterSecondaryEntity> findByMlbrCode(int mLbrcode);

	 @Query(value="Select * from md045375 where mcusttype=?1 and meffdate=?2  mfrequency=?3 and grtype=?4,"
	 		+ " mlbrcode=?5 and mloancycle=?6 and mprdcd=?7 and mruletype=?8 and msrno=?9",nativeQuery=true)
	 public LoanCycleParameterSecondaryEntity findByPrmEnt(int mcusttype,LocalDateTime meffdate,
			 String mfrequency, int mgrtype,int mlbrcode,int mloancycle,
			 String mprdcd,int mruletype,int msrno);
	 
	 @Query(value="delete from md045375 where mcusttype =?1 and meffdate =?2 and grtype =?3," + 
		 		" mlbrcode =?4 and mloancycle =?5 and mprdcd =?6",nativeQuery=true)
	 public LoanCycleParameterSecondaryEntity deleteSecondary(int mcusttype,LocalDateTime meffdate,
		 int mgrtype,int mlbrcode,int mloancycle,String mprdcd);

	 @Modifying
	 @Query(value="delete from md045375 where mcusttype IN (?1) and meffdate IN (?2) and mgrtype IN (?3) and mlbrcode IN (?4) and mloancycle IN (?5) and mprdcd IN (?6)",nativeQuery=true)
	  public void deleteByPrmEnt(int mcusttype,LocalDateTime meffdate, int mgrtype,int mlbrcode,int mloancycle,String mprdcd);
	 
	
	 @Query(value="select * from md045375 where mcusttype=?1 and meffdate=?2 and mgrtype=?3 and mlbrcode=?4 and mloancycle=?5 and mprdcd=?6 OR (mfrequency=?7 OR mruletype=?8 OR msrno=?9)",nativeQuery = true)
	 List<LoanCycleParameterSecondaryEntity> secondaryLoan(int mcusttype,LocalDateTime meffdate,int mgrtype,int mlbrcode,int mloancycle,String mprdcd,String mfrequency,int mruletype, int msrno);
	 
	 @Query(value="select * from md045375 where mcusttype=?1 and meffdate=?2 and mgrtype=?3 and mlbrcode=?4 and mloancycle=?5 and mprdcd=?6",nativeQuery = true)
	 List<LoanCycleParameterSecondaryEntity> secLoan(int mcusttype,LocalDateTime meffdate,int mgrtype,int mlbrcode,int mloancycle,String mprdcd);
	
	 
	 @Modifying
	 @Query(value="delete from md045375 where mcusttype =?1 and meffdate=?2 and mfrequency =?3 and mgrtype=?4 and mlbrcode=?5 and mloancycle =?6 and mprdcd=?7 and mruletype=?8 and msrno=?9",nativeQuery=true)
	 void deleteSec(int mcusttype, LocalDateTime meffdate, String mfrequency, int mgrtype, int mlbrcode, int mloancycle,String mprdcd, int mruletype, int msrno);
	 
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
