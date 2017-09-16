package com.hyucs.academic.domain;

import java.sql.Date;

public class ProfessorsVO {
	private String pcode;
	private String pname;
	private String dept;
	private Date hireDate;
	private String title;
	private int salary;
	private String picture;
	
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public Date getHireDate() {
		return hireDate;
	}
	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	
	@Override
	public String toString() {
		return "ProfessorsVO [pcode=" + pcode + ", pname=" + pname + ", dept=" + dept + ", hireDate=" + hireDate
				+ ", title=" + title + ", salary=" + salary + ", picture=" + picture + "]";
	}
}
