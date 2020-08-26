package com.editube.util;

public class Paging {
	private int maxNum;//전체 글 개수
	private int pageNum;//현재 페이지 번호
	private int listCount;//페이지 당 글 개수
	private int pageCount;//페이지 번호 개수
	private String listName;//목록 페이지 종류
	
	
	//생성자(페이징 객체를 만들 때 필요 값 입력처리)
	public Paging(int maxNum, int pageNum, 
			int listCount, int pageCount, 
			String listName) {
		this.maxNum = maxNum;
		this.pageNum = pageNum;
		this.listCount = listCount;
		this.pageCount = pageCount;
		this.listName = listName;
	}
	
	public String makePaging() {
		//페이징 처리를 위한 산술 연산
		//전체 페이지 개수 구하기
		//9개 이하일 때 totalPage = 1
		//11개 이상일 때 totalPage = 2
		int totalPage = (maxNum % listCount > 0) ?
				maxNum/listCount + 1 :
				maxNum/listCount;
		//현재 페이지가 속해 있는 그룹 번호
		int currentGroup = (pageNum % pageCount > 0) ?
				pageNum/pageCount + 1 :
				pageNum/pageCount;
		
		//현재 그룹의 시작 페이지 번호
		int start = (currentGroup * pageCount) 
				- (pageCount - 1);
		//현재 그룹의 끝 페이지 번호
		int end = (currentGroup * pageCount >= totalPage)
				? totalPage : currentGroup * pageCount;
		
		//html 코드를 문자열로 작성.
		StringBuffer sb = new StringBuffer();
		
		//이전 버튼 처리(start 번호가 1이 아닐때 생성)
		if(start != 1) {
			sb.append("<a class='pno' href='" + listName
					+ "&pageNum=" + (start - 1) + "'>"
					);
			sb.append("&nbsp;이전&nbsp;");
			sb.append("</a>");
		}
		//<a class='pno' href='list?pageNum=8'> 이전 </a>
		
		//페이지 번호 처리(페이지 그룹으로 처리)
		for(int i = start; i <= end; i++) {
			if(pageNum != i) {
				//현재 페이지가 아닌 페이지 번호
				sb.append("<a class='pno' href='" +
						listName + "&pageNum=" + i + "'>");
				sb.append("&nbsp;" + i + "&nbsp;</a>");
			}
			else {
				//현재 페이지인 번호
				sb.append("<font class='pno' style='color:red;'>");
				sb.append("&nbsp;" + i + "&nbsp;</font>");
			}
			//<a class='pno' href='list?pageNum=6'> 6 </a>
			//<font class='pno' style='color:red;'> 7 </font>
			//<a class='pno' href='list?pageNum=8'> 8 </a>
			//<a class='pno' href='list?pageNum=9'> 9 </a>
		}
		
		//다음 버튼 처리
		if(end != totalPage) {
			sb.append("<a class='pno' href='" + listName
					+ "&pageNum=" + (end + 1) + "'>"
					);
			sb.append("&nbsp;다음&nbsp;");
			sb.append("</a>");
		}//<a class='pno' href='list?pageNum=10'> 다음 </a>
		
		return sb.toString();
	}
}





