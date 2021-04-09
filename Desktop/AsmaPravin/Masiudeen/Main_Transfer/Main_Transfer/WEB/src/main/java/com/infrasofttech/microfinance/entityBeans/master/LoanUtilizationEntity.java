package com.infrasofttech.microfinance.entityBeans.master;
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import lombok.Data;

@Entity
@Table(name = "loanutilizationmaster")
@Data
public class LoanUtilizationEntity {
	
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno;
    @Column(name = "mcustno",  columnDefinition = "numeric(8) default 0" )
	 private int mcustno;
	  @Column(name = "mcustname",  columnDefinition = "nvarchar(160) default ''" )
	 private String mcustname;
    @Column(name = "mgroupcd",  columnDefinition = "numeric(8) default 0" )
	 private int mgroupcd;
    @Column(name = "mcenterid",  columnDefinition = "numeric(8) default 0" )
	 private int mcenterid;	 
	  @Column(name = "mpurposeofloan",  columnDefinition = "nvarchar(160) default ''" )
	 private String mpurposeofloan;
	  @Column(name = "mleadsid",  columnDefinition = "nvarchar(32) default ''" )
	 private String mleadsid;
	  @Column(name = "mactualutilization",  columnDefinition = "nvarchar(160) default ''" )
	 private String mactualutilization;
	  @Column(name = "mcreateddt" )
	 private LocalDateTime mcreateddt;	
	  @Column(name = "mlastupdatedt" )
	 private LocalDateTime mlastupdatedt;	
	  @Column(name = "musrname",  columnDefinition = "nvarchar(10) default ''" )
	 private String musrname;
	  @Column(name = "mremarks",  columnDefinition = "nvarchar(250) default ''" )
	 private String mremarks;
	
	   	 
}
