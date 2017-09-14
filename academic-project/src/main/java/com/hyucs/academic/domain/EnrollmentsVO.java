package com.hyucs.academic.domain;

import java.sql.Date;

public class EnrollmentsVO {
	private String lcode;
	private String lname;
	private String scode;
	private String sname;
	private Date eDate;
	private int grade;
	
	public String getLcode() {
		return lcode;
	}
	public void setLcode(String lcode) {
		this.lcode = lcode;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public Date geteDate() {
		return eDate;
	}
	public void seteDate(Date eDate) {
		this.eDate = eDate;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	@Override
	public String toString() {
		return "EnrollmentsVO [lcode=" + lcode + ", lname=" + lname + ", scode=" + scode + ", sname=" + sname
				+ ", eDate=" + eDate + ", grade=" + grade + "]";
	}
}
