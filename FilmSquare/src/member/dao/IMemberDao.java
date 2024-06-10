package member.dao;

import java.util.List;

import member.vo.AtchFileVO;
import member.vo.MemberVO;

public interface IMemberDao {

	/**
	 * DB에 존재하는 모든회원 정보를 조회하기 위한 메서드
	 * @return 전체 회원 리스트
	 */
	public List<MemberVO> getMemberList();


	/**
	 * 회원가입을 위한 데이터 삽입 메서드
	 * @param mv
	 * @return
	 */
	public int insertMember(MemberVO mv);
	
	
	/**
	 * DB에 저장된 정보와 입력한 아이디가 일치하는지 확인하기 위한 메서드
	 * @param mv
	 * @return
	 */
	public MemberVO loginChk(MemberVO mv);
	
	/**
	 * ID로 회원정보를 조회하기 위한 메서드
	 * @param 로그인 시 세션에 저장된 memId 
	 * @return
	 */
	public MemberVO searchMember(MemberVO memId);

	public int kakaoInsert(MemberVO mv);
	
	public boolean emailChk(String memEmail);


	public int updateIntro(MemberVO mvInt);
	public int updateNic(MemberVO mvNic);


	public MemberVO schMember(String memId);


	public MemberVO searchInfo(String memEmail);


	public int search(String memEmail);


	public MemberVO getAMember(MemberVO memberVO);


	public int getWatchedMovieNum(String memId);


	public int getMemberRank(MemberVO mem);


	public int getGradeCount(MemberVO mem);


	public int getCommentCount(MemberVO mem);


	public int getCollCout(MemberVO mem);


	
	
}
