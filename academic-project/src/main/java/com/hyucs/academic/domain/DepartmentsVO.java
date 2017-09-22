package com.hyucs.academic.domain;

public class DepartmentsVO {
	private String dcode;
	private String dname;
	private String college;
	
	public String getDcode() {
		return dcode;
	}
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	
	@Override
	public String toString() {
		return "DepartmentVO [dcode=" + dcode + ", dname=" + dname + ", college=" + college + "]";
	}
}
