package movie.vo;

import java.time.LocalDate;

import lombok.Data;

@Data
public class MovieInfoVO {
	
	private int mvId;
	
	private String mvTitle;
	
	private String mvUrl;
	
	private String mvKmid;
	
	private String mvKmseq;
	
	private String mvCode;
	
	private int mvRtime;
	
	private LocalDate mvRdate;
	
	private String mvDirector;
	
	private String mvRyear;
	
	private String mvPlot;
	
	private String mvGenre;
	
	private String mvAgelimit;
	
	private String mvEngtitle;
	
	private String mvNation;
	
	private String mvBackground;
	
	private int posterId; // 포스터 id
	
	private String posterImg; // 포스터 이미지 링크
	
	private int gradeAvg; // = 일반 평점 *10
	
	private int psId;
	
	private String actorRole;
	
	private String psName;
	
	
}
