package member.vo;

import lombok.Data;

@Data
public class MemberVO {
	
	public MemberVO() {}
	
	public MemberVO(String memId , String memName, String memPw, String memNcnm, String memEmail, String memTelno, String memInum) {
    }
	
	private String memId; //�궗�슜�옄PK
	private String memPw; //�궗�슜�옄 鍮꾨�踰덊샇
	private String memFrom; //�궗�슜�옄 媛��엯猷⑦듃
	private String memName; //�궗�슜�옄 �씠由�
	private String memNcnm; //�궗�슜�옄 �땳�꽕�엫
	private String memEmail; //�궗�슜�옄 硫붿씪
	private String memTelno; //�궗�슜�옄 �쟾�솕踰덊샇
	private String memInum; //�궗�슜�옄 二쇰�쇰쾲�샇
	private String memIntro; //�궗�슜�옄 �냼媛쒓�
	private int memTtime; //�궗�슜�옄 �쁺�솕�떆泥��떆媛�
	private String memStopyn; //�궗�슜�옄 �젙吏��뿬遺�
	private String memDelyn; //�궗�슜�옄 �깉�눜�뿬遺�
	private String memBirth; //�깮�뀈�썡�씪
	private String memMW; //�궓�뿬
	private int reportCount; //�떊怨좉굔�닔
	private String mvcrpContent; //�떊怨좊궡�슜
	
	
	public MemberVO(String memId) {
		super();
		this.memId = memId;
	}
	
}
