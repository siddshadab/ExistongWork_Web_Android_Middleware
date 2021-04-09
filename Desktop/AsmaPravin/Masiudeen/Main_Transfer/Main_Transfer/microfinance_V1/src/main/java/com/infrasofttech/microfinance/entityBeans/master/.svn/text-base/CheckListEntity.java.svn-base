package com.infrasofttech.microfinance.entityBeans.master;

import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "CheckList_master")
@Data
public class CheckListEntity extends BaseEntity {
	
	@EmbeddedId
    private CheckListCompositePrimaryEntity compositeCheckListId;
	@Column 
	 private String questionId;
	@Column 
	 private String screenName;
	@Column 
	 private String questionDesc;
/*	@Column
	 private Long loanNumber;*/
	@Column 
	 private String remarks;
	@Column 
	 private Long isChecked;     
	
	       
	   	 
}
