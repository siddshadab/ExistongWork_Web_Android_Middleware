package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.infrasofttech.microfinance.entityBeans.master.SpeedoMeterCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "speedometer_master")
@Data
public class SpeedoMeterEntity extends BaseEntity {
	
	@EmbeddedId
    private SpeedoMeterCompositePrimaryEntity compositeSpeedoMeterId;	
	@Column 
	@Lob
	 private byte[] startingfromimg;
	@Column 
	@Lob
	 private byte[] endingfromimg;
	@Column 
	 private double startingpoint;
	@Column 
	 private double endingpoint;
	@Column 
	 private double totmeterreading;
	@Column 
	 private String geoLocation;	       
	@Column 
	 private String geoLatitude;
	@Column 
	 private String geoLongitude;
	
	
	       
	   	 
}
