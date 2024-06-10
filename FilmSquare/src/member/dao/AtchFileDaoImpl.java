package member.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.Part;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import config.MyBatisUtil;
import member.vo.AtchFileVO;
import member.vo.MemberVO;
import util.MyBatisDao;



public class AtchFileDaoImpl extends MyBatisDao implements IAtchFileDao{

	private static IAtchFileDao fileDao;
	
	private AtchFileDaoImpl() {

	}
	
	public static IAtchFileDao getInstance() {
		if(fileDao == null) {
			fileDao = new AtchFileDaoImpl();
		}
		
		return fileDao;
	}
	
	

	@Override
	public int insertAtchFileDetail(AtchFileVO atchFileVO) {
		SqlSession session= MyBatisUtil.getInstance();
		
		int cnt = 0;
		
		
		try {
			
			cnt=session.insert("atchFile.insertAtchFileDetail",atchFileVO);
			
			if(cnt>0) {
				session.commit();
			}
			
		} catch (PersistenceException ex) {
			ex.printStackTrace();
		}finally {
			session.close();
		}
		
		
		return cnt;
		
	}

	@Override
	public List<AtchFileVO> getAtchFileList(AtchFileVO atchFileVO) {

		List<AtchFileVO> atchFileList = new ArrayList<AtchFileVO>();
		
		SqlSession session = MyBatisUtil.getInstance(true);
		
		try {
			atchFileList = session.selectList("atchFile.getAtchFileList", atchFileVO);
			
			
			
		} catch (PersistenceException ex) {
			ex.printStackTrace();
		}finally {
			session.close();
		}
		
		return atchFileList;
	}

	@Override
	public AtchFileVO getAtchFileDetail(AtchFileVO atchFileVO) {

		AtchFileVO atchFileDetail = null;
		
		SqlSession session = MyBatisUtil.getInstance(true);
		
		try {//파일 아이디랑 파일순번
			atchFileDetail = session.selectOne(
					"atchFile.getAtchFileDetail", atchFileVO);
			
			
			
		} catch (PersistenceException ex) {
			ex.printStackTrace();
		}finally {
			session.close();
		}
		
		return atchFileDetail;
	}

	public static void main(String[] args) {
		
		IAtchFileDao fileDao = AtchFileDaoImpl.getInstance();
		
		AtchFileVO atchFileVO = new AtchFileVO();
		int cnt = fileDao.updateAtchFile(atchFileVO);
		
		if(cnt>0) {
			System.out.println("등록 성공");
			System.out.println(atchFileVO.getMempId());
		
			//////////////////////////////
			atchFileVO.setMempStreNm("aaaabbbbb.jpg");
			atchFileVO.setMempSize(10);
			atchFileVO.setMempOrgnNm("ccc.jpg");
			atchFileVO.setMempExtsn("jpg");
			
		
			cnt = fileDao.insertAtchFileDetail(atchFileVO);
			

			
			if(cnt > 0) {
				System.out.println("detail등록 성공!");
			}
		}
	}
	@Override
	public AtchFileVO getMember(String memId) {
	    List<AtchFileVO> resultList = selectList("member.getMember", memId);
	    if (resultList != null && resultList.size() > 0) {
	        // 여러 개의 결과 중 첫 번째 결과를 반환하거나, 필요에 따라 적절한 처리를 수행하세요.
	        return resultList.get(0);
	    } else {
	        return null; // 결과가 없는 경우
	    }
	}

	@Override
	public int insertFile(AtchFileVO av) {
		SqlSession sqlSession = MyBatisUtil.getInstance();
		
		int cnt = 0;
		
		try {
			cnt = sqlSession.insert("member.insertFile", av);
			if(cnt > 0) {
				sqlSession.commit();
			}
			
		} catch (PersistenceException ex) {
			sqlSession.rollback();
			ex.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		
		return cnt;
	}

	@Override
	public int updateAtchFile(AtchFileVO fileVO) {
		
		 return update("member.updateAtch",fileVO);
	}

	@Override
	public int saveFile(Collection<Part> parts) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public AtchFileVO getMember(MemberVO memId) {
		 List<AtchFileVO> resultList = selectList("member.getMember", memId);
		    if (resultList != null && resultList.size() > 0) {
		        // 여러 개의 결과 중 첫 번째 결과를 반환하거나, 필요에 따라 적절한 처리를 수행하세요.
		        return resultList.get(0);
		    } else {
		        return null; // 결과가 없는 경우
		    }
		}

	@Override
	public int exist(String memId) {
		return selectOne("member.exist",memId);
	}

	@Override
	public AtchFileVO getAFile(String memId) {
		return selectOne("member.getAFile",memId);
	}



	
		

	
}
