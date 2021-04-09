package com.infrasofttech.microfinance.entityBeans.master;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "cgt1qadetails")
@Data
public class CheckListCGT1Entity {
	
     @Column(name = "tclcgt1refno",  nullable = false, columnDefinition = "numeric(8)")               
	 private int tclcgt1refno;
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "mclcgt1refno", unique = true, nullable = false,  columnDefinition = "numeric(8)" )
	 private int mclcgt1refno;
	 @Column(name = "mleadsid",  columnDefinition = "NVarChar(16)")
	 private String mleadsid;
	 @Column(name = "mquestionid",  columnDefinition = "numeric(2)")
	 private String mquestionid;
	 @Column(name = "manschecked",  columnDefinition = "numeric(8)")
	 private int manschecked;
	/*
	 * @Column(name = "mproctype", columnDefinition = "NVarChar(8)") private String
	 * mproctype;
	 */

	
	/*
	 * @EmbeddedId private CheckListCompositePrimaryEntity compositeCheckListId;
	 * 
	 * @Column private String questionDesc;
	 * 
	 * @Column private String remarks;
	 */
	 

	 @ManyToOne(fetch = FetchType.EAGER, cascade=CascadeType.ALL)
	 @JoinColumns({
		  @JoinColumn(name = "mrefno"),		  
			})	
	 @OnDelete(action = OnDeleteAction.CASCADE)
	 @JsonIgnore
	 private CGT1Entity  checkListCgt1Entity;

	 
	/*
	 * @ManyToOne()
	 * 
	 * @JoinColumns({
	 * 
	 * @JoinColumn(name = "mrefnocgt1" , referencedColumnName="mrefno"), })
	 * 
	 * @OnDelete(action = OnDeleteAction.CASCADE)
	 * 
	 * @JsonIgnore private CGT1Entity checkListCgt1Entity;
	 */
	 
	/*
	 * @ManyToOne()
	 * 
	 * @JoinColumns({
	 * 
	 * @JoinColumn(name = "mrefnocgt2" , referencedColumnName="mrefno"), })
	 * 
	 * @OnDelete(action = OnDeleteAction.CASCADE)
	 * 
	 * @JsonIgnore private CGT2Entity checkListCgt2Entity;
	 * 
	 * @ManyToOne()
	 * 
	 * @JoinColumns({
	 * 
	 * @JoinColumn(name = "mrefnogrt" , referencedColumnName="mrefno"), })
	 * 
	 * @OnDelete(action = OnDeleteAction.CASCADE)
	 * 
	 * @JsonIgnore private GRTEntity checkListGrtEntity;
	 */
	        
	   	 
}
