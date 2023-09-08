package main;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MainDAO;
import dto.BookmarkDTO;
import dto.MovieDTO;
import dto.VideoDTO;

@Service
public class MainService {
	@Autowired
	MainDAO dao;
	
	public List<VideoDTO> videoList(){
		return dao.videoList();
	}
	public int videoCnt() {
		return dao.videoCnt();
	}
	
	public List<MovieDTO> ranking5List(){
		return dao.ranking5List();
	}
	
	public List<MovieDTO> bookmarkList(String user_id){
		return dao.bookmarkList(user_id);
	}
	
	public int bookmarkCnt(String user_id) {
		return dao.bookmarkCnt(user_id);
	}
	
	public void bookmarkInsert(BookmarkDTO dto) {
		dao.bookmarkInsert(dto);
	}
	
	public void bookmarkDelete(BookmarkDTO dto) {
		dao.bookmarkDelete(dto);
	}
}
