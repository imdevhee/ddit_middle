package admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import admin.vo.EBTextVO;
import admin.vo.EditorBoardVO;
import admin.vo.MvcReportVO;
import member.vo.MemberVO;



public interface IAdminEboardService {

	/**
	 * 에디터게시판 리스트 조회 메서드
	 * @param map
	 * @return 에디터게시판 리스트
	 */
	public List<EditorBoardVO> editorList(Map<String, Object> map);

	public EditorBoardVO EdiDetail(int ebId);

	/**
	 * 에디터게시판에 작성한 데이터를 DB에 저장하는 메서드
	 * @param ebTitle
	 * @return''
	 */
	public int editorInsert(EditorBoardVO ev);

	
	/**
	 * 에디터게시판에 작성한 텍스트를 DB에 저장하는 메서드
	 * @param ebtContent
	 * @return''
	 */
	public int ebtInsert(EBTextVO etv);

	/**
	 * 에디터 게시판 글 개수
	 * @return
	 */
	public int ecountList();

	/**
	 * 에디터 글 삭제
	 * @param ebId
	 * @return
	 */
	public int deleteEboard(int ebId);

	public List<EditorBoardVO> selectEditor(String ebYn) ;
	



}
