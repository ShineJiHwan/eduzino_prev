package com.edu.zino.domain;

import lombok.Data;

@Data
public class Video {//강사가 관리자에게 요청후 승인된 영상들 
	private int video_idx;
	private String video_link;//vimeo에서의 link 주소
	private String video_name;//사용자가 등록한 영상 이름
	private String video_access;//강사에게 보여줄지 안보여줄지 | 0:비공개(삭제등의 사유로), 1:공개
	private Teacher teacher;//소유자
}
