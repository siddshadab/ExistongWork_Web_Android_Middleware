package com.infrasofttech.microfinance.entityBeans.master;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "UserAccessRights")
@Data
public class UserAccessRightsEntity {

	 private static final long serialVersionUID = 1L;


	 @EmbeddedId
	 private UserAccressRightsCompositeEntity userAccressRightsCompositeEntity; 	
	 
	 @Column(name = "createe",  nullable = false, columnDefinition = "numeric(8) default 0")               
	 private int createe = 0;	
	 @Column(name = "modifye",  nullable = false, columnDefinition = "numeric(8) default 0")               
	 private int modifye = 0;	
	 @Column(name = "browsee",  nullable = false, columnDefinition = "numeric(8) default 0")               
	 private int browsee = 0;	
	 @Column(name = "authoritye",  nullable = false, columnDefinition = "numeric(8) default 0")               
	 private int authoritye = 0;	
	 @Column(name = "deletee",  nullable = false, columnDefinition = "numeric(8) default 0")               
	 private int deletee = 0;	
}



