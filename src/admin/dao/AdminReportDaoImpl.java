package admin.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import admin.vo.MvcReportVO;
import config.MyBatisUtil;
import util.MyBatisDao;




public class AdminReportDaoImpl extends MyBatisDao implements IAdminReportDao{
	
	private static IAdminReportDao adminReportDao;
	
	private AdminReportDaoImpl() {
		
	}
	
	public static IAdminReportDao getInstance() {
		if(adminReportDao == null) {
			adminReportDao = new AdminReportDaoImpl();
		}
		
		return adminReportDao;
	}
	
	@Override
	public List<MvcReportVO> reportList(Map<String, Object> map) throws SQLException {

		return selectList("adminReport.reportList", map);
	}
	
	@Override
	public List<MvcReportVO> memberReport(String memId) {
		
		List<MvcReportVO> mvcReportList = new ArrayList<MvcReportVO>();
		
		SqlSession sqlSession = MyBatisUtil.getInstance();
		
		try {
			mvcReportList = sqlSession.selectList("adminReport.memberReport", memId);
			
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return mvcReportList;
	}

	@Override
	public int complete(MvcReportVO mrv) {
		return update("adminReport.complete", mrv);
	}

	@Override
	public int mrcountList() throws SQLException {
		return selectOne("adminReport.mrcountList");
	}

}
