package com.vino.common.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.vino.scaffold.entity.Pager;


public class PagerTag extends SimpleTagSupport{
	private Integer curPageNo;
	private String type;
	private String action;

	@Override
	public void doTag() throws JspException, IOException {
		Pager pager=(Pager) getJspContext().findAttribute("pager");
		System.out.println(pager);
		if("form".equals(type)){
			
		}else if("href".equals(type)){
			JspWriter out=getJspContext().getOut();
			out.println("<nav><ul class='pagination'>");
			
			out.println("<li><a href='#' aria-label='Previous'> <span aria-hidden='true'>&laquo;</span></a></li>");
			
			out.println("<li><a href='"+action+"?curPageNo=1"+"&pageSize="+pager.getPageSize()+"&totalRecord="+pager.getTotalRecord()+"'>首页</a></li>");
			if(pager.getCurPageNo()-1>=1)
			out.println("<li><a href='"+action+"?curPageNo="+(pager.getCurPageNo()-1)+"&pageSize="+pager.getPageSize()+"&totalRecord="+pager.getTotalRecord()+"'>上一页</a></li>");
			else
				out.println("<li><a href='#'>上一页</a></li>");
				
			if(pager.getCurPageNo()+1<=pager.getTotalPage())
			out.println("<li><a href='"+action+"?curPageNo="+(pager.getCurPageNo()+1)+"&pageSize="+pager.getPageSize()+"&totalRecord="+pager.getTotalRecord()+"'>下一页</a></li>");
			else
			out.println("<li><a href='#'>下一页</a></li>");
			
			out.println("<li><a href='"+action+"?curPageNo="+pager.getTotalPage()+"&pageSize="+pager.getPageSize()+"&totalRecord="+pager.getTotalRecord()+"'>首页</a></li>");
			out.println("<li> <a href='#' aria-label='Next'<span aria-hidden='true'>&raquo;</span></a> </li>");
			out.println("</ul></nav>");
		}
	}

	
	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getAction() {
		return action;
	}


	public void setAction(String action) {
		this.action = action;
	}


	public Integer getCurPageNo() {
		return curPageNo;
	}

	public void setCurPageNo(Integer curPageNo) {
		this.curPageNo = curPageNo;
	}
	

}
