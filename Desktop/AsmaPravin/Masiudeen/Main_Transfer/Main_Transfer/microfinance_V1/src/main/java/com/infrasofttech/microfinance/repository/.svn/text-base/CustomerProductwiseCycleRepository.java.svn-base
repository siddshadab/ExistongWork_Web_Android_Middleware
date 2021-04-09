package com.infrasofttech.microfinance.repository;
import java.time.LocalDateTime;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.infrasofttech.microfinance.entityBeans.master.CustomerProductwiseCycleEntity;



@Repository
public interface CustomerProductwiseCycleRepository  extends JpaRepository<CustomerProductwiseCycleEntity, Long> {

	
	  @Modifying
	  @Query(
	  value="SELECT * FROM  md009097 where mcreatedby=?1 AND mcreateddt > ?2 OR mlastupdatedt > ?2",nativeQuery = true)
	  List<CustomerProductwiseCycleEntity>findByCreatedbyAndDateTime(String mcreatedby,LocalDateTime lastsynsdate);
	  
	  @Modifying
	  @Query(value="SELECT * FROM  md009097 where mcreatedby=?1 ",nativeQuery =true)
	  List<CustomerProductwiseCycleEntity> findByCreatedby(String mcreatedby);
	  
	

	 
}
