package admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.service.AdminEboardServiceImpl;
import admin.service.AdminQboardServiceImpl;
import admin.service.IAdminEboardService;
import admin.service.IAdminQboardService;
import admin.vo.EBTextVO;
import admin.vo.EditorBoardVO;
import admin.vo.QnaVO;

@WebServlet("/admin/editorDetail.do")
public class EditorDetailController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


		int ebId = Integer.parseInt(req.getParameter("ebId"));
		
		IAdminEboardService adminEdiService = AdminEboardServiceImpl.getInstance();
		
		EditorBoardVO ev = adminEdiService.EdiDetail(ebId);
		
		System.out.println("EditorDetailController에서 보내는 ev => " + ev);
		
		req.setAttribute("ev", ev);
		
		
		req.getRequestDispatcher("/views/admin/eboard/editorDetail.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
}
