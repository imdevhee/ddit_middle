package admin.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import admin.vo.MvcReportVO;
import config.MyBatisUtil;
import member.vo.MemberVO;
import util.MyBatisDao;




public class AdminMboardDaoImpl extends MyBatisDao implements IAdminMboardDao{
	
	private static IAdminMboardDao adminMboardDao;
	
	private AdminMboardDaoImpl() {
		
	}
	
	public static IAdminMboardDao getInstance() {
		if(adminMboardDao == null) {
			adminMboardDao = new AdminMboardDaoImpl();
		}
		
		return adminMboardDao;
	}
	
	

	@Override
	public List<MemberVO> blackList(Map<String, Object> map) throws SQLException {
	
		return selectList("adminMember.blackList", map);
	}

	@Override
	public int countList() throws SQLException {
		return selectOne("adminMember.countList");
	}

	@Override
	public List<MemberVO> selectAll(Map<String, Object> map) throws SQLException {
		return selectList("adminMember.selectAll", map);
	}

	@Override
	public MemberVO selectMember(String memId) {
		
		SqlSession sqlSession = MyBatisUtil.getInstance();
		
		MemberVO mv = null;
		
		try {
			mv = sqlSession.selectOne("adminMember.selectMember");
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return mv;
	}

	@Override
	public int blackUpdate(MemberVO mv) {

		SqlSession sqlSession = MyBatisUtil.getInstance(true);
		
		int cnt = 0;
		
		try {
			cnt = sqlSession.update("adminMember.blackUpdate", mv);
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return cnt;
	}

	@Override
	public int listUpdate(MemberVO mv) {
		SqlSession sqlSession = MyBatisUtil.getInstance(true);
		
		int cnt = 0;
		
		try {
			cnt = sqlSession.update("adminMember.listUpdate", mv);
		} catch (PersistenceException e) {
			e.printStackTrace();
		} finally {
			sqlSession.close();
		}
	
		return cnt;
	}

	@Override
	public int bcountList() throws SQLException {
		return selectOne("adminMember.bcountList");
	}

	@Override
	public List<MemberVO> selectAll() {
		return selectList("adminMember.selectAllList");
	}





}
