package com.hyucs.academic.domain;

public class CoursesVO {
	private String lcode;
	private String lname;
	private Integer hours;
	private String room;
	private String instructor;
	private Integer capacity;
	private Integer persons;
	private String pname;
	
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
	public Integer getHours() {
		return hours;
	}
	public void setHours(Integer hours) {
		this.hours = hours;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getInstructor() {
		return instructor;
	}
	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}
	public Integer getCapacity() {
		return capacity;
	}
	public void setCapacity(Integer capacity) {
		this.capacity = capacity;
	}
	public Integer getPersons() {
		return persons;
	}
	public void setPersons(Integer persons) {
		this.persons = persons;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	
	@Override
	public String toString() {
		return "CoursesVO [lcode=" + lcode + ", lname=" + lname + ", hours=" + hours + ", room=" + room
				+ ", instructor=" + instructor + ", capacity=" + capacity + ", persons=" + persons + ", pname=" + pname
				+ "]";
	}
}
