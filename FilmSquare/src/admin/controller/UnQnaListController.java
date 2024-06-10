package admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.service.AdminMboardServiceImpl;
import admin.service.AdminQboardServiceImpl;
import admin.service.IAdminMboardService;
import admin.service.IAdminQboardService;
import admin.vo.QnaVO;

@WebServlet("/admin/qboard/unList.do")
public class UnQnaListController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//게시판 정보 조회 및 해당 게시글에 대한 페이징 정보 생성하기

		int currentPage  = 1; //현재 페이지
		currentPage = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
		
		//전체 글 갯수 얻기 위한 서비스객체 필요
	 	IAdminQboardService adminQboardService = AdminQboardServiceImpl.getInstance();
		int totalCount = adminQboardService.uncountList(); //전체 글갯수
		
		//화면에 표시될 페이지의 수
		int perPage = 5;
		
		//한 페이지 당 출력할 글 갯수
		int perList = 7;
		
		//전체 페이지 수 = 전체글갯수(totalCount) / 페이지 당 글 갯수(perList)
		int totalPage = (int)Math.ceil((double)totalCount / (double)perList);
		
		//페이지 당 출력할 게시글 범위(start ~ end)값 구하기
		//start = (currentPage -1) * perList +1;
		// 1페이지 일때 : (1-1)*5+1 = 1
		// 2페이지 일때 : (2-1)*5+1 = 6
		// 3페이지 일때 : (3-1)*5+1 = 11
		// 4페이지 일때 : (4-1)*5+1 = 16
		// 5페이지 일때 : (5-1)*5+1 = 21
		int start = (currentPage -1) * perList +1;
		
		//end = start + perList -1;
		// 1페이지 일때 : 1 + 5 - 1 = 5
		// 2페이지 일때 : 6 + 5 - 1 = 10
		// 3페이지 일때 : 11 + 5 - 1 = 15
		// 4페이지 일때 : 16 + 5 - 1 = 20
		// 5페이지 일때 : 21 + 5 - 1 = 25
		int end = start + perList -1;
		if(end > totalCount) end = totalCount; //전체 글갯수를 초과하는 end범위 값 조절
		
		//화면에 표시될 페이지 범위 구하기(startPage ~ endPage)
		//startPage = ((currentPage -1) / perPage * perPage)+1;
		int startPage = ((currentPage -1) / perPage * perPage)+1;
		
//		for(int i=1; i<10; i++){
//			startPage = ((i -1) / perPage * perPage)+1;
//			System.out.println(i+"페이지 일때 시작페이지 범위>>" + startPage);
//		}
		//endPage = startPage + perPage -1;
		int endPage = startPage + perPage -1;
		if(endPage > totalPage) endPage = totalPage;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
	 	map.put("end", end);
	 	
	 	List<QnaVO> unQnaList = adminQboardService.unQnaList(map);
	 	
	 	req.setAttribute("unQnaList", unQnaList);
	 	req.setAttribute("sPage", startPage);
		req.setAttribute("ePage", endPage);
		req.setAttribute("cPage", currentPage);	
		req.setAttribute("ttPage", totalPage);
		
		req.getRequestDispatcher("/views/admin/qboard/unQnaList.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
