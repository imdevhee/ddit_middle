package board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.service.AdminEboardServiceImpl;
import admin.service.IAdminEboardService;
import admin.vo.EditorBoardVO;
@WebServlet("/ebList.do")
public class EbController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String ebYn="Y";
		
		IAdminEboardService eboardService = AdminEboardServiceImpl.getInstance();
	
		
		List<EditorBoardVO> selectEditor = eboardService.selectEditor(ebYn);
		
		System.out.println(">>>>>>>>>>>>>>>"+selectEditor);
		
		
		
		req.setAttribute("selectEditor", selectEditor);
		
		req.getRequestDispatcher("/index.jsp").forward(req, resp);
	}

}
