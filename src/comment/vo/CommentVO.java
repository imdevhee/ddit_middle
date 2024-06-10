package comment.vo;

import java.time.LocalDate;

import lombok.Data;

@Data
public class CommentVO {

	private int mvcId;
	private String memId;
	private int mvId;
	private String mvcContent;
	private LocalDate mvcDate;
	private String mvcSpoyn;
	private LocalDate mvcRegdt;
	private String mvcDelyn;
	
	
}
