package admin.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import admin.vo.EBTextVO;
import admin.vo.EditorBoardVO;


public interface IAdminEboardDao {

	/**
	 * 에디터게시판 리스트 조회 메서드
	 * @param map
	 * @return 에디터게시판 리스트
	 */
	public List<EditorBoardVO> editorList(Map<String, Object> map) throws SQLException;

	public EditorBoardVO editorDetail(int ebId);
	
	
	/**
	 * 에디터게시판에 작성한 글을 DB에 저장하는 메서드
	 * @param ebTitle
	 * @return
	 */
	public int editorInsert(EditorBoardVO ev);
	
	/**
	 * 에디터게시판에 작성한 텍스트를 DB에 저장하는 메서드
	 * @param ebtContent
	 * @return
	 */
	public int ebtInsert(EBTextVO etv);

	/**
	 * 에디터 게시판 글 개수
	 * @return
	 * @throws SQLException
	 */
	public int ecountList() throws SQLException;
	
	/**
	 * 에디터 글 삭제
	 * @param ebId
	 * @return
	 */
	public int deleteEboard(int ebId);


	public List<EditorBoardVO> selectEditor(String ebYn);
	

}
