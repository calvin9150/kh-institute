package com.common.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

//Wrapper클래스를 만들려면 extends HttpServeltRequestWrapper 한다.
public class MyWrapper extends HttpServletRequestWrapper{
	//Wrapper클래스의 목적...???
	//HttpServletRequest객체가 제공하는 매소드를 커스터마이징하기 위해
	//내가 사용하고 싶은 방법으로 변경할 수있게 해줌!
	public MyWrapper(HttpServletRequest request) {
		super(request);
	}
	
	@Override
	public String getParameter(String name) {
		String basicVal=super.getParameter(name);//기본파라미터정보를 가져옴
		return basicVal+" -bs-";
	}
	
	
	
}

