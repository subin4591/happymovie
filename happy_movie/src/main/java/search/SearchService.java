package search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.SearchDAO;
import dto.MovieDTO;

@Service
public class SearchService {
	@Autowired
	SearchDAO dao;
	
	public List<MovieDTO> searchMovie(String search){
		return dao.searchMovie(search);
	}
	public int searchCnt(String search) {
		return dao.searchCnt(search);
	}
}
