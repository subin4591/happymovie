package rank;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import dao.ApiDAO;
import dto.ApiDTO;
import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import kr.or.kobis.kobisopenapi.consumer.rest.exception.OpenAPIFault;

@Service
public class ApiService {
	@Autowired
	ApiDAO dao = new ApiDAO();

	public int insertApi(ApiDTO dto) throws OpenAPIFault, Exception {
		return dao.insertApi(dto);
}	
	public int getTotalGenre(String genre) {
		return dao.getTotalGenre(genre);
	}
	public ApiDTO selectMovie(int movieCd) {
		return dao.selectMovie(movieCd);
	}
	public List<ApiDTO> actionList(int[] limit) {
		 return dao.actionList(limit);
	}
	public List<ApiDTO> comedyList(int[] limit) {
		 return dao.comedyList(limit);
	}
	public List<ApiDTO> thrillerList(int[] limit) {
		 return dao.thrillerList(limit);
	}
	public List<ApiDTO> romanceList(int[] limit) {
		 return dao.romanceList(limit);
	}
	public List<ApiDTO> fantasyList(int[] limit) {
		 return dao.fantasyList(limit);
	}
	public List<ApiDTO> selectGrade(){ 
		return dao.selectGrade();
	}
}
