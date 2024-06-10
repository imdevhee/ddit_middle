package member.dao;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import config.MyBatisUtil;
import member.vo.AtchFileVO;
import member.vo.MemberVO;
import util.MyBatisDao;

public class MemberDaoImpl extends MyBatisDao implements IMemberDao {

	private static IMemberDao memDao;
	
	private MemberDaoImpl() {}
	
	public static IMemberDao getInstance() {
		
		if(memDao == null) {
			memDao = new MemberDaoImpl();
		}
		return memDao;
	}
	
	@Override
	public List<MemberVO> getMemberList() {
		
		return selectList("member.getMemberList");
	}

	@Override
	public int insertMember(MemberVO mv) {
		SqlSession sqlSession = MyBatisUtil.getInstance();
		
		int cnt = 0;
		
		try {
			cnt = sqlSession.insert("member.insertMember", mv);
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
	public MemberVO loginChk(MemberVO login) {
		
		SqlSession sqlSession = MyBatisUtil.getInstance(true);
		
		MemberVO mv = null;
		
		try {
			
			mv = sqlSession.selectOne("member.loginChk", login);
			
			System.out.println("다오에 있는 mv 값 =>" + mv);
			
		} catch (PersistenceException ex) {
			ex.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		
		return mv;

	}


	@Override
	public MemberVO searchMember(MemberVO memId) {
	    List<MemberVO> resultList = selectList("member.searchMember", memId);
	    if (resultList != null && resultList.size() > 0) {
	        // 여러 개의 결과 중 첫 번째 결과를 반환하거나, 필요에 따라 적절한 처리를 수행하세요.
	        return resultList.get(0);
	    } else {
	        return null; // 결과가 없는 경우
	    }
	}

	@Override
	public MemberVO schMember(String memId) {
		return selectOne("member.schMember", memId);
	}

	@Override
	public int kakaoInsert(MemberVO mv) {
		
		SqlSession sqlSession = MyBatisUtil.getInstance(true);
		
		int cnt = 0;
		
		try {
			cnt = sqlSession.insert("member.kakaoInsert", mv);
			if(cnt > 0) {
				sqlSession.commit();
			}
			
		} catch (PersistenceException ex) {
//			sqlSession.rollback();
			ex.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		
		return cnt;
	}

	@Override
	public int updateIntro(MemberVO mvInt) {
		SqlSession sqlSession = MyBatisUtil.getInstance();
		
		int cnt=0;
		
		try {
		    cnt = sqlSession.update("member.updateIntro", mvInt);
		    if (cnt > 0) {
		        sqlSession.commit();
		        System.out.println(cnt + "dao 소개글 " + mvInt);
		    }
		} catch (PersistenceException e) {
		    // 예외 처리 로직 추가 (예: 로깅, 사용자에게 메시지 전달 등)
		    e.printStackTrace();
		    // 추가적인 예외 처리 로직이 필요하면 여기에 추가
		} finally {
		    sqlSession.close();
		}

		
		
		return cnt;
	}
	@Override
	public int updateNic(MemberVO mvNic) {
		SqlSession sqlSession = MyBatisUtil.getInstance();
		
		int cnt=0;
		
		try {
			cnt= sqlSession.update("member.updateNic",mvNic);
			if(cnt>0) {
				sqlSession.commit();
				System.out.println(cnt+"dao 닉네임 "+mvNic);	
			}
		} catch (PersistenceException e) {
			
			e.printStackTrace();
		}finally {
			
			sqlSession.close();
		}
		
		
		return cnt;
	}
	@Override
	public boolean emailChk(String memEmail) {
		
		boolean isExist = false;
		
		SqlSession sqlSession = MyBatisUtil.getInstance();
		
		System.out.println("DAO(EMAIL) >> " + memEmail);
		
		
		try {
			MemberVO mv = sqlSession.selectOne("member.emailChk", memEmail);
			System.out.println(mv);
			if(mv != null) {
				sqlSession.commit();
				isExist = true;
			}
			
		} catch (PersistenceException ex) {
			ex.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return isExist;
	}

	@Override
	public MemberVO searchInfo(String memEmail) {
		
		return selectOne("member.searchInfo", memEmail);
			
	}

	@Override
	public int search(String memEmail) {
		// TODO Auto-generated method stub
		return selectOne("member.searchInfo", memEmail);
	}

	@Override
	public MemberVO getAMember(MemberVO memberVO) {
		return selectOne("member.getAMember", memberVO);
	}

	@Override
	public int getWatchedMovieNum(String memId) {
		return selectOne("member.getWatchedMovieNum", memId);
	}

	@Override
	public int getMemberRank(MemberVO mem) {
		return selectOne("member.getMemberRank", mem);
	}

	@Override
	public int getGradeCount(MemberVO mem) {
		return selectOne("member.getGradeCount", mem);
	}

	@Override
	public int getCommentCount(MemberVO mem) {
		return selectOne("member.getCommentCount", mem);
	}

	@Override
	public int getCollCout(MemberVO mem) {
		return selectOne("member.getCollCout", mem);
	}
		
		
		

	
}
