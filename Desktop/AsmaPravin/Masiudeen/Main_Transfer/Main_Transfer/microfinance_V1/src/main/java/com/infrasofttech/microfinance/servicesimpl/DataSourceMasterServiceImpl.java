package com.infrasofttech.microfinance.servicesimpl;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.master.DataSourceMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CutomerLoanTillGrtHolder;
import com.infrasofttech.microfinance.entityBeans.master.holder.ReportsQueryResponseHolder;
import com.infrasofttech.microfinance.repository.DataSourceRepository;
import com.infrasofttech.microfinance.services.DataSourceMasterService;


@Service
@Transactional
public class DataSourceMasterServiceImpl implements DataSourceMasterService {

	//boolean  isRowNamesTaken = false;

	@Autowired
	DataSourceRepository repo;

	@Transactional
	@Override
	public ResponseEntity<?> dataSourceBySysId(DataSourceMasterEntity dataSourceMasterEntity) {


		DataSourceMasterEntity dataSourceMasterWholeEntity = repo.findByMsystemid(dataSourceMasterEntity.getMsystemid());
		try {
			DataSource dataSource = dataSource(dataSourceMasterWholeEntity.getMdriverclass(),
					dataSourceMasterWholeEntity.getMurl(),
					dataSourceMasterWholeEntity.getMuserid(),dataSourceMasterWholeEntity.getMpassword());
			JdbcTemplate template = jdbcTemplate(dataSource); 


			List<ReportsQueryResponseHolder> resultExtract = template.query(
					dataSourceMasterEntity.getMurl(),new RowMapper<ReportsQueryResponseHolder>(){
						public ReportsQueryResponseHolder mapRow(ResultSet rs, int rowNum) 
								throws SQLException {
							String str = "";
							String columnNames = "";
							int columnCount = 0;

							final ResultSetMetaData metaData = rs.getMetaData();
							columnCount = metaData.getColumnCount();
				
							do {
								for (int columnIndex = 0; columnIndex < columnCount; columnIndex++) {
									if(columnIndex>0 && columnIndex!=columnCount) {
									columnNames = columnNames+" ,"+metaData.getColumnName(columnIndex +1 )+" : "+rs.getObject(columnIndex+1 );
									}else {
										columnNames = columnNames+"{ "+metaData.getColumnName(columnIndex +1)+" : "+rs.getObject(columnIndex +1);
									}
								}
								if(columnNames!=null) {
								columnNames = columnNames+"} ";
								}
							}while (rs.next());			

							ReportsQueryResponseHolder  reportsQueryResponseHolder = new ReportsQueryResponseHolder();
							reportsQueryResponseHolder.setValue(columnNames);
							return reportsQueryResponseHolder;
						}
					});

			for(ReportsQueryResponseHolder obj :resultExtract) {
			
							System.out.println("Values xxxxxxxxxxxxxxxxx "+obj.getValue());
			}		
			return new ResponseEntity<List<ReportsQueryResponseHolder>>(resultExtract,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		} 

		return null;
	}


	public  DataSource dataSource(String driverClass,String url,String userName,String password) {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(driverClass);
		dataSource.setUrl(url);
		dataSource.setUsername(userName);
		dataSource.setPassword(password);
		return dataSource;
	}


	public  JdbcTemplate jdbcTemplate(DataSource dataSource) {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		jdbcTemplate.setResultsMapCaseInsensitive(true);
		return jdbcTemplate;
	}
}
