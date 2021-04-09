package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.ChartsMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.MenuAndAccessRightsHolderBean;



@Repository
public interface ChartsMasterRepository extends JpaRepository<ChartsMasterEntity, Long> {
	
	
	@Query(value="SELECT * FROM  Charts_Master  where mchartid =?1 ",nativeQuery = true)
	ChartsMasterEntity findByMchartid(int mchartid);
	
	
	@Query(value="\r\n" + 
			"SELECT  \r\n" + 
			"    charts.mrefno as mrefno  ,	\r\n" + 
			"	charts.trefno as trefno,	\r\n" + 
			"	charts.mchartid as mchartid,	\r\n" + 
			"	charts.mtitle as mtitle,	\r\n" + 
			"	charts.mxcatg as mxcatg,	\r\n" + 
			"	charts.mycatg as mycatg,	\r\n" + 
			"	charts.mzcatg as mzcatg,	\r\n" + 
			"	charts.misonline as misonline,	\r\n" + 
			"	charts.mquerydesc as mquerydesc,	\r\n" + 
			"	charts.mdefaulttype as mdefaulttype,	\r\n" + 
			"	charts.mquery as mquery,	\r\n" + 
			"	charts.mtype as mtype,	\r\n" + 
			"	charts.mdatasource as mdatasource,	\r\n" + 
			"	charts.subtitle as subtitle,	\r\n" + 
			"	charts.subdescription as subdescription,	\r\n" + 
			"	charts.image as image,	\r\n" + 
			"	charts.status as status,	\r\n" + 
			"	charts.subdisplaytype  as subdisplaytype,	\r\n" + 
			"	charts.subtype as subtype,	\r\n" + 
			"	charts.mkey as mkey,	\r\n" + 
			"	charts.codeLink as codeLink,	\r\n" + 
			"	charts.premetivedatatype as premetivedatatype,	\r\n" + 
			"	charts.parenttype as parenttype,	\r\n" + 
			"	charts.childtype as childtype ,	\r\n" + 
			"	charts.xinterval as xinterval ,	\r\n" +
			"	charts.yinterval as yinterval ,	\r\n" +
			"	charts.xminval as xminval ,	\r\n" +
			"	charts.yminval as yminval 	\r\n" +
			"FROM   Charts_Master  charts\r\n" + 
			"INNER JOIN Menu_Master  menuMaster \r\n" + 
			"    ON charts.mchartid = menuMaster.mchartid\r\n" + 
			"INNER JOIN User_Access_Rights  userAccess \r\n" + 
			"    ON menuMaster.menuid = userAccess.menuid "
			+ " where userAccess.mgrpcd = ?2 AND (userAccess.musrcode =?1 OR userAccess.musrcode ='ALLUSERS')"
			+ " AND charts.mchartid <>0",nativeQuery = true)
	//public List<MenuAndAccessRightsHolderBean> getJoinAllthreeTables(String muserCode,int mgrpcd);
	public List<ChartsMasterEntity> getJoinAllthreeTables(String muserCode,int mgrpcd);
	
	//crud
	
	@Query(value="select * from charts_master where mrefno =?1",nativeQuery= true)
	public ChartsMasterEntity findByMrefno(int mrefno);


	@Query(value="Delete from charts_master where mrefno IN (?1)",nativeQuery= true)
	void deleteByMrefno(List<Integer> mrefno);
}