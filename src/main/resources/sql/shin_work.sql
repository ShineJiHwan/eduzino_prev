insert into TOP_CATEGORY(top_category_idx,top_name) values(seq_top_category.nextval,'IT');
insert into TOP_CATEGORY(top_category_idx,top_name) values(seq_top_category.nextval,'디자인');
insert into TOP_CATEGORY(top_category_idx,top_name) values(seq_top_category.nextval,'마케팅');
insert into TOP_CATEGORY(top_category_idx,top_name) values(seq_top_category.nextval,'외국어');
insert into TOP_CATEGORY(top_category_idx,top_name) values(seq_top_category.nextval,'기타');

select * from top_category;

insert into MID_CATEGORY(mid_category_idx,mid_name,top_category_idx) values(seq_mid_category.nextval,'프론트엔드',1);
insert into MID_CATEGORY(mid_category_idx,mid_name,top_category_idx) values(seq_mid_category.nextval,'백엔드',1);

insert into MID_CATEGORY(mid_category_idx,mid_name,top_category_idx) values(seq_mid_category.nextval,'CADㆍ3D모델링',2);
insert into MID_CATEGORY(mid_category_idx,mid_name,top_category_idx) values(seq_mid_category.nextval,'사진ㆍ영상',2);

insert into MID_CATEGORY(mid_category_idx,mid_name,top_category_idx) values(seq_mid_category.nextval,'기획ㆍ전략',3);
insert into MID_CATEGORY(mid_category_idx,mid_name,top_category_idx) values(seq_mid_category.nextval,'경영',3);

insert into MID_CATEGORY(mid_category_idx,mid_name,top_category_idx) values(seq_mid_category.nextval,'영어',4);
insert into MID_CATEGORY(mid_category_idx,mid_name,top_category_idx) values(seq_mid_category.nextval,'중국어',4);

insert into MID_CATEGORY(mid_category_idx,mid_name,top_category_idx) values(seq_mid_category.nextval,'자기개발',5);
insert into MID_CATEGORY(mid_category_idx,mid_name,top_category_idx) values(seq_mid_category.nextval,'예술',5);

select * from mid_category

insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'HTML/CSS',1);
insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'JavaScript',1);

insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'JAVA',2);
insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'C',2);

insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'AutoCAD',3);
insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'SketchUp',3);

insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'모션그래픽',4);
insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'영상제작',4);

insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'서비스 기획',5);
insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'PT',5);

insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'회계',6);
insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'재테크',6);

insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'토익',7);
insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'OPIc',7);

insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'HSK',8);
insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'회화',8);

insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'교양',9);
insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'출간출판',9);

insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'뜨개질',10);
insert into SUB_CATEGORY(sub_category_idx,sub_name,mid_category_idx) values(seq_sub_category.nextval,'캘리그라피',10);

select * from sub_category


create table video(
	video_idx number primary key
	, video_link varchar2(30) not null
	, video_name varchar2(200) not null
	, video_access number default 1 --공개여부 0비공개, 1공개
	, teacher_idx number
);

drop table Movie

create table movie(
	movie_idx number primary key
	, movie_name varchar2(100)
	, section_idx number
	, video_idx number
);

create sequence seq_video
increment by 1
start with 1

-----------삭제할 가라 데이터------------------
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용3',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용4',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용5',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용6',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용7',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용8',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용9',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용10',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용11',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용12',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용13',1);
insert into video(video_idx,video_link,video_name,teacher_idx) values(seq_video.nextval,'/807359667','테스트용14',1);

select * from video

-----------삭제할 가라 데이터 end------------------



