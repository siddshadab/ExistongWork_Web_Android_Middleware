package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;
import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;


@Entity
@Table(name = "md020002")
@Data
public class TDParameterEntity {

	@EmbeddedId
    private TDParameterCompositeEntity tdParameterCompositeEntity;	

	@Column(name = "mdefbatchcd", columnDefinition = "nvarchar(8) default ''")
	private String mdefbatchcd ="";
	@Column(name = "mintfreq", columnDefinition = "nvarchar(1) default ''")
	private String mintfreq ="";
	
	
	
	
	@Column(name = "mmindepamt")
	private Double mmindepamt= 0d;
	@Column(name = "mmaxdepamt")
	private Double mmaxdepamt = 0d;
	@Column(name = "mperiodtype", columnDefinition = "nvarchar(1) default ''")
	private String mperiodtype ="";
	@Column(name = "mmaxperiod", columnDefinition = "numeric(5) default 0")
	private int mmaxperiod = 0;
	@Column(name = "mminperiod", columnDefinition = "numeric(5) default 0")
	private int mminperiod = 0;
	@Column(name = "mnodaysinyear", columnDefinition = "numeric(5) default 0")
	private int mnodaysinyear = 0;
	@Column(name = "mclintcalctype", columnDefinition = "numeric(5) default 0")
	private int mclintcalctype = 0;
	@Column(name = "mtaxprojection", columnDefinition = "nvarchar(1) default ''")
	private String mtaxprojection ="";
	
	
}
