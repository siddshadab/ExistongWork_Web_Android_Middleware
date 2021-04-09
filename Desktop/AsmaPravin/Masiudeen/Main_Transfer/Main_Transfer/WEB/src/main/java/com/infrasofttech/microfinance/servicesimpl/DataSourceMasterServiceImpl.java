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
import com.infrasofttech.microfinance.repository.DataSourceRepository;
import com.infrasofttech.microfinance.repository.UserMasterDetailsRepository.UserMasterHolderInterface;
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


			List<String> resultExtract = template.query(
					dataSourceMasterEntity.getMurl(),new RowMapper<String>(){
						public String mapRow(ResultSet rs, int rowNum) 
								throws SQLException {
							String str = "";
							String columnNames = null;
							int columnCount = 0;

							final ResultSetMetaData metaData = rs.getMetaData();
							columnCount = metaData.getColumnCount();
				
							while (rs.next()) {
								for (int columnIndex = 0; columnIndex < columnCount; columnIndex++) {
									if(columnIndex>0 && columnIndex!=columnCount) {
									columnNames = columnNames+" ,"+metaData.getColumnName(columnIndex +1 )+" : "+rs.getObject(columnIndex+1 );
									}else {
										columnNames = columnNames+"{ "+metaData.getColumnName(columnIndex +1)+" : "+rs.getObject(columnIndex +1);
									}
								}
								columnNames = columnNames+"} \n";
							}			

							return columnNames;
						}
					});

			for(String obj :resultExtract) {
				System.out.print(obj.toString());

			}

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
	
	
	
	
	@Transactional
	@Override
	public ResponseEntity<?> getAllData(DataSourceMasterEntity dataSourceMasterEntity) {
		List<DataSourceMasterEntity> userDesc = repo.findAll();
		try {
			if(userDesc == null) 
				return ResponseEntity.notFound().build();
			return new ResponseEntity<Object>(userDesc,new HttpHeaders(),HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(new HttpHeaders(),HttpStatus.UNPROCESSABLE_ENTITY);
		}
		
	}

}
