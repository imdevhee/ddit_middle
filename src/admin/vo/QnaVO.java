package admin.vo;

import java.time.LocalDate;

import lombok.Data;

@Data
public class QnaVO {
	private int qaId;
	private String memId;
	private String qaTitle;
	private String qaContent;
	private LocalDate qaDate;
	private String qaEmail;
	
//	QnaReplyVO
	private int qareId;
	private String qareContent;
	private LocalDate qareDate;
	
	
	
}
