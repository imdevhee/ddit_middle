package movie.vo;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class PosterVO {
	private BigDecimal posterId;
	private String posterImg;
	private BigDecimal mvId;
	public PosterVO(BigDecimal posterId, String posterImg, BigDecimal mvId) {
		super();
		this.posterId = posterId;
		this.posterImg = posterImg;
		this.mvId = mvId;
	}
	public PosterVO( BigDecimal mvId,String posterImg) {
		super();
		this.posterImg = posterImg;
		this.mvId = mvId;
	}
	
	
	
}
