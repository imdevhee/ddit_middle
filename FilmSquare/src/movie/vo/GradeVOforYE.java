package movie.vo;

import java.math.BigDecimal;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class GradeVOforYE {
	
	private BigDecimal mvgId;
	private BigDecimal mvId;
	private String memId;
	private BigDecimal mvgRating;
	private Timestamp mvgDate;
	
	public GradeVOforYE(BigDecimal mvgId, BigDecimal mvId, String memId, BigDecimal mvgRating, Timestamp mvgDate) {
		super();
		this.mvgId = mvgId;
		this.mvId = mvId;
		this.memId = memId;
		this.mvgRating = mvgRating;
		this.mvgDate = mvgDate;
	}

	public GradeVOforYE(BigDecimal mvId, String memId, Timestamp mvgDate) {
		super();
		this.mvId = mvId;
		this.memId = memId;
		this.mvgDate = mvgDate;
	}

	public GradeVOforYE(BigDecimal mvId, Timestamp mvgDate) {
		super();
		this.mvId = mvId;
		this.mvgDate = mvgDate;
	}


	
	
	

	
}
