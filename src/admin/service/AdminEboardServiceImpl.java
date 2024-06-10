package admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import admin.dao.IAdminEboardDao;
import admin.vo.EBTextVO;
import admin.vo.EditorBoardVO;
import admin.dao.AdminEboardDaoImpl;




public class AdminEboardServiceImpl implements IAdminEboardService{

	private static IAdminEboardService adminEboardService;
	private IAdminEboardDao adminEboardDao;
	
	private AdminEboardServiceImpl() {
		adminEboardDao = AdminEboardDaoImpl.getInstance();
		
	}
	public static IAdminEboardService getInstance() {
		
		if(adminEboardService == null) {
			adminEboardService = new AdminEboardServiceImpl();
		}
		return adminEboardService;
	}
	
	@Override
	public List<EditorBoardVO> editorList(Map<String, Object> map) {
		List<EditorBoardVO> list = null;
		try {
			list = adminEboardDao.editorList(map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public EditorBoardVO EdiDetail(int ebId) {
		return adminEboardDao.editorDetail(ebId);
	}
	@Override
	public int editorInsert(EditorBoardVO ev) {

		return adminEboardDao.editorInsert(ev);
		
	}
	@Override
	public int ebtInsert(EBTextVO etv) {
		
		return adminEboardDao.ebtInsert(etv);
		
	}
	@Override
	public int ecountList() {
		int countList = 0;
		try {
			countList = adminEboardDao. ecountList();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return countList;
	}
	@Override
	public int deleteEboard(int ebId) {
		return adminEboardDao.deleteEboard(ebId);
	}
	@Override
	public List<EditorBoardVO> selectEditor(String ebYn)  {
		List<EditorBoardVO> list = null;
		try {
			
			list = adminEboardDao.selectEditor(ebYn);
			System.out.println(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}




}
