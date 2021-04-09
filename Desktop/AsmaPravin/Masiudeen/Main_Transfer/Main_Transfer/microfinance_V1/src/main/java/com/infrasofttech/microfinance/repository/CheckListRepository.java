package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.infrasofttech.microfinance.entityBeans.master.CheckListEntity;

public interface CheckListRepository extends JpaRepository<CheckListEntity, Long> {

}
