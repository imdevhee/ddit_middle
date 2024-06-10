package admin.vo;

import lombok.Data;

@Data
public class MvcReportVO {
	private int mvcrpId; //코멘트신고PK
	private String memId; //사용자PK
	private int mvcId; //영화코멘트PK
	private String mvcrpContent; //코멘트신고 내용
	private String mvcrpYn; //코멘트신고 여부
	
	private String mvcContent; //코멘트 작성 내용
	private String mvcMemEmail; //코멘트 작성자 이메일
	private String rpMemEmail; //신고글 작성자 이메일

	
}
