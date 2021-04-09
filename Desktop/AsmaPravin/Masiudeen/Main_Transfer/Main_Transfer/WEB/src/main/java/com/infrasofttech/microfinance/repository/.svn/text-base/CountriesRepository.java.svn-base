package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;

@Repository
public interface CountriesRepository extends JpaRepository<CountriesEntity, Long> {
	
//	
//		@Query(value="FROM CountriesEntity as countries,StatesEntity as states,DistrictsEntity as districts WHERE "
//				+ "states.countryID=countries.countryID AND states.statesID=districts.statesID AND countryName =?1")
//	
//	  //List<CountriesEntity> findByCountryName(String countryname); 
//		List<CountriesEntity> findByCountryID(String mcountryid);
	 
	@Query(value="Select * from md500027 where mcountryid=?1",nativeQuery=true)
	public CountriesEntity findCountry(String mcountryid);
	
	
	
	@Modifying
	@Query(value="Delete from md500027 where mcountryid=?1",nativeQuery=true)
	public void deleteCountries(String mcountryid);

	
	//bulk delete
	@Modifying
	@Query(value="Delete from md500027 where mcountryid IN (?1)",nativeQuery=true)
	void bulkDelete(List<String> mcountryid);
}
