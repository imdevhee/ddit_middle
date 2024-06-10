package character.vo;

import lombok.Data;

@Data
public class CharacterVO {
	
	private long psId;
	private String psName;
	private String psKmid;
	private String psCode;
	
	private int psinfoId;
	private String psinfoKey;
	private int  psiId;
	private String actorRole;
	private String psiSrc;
	private String psinfoVal;
	private int mvId;
}
