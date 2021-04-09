package com.infrasofttech.microfinance.entityBeans.master;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import lombok.Data;


@Entity
@Table(name = "glaccountmaster")
@Data
public class GLAccountEntity extends BaseEntity {

	@Column(name = "trefno", nullable = false, columnDefinition = "numeric(8)")
	private int trefno = 0;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int mrefno;
	@Column(name = "mlbrcode", columnDefinition = "numeric(8) default 0")
	private int mlbrcode = 0;
	@Column(name = "mprdacctid",  columnDefinition = "nvarchar(32) default ''" )	
	private String mprdacctid= "";	
	@Column(name = "mlongname", columnDefinition = "nvarchar(250) default ''")
	private String mlongname = "";

}
