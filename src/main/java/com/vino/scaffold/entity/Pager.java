package com.vino.scaffold.entity;


public class Pager{
	private Integer totalRecord;//总记录条数
	private Integer curPageNo;//当前页数
	private Integer pageSize=Constants.PAGE_SIZE; //每页记录数
/*	private List<T> curBeanList;//当前页的记录
*/	//获得偏移的记录起始位置，对应limit里的begin
	public Integer getRecordOffsetStart(){
		if(curPageNo>0)
			return (curPageNo-1)*pageSize;
		return 0;
	}
	//对应limit里的end
	public Integer getRecordOffsetEnd(){
		return curPageNo*pageSize;
	}
	//返回总共的页数
	public Integer getTotalPage(){
		return totalRecord%pageSize>0?(totalRecord/pageSize+1):(totalRecord/pageSize);
	}
	public Integer getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(Integer totalRecord) {
		this.totalRecord = totalRecord;
	}
	public Integer getCurPageNo() {
		return curPageNo;
	}
	public void setCurPageNo(Integer curPageNo) {
		this.curPageNo = curPageNo;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	/*public List<T> getCurBeanList() {
		return curBeanList;
	}
	public void setCurBeanList(List<T> curBeanList) {
		this.curBeanList = curBeanList;
	}
	*/
	

}