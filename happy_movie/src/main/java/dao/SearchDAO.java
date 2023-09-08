package dao;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.MovieDTO;

@Repository
public class SearchDAO {
	@Autowired
	SqlSession session;
	
	public List<MovieDTO> searchMovie(String search){
		return session.selectList("searchMovie", search);
	}
	
	public int searchCnt(String search) {
		return session.selectOne("searchCnt", search);
	}

}
