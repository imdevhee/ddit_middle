package member.vo;

import java.time.LocalDate;

import lombok.Data;
@Data
public class AtchFileVO {
	private int mempId = -1;
	private String memId;
	private long mempSn;
	private String mempPath;
	private String mempStreNm;
	private String mempOrgnNm;
	private String mempExtsn;
	private long mempSize =0;


	

}