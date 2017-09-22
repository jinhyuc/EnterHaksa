package com.hyucs.academic.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hyucs.academic.domain.DepartmentsVO;
import com.hyucs.academic.service.DepartmentsService;

@RestController
@RequestMapping("/departments")
public class DepartmentsController {
	@Inject
	private DepartmentsService service;
	
	@RequestMapping(value="/{college}", method=RequestMethod.GET)
	public ResponseEntity<List<DepartmentsVO>> listByCollege(@PathVariable("college") String college) {
		ResponseEntity<List<DepartmentsVO>> entity = null;
		
		try {
			entity = new ResponseEntity<>(service.listByCollege(college), HttpStatus.OK);			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
