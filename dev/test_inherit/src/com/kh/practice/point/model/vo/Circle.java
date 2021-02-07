package com.kh.practice.point.model.vo;

public class Circle extends Point {
		
	private int radius;
	
	
	public Circle() {};
	
	public Circle(int x, int y, int radius) {
		this.radius = radius;
	}
	
	public String toString() {
		return Integer.toString(radius);
	}
}
