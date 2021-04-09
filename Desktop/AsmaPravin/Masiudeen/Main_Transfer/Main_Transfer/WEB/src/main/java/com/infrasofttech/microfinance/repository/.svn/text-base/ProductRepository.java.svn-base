package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.ProductComposieEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.ProductMasterHolder;

public interface ProductRepository extends JpaRepository<ProductEntity, Long> {
	
	@Query(value="SELECT * FROM  md009021 where mlbrcode =?1",nativeQuery = true)
	public List<ProductEntity> findBymlbrcode(int mlbrcode);
	
	@Query(value="SELECT * FROM  md009021 where mlbrcode =?1 And mprdcd =?2",nativeQuery = true)
	public List<ProductEntity> findProduct(int mlbrcode, String string);
	
	@Query(value="SELECT * FROM  md009021 where mlbrcode =?1 And mprdcd =?2",nativeQuery = true)
	public ProductEntity findProd(int mlbrcode, String mprdcd);
	
	@Modifying
	@Query(value="DELETE FROM  md009021 where mlbrcode =?1 And mprdcd =?2",nativeQuery = true)
	public void deleteProduct(int mlbrcode, String mprdcd);
	
	@Query(value="Select mprdcd, mname from md009021", nativeQuery=true)
	public List<ProductHolderInterface> findByProductCd();
	
	public static interface ProductHolderInterface{
		public String getMprdCd();
		public String getMname();
	}
	
	@Query(value="select * from md009021  WITH (NOLOCK) Order BY mcreateddt desc",nativeQuery=true)
	List<ProductEntity> findAllProduct();
	//multiple delete
	
		@Modifying
		@Query(value="Delete  FROM  md009021  where  mlbrcode IN (?1) and mprdcd IN (?2)",nativeQuery = true)
		void deleteByBulk(int mlbrcode, String mprdcd);

		@Query(value="Select * from md002001 mlbrcode IN (?1) AND mprdcd IN (?2) ",nativeQuery= true)
		public List<ProductEntity> getDataByLbrCode(List<Integer> mlbrcode,List<String> mpbrcode);
	
}
