package dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.ApiDTO;

@Repository
public class ApiDAO {
	@Autowired
	SqlSession session;
	
	public int insertApi(ApiDTO dto) {
		return session.insert("insertApi", dto);
	}
	public ApiDTO selectMovie(int movieCd) {
		return session.selectOne("selectMovie", movieCd);
	}
	public int getTotalGenre(String genre) {
		return session.selectOne("getTotalGenre",genre);
	}
	public List<ApiDTO> actionList(int[] limit){ 
		return session.selectList("actionList", limit);
	}
	public List<ApiDTO> comedyList(int[] limit){ 
		return session.selectList("comedyList", limit);
	}
	public List<ApiDTO> thrillerList(int[] limit){ 
		return session.selectList("thrillerList", limit);
	}
	public List<ApiDTO> romanceList(int[] limit){ 
		return session.selectList("romanceList", limit);
	}
	public List<ApiDTO> fantasyList(int[] limit){ 
		return session.selectList("fantasyList", limit);
	}
	public List<ApiDTO> selectGrade(){ 
		return session.selectList("selectGrade");
	}
}
