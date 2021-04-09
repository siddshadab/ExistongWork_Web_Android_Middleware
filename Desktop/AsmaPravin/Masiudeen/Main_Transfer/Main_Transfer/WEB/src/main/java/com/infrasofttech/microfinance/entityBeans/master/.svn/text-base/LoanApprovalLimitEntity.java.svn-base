
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
@Table(name = "md045286")
@Data
public class LoanApprovalLimitEntity  {


	@EmbeddedId
	private LoanApprovalLimitCompositeEntity loanApprovalLimitCompositeEntity;

	@Column(name = "mprdcd",  columnDefinition = "nvarchar(8) default ''" )     	
	private String mprdcd; 
	@Column(name = "mlimitamt")
	private Double mlimitamt = 0d;
	@Column(name = "moverduedays",  columnDefinition = "numeric(8) default 0" )            	
	private int moverduedays;
	@Column(name = "mloanacmindrbal")
	private Double mloanacmindrbal = 0d;
	@Column(name = "mloanacmincrbal")
	private Double mloanacmincrbal = 0d;
	@Column(name = "mwriteoffamt")
	private Double mwriteoffamt = 0d;
	@Column(name = "mremarks",  columnDefinition = "nvarchar(10) default ''" )  	
	private String mremarks;	
	@Column(name = "mcheqlimitamt")
	private Double mcheqlimitamt= 0d;
	@Column(name = "mminintrate")
	private Double mminintrate= 0d;
	@Column(name = "mmaxintrate")
	private Double mmaxintrate = 0d;
	@Column(name = "mlastsynsdate ")   	
	private LocalDateTime mlastsynsdate;	



}
