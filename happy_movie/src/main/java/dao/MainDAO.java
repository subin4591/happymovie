package dao;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.VideoDTO;
import dto.MovieDTO;
import dto.BookmarkDTO;

@Repository
public class MainDAO {
	@Autowired
	SqlSession session;
	
	public List<VideoDTO> videoList(){
		return session.selectList("videoList");
	}
	public int videoCnt() {
		return session.selectOne("videoCnt");
	}
	
	public List<MovieDTO> ranking5List(){
		return session.selectList("ranking5List");
	}
	
	public List<MovieDTO> bookmarkList(String user_id){
		return session.selectList("bookmarkList", user_id);
	}
	
	public int bookmarkCnt(String user_id) {
		return session.selectOne("bookmarkCnt", user_id);
	}
	
	public void bookmarkInsert(BookmarkDTO bto) {
		session.selectOne("bookmarkInsert", bto);
	}
	
	public void bookmarkDelete(BookmarkDTO dto) {
		session.selectOne("bookmarkDelete", dto);
	}

}
