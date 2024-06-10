package movie.vo;

import java.time.LocalDate;

import lombok.Data;

@Data
public class MvCommentVO {
	private int mvcId; //코멘트PK
	
	private String memId; //작성자아이디
	
	private int mvId; //영화
	
	private String mvcContent; //50자까지만
	
	private LocalDate mvcDate; //영화시청일
	
	private String mvcSpoyn; //스포일러여부
	
	private LocalDate mvcRegdt; //코멘트등록일
	
	private String mvcDelyn; //코멘트삭제여부
	
	////
	
	
	private String memNcnm; //작성자닉네임
	
	private int mvcLikeCnt; //코멘트좋아요수
	
	private int mvcReplyCnt; //코멘트리플수
	
	private int memMvgRating; //작성자평점 *10
	
	private String mempPath; //작성자프로필사진경로
	
	private String FullContent; //내용 전부
	
	private String memIntro; //작성자 소개글

	public MvCommentVO(String memId, String mvcContent) {
		super();
		this.memId = memId;
		this.mvcContent = mvcContent;
	}
	
	public MvCommentVO() {
		// TODO Auto-generated constructor stub
	}
	

}
