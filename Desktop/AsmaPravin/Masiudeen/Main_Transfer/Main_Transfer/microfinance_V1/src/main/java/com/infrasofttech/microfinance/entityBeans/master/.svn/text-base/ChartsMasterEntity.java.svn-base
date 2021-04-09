package com.infrasofttech.microfinance.entityBeans.master;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;


@Entity
@Table(name = "ChartsMaster")
@Data
public class ChartsMasterEntity {

	private static final long serialVersionUID = 1L;



	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno;    	

	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno = 0;

	@Column(name = "mchartid",  nullable = false, columnDefinition = "numeric(8)")               
	private int mchartid = 0;
	
	@Column(name = "mtitle",  columnDefinition = "NVarChar(150) default ''")
	private String mtitle = "";
	
	@Column(name = "mxcatg",  columnDefinition = "NVarChar(50) default ''")
	private String mxcatg = "";
	@Column(name = "mycatg",  columnDefinition = "NVarChar(50) default ''")
	private String mycatg = "";
	@Column(name = "mzcatg",  columnDefinition = "NVarChar(50) default ''")
	private String mzcatg = "";	


	@Column(name = "misonline", columnDefinition = "numeric(4) default 0")
	private int misonline = 0;

	@Column(name = "mquerydesc",  columnDefinition = "NVarChar(250) default ''")
	private String mquerydesc = "";
	@Column(name = "mdefaulttype",  columnDefinition = "NVarChar(30) default ''")
	private String mdefaulttype = "";
	@Column(name = "mquery",  columnDefinition = "NVarChar(1000) default ''")
	private String mquery = "";
	@Column(name = "mtype",  columnDefinition = "NVarChar(30) default ''")
	private String mtype = "";
	@Column(name = "mdatasource",  columnDefinition = "NVarChar(30) default ''")
	private String mdatasource = "";
	@Column(name = "subtitle",  columnDefinition = "NVarChar(250) default ''")
	private String subtitle = "";
	@Column(name = "subdescription",  columnDefinition = "NVarChar(250) default ''")
	private String subdescription = "";
	@Column(name = "image",  columnDefinition = "NVarChar(40) default ''")
	private String image = "";
	@Column(name = "status",  columnDefinition = "NVarChar(30) default ''")
	private String status = "";
	@Column(name = "subdisplaytype",  columnDefinition = "NVarChar(150) default ''")
	private String subdisplaytype = "";
	@Column(name = "subtype",  columnDefinition = "NVarChar(60) default ''")
	private String subtype = "";
	@Column(name = "mkey",  columnDefinition = "NVarChar(60) default ''")
	private String mkey = "";
	@Column(name = "codelink",  columnDefinition = "NVarChar(250) default ''")
	private String codelink = "";
	@Column(name = "premetivedatatype",  nullable = false, columnDefinition = "numeric(8)")               
	private int premetivedatatype = 0;
	@Column(name = "parenttype",  columnDefinition = "NVarChar(150) default ''")
	private String parenttype = "";
	@Column(name = "childtype",  columnDefinition = "NVarChar(400) default ''")
	private String childtype = "";

	
	@Column(name = "xminval",  nullable = false, columnDefinition = "numeric(8)")               
	private int xminval = 0;
	
	@Column(name = "yminval",  nullable = false, columnDefinition = "numeric(8)")               
	private int yminval = 0;
	
	 @Column(name = "xinterval")	 
	 private double xinterval= 0d;
	
	 @Column(name = "yinterval")	 
	 private double yinterval= 0d;
	 
	 
	 @Column(name = "isfavalwed",  nullable = false, columnDefinition = "numeric(1)")               
		private int isfavalwed = 0;
	 
	 
	 @Column(name = "xcaption",  columnDefinition = "NVarChar(50) default ''")
		private String xcaption = "";
	 
	 @Column(name = "ycaption",  columnDefinition = "NVarChar(50) default ''")
		private String ycaption = "";
	 
	 
	 @Column(name = "xcaprot",   columnDefinition = "numeric(3)")               
	private int xcaprot = 0;
	 
	 @Column(name = "ycaprot",   columnDefinition = "numeric(3)")               
		private int ycaprot = 0;
	 
	 
	 @Column(name = "xaxisvsbl",   columnDefinition = "numeric(1)")               
		private int xaxisvsbl = 0;
	 
	 @Column(name = "yaxisvsbl",   columnDefinition = "numeric(1)")               
		private int yaxisvsbl = 0;
	 
	 
	 @Column(name = "islegvis",   columnDefinition = "numeric(1)")               
		private int islegvis = 0;
	 
	 
	 
	 
	 







}

