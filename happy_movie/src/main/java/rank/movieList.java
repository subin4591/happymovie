package rank;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import kr.or.kobis.kobisopenapi.consumer.rest.exception.OpenAPIFault;

public class movieList {
	
	public void moveList(HttpServletRequest request, String curPage,String itemPerPage,String movieNm,String directorNm,String openStartDt,String openEndDt,String prdtStartYear,String prdtEndYear,String repNationCd, String[] movieTypeCdArr) throws OpenAPIFault, Exception{
		// 발급키 3000회 제한
		String key = "b3a0415f8ef2c7923070066015819d92";
		/*String key = "bf2271f675c761c477ce7afc3b47bee1";*/
		/*String key = "478bf317e87507fd04843638f4a1ea4a";*/
		// KOBIS 오픈 API Rest Client를 통해 호출
	    KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
		
	 	// 영화코드조회 서비스 호출 (boolean isJson, String curPage, String itemPerPage,String directorNm, String movieCd, String movieNm, String openStartDt,String openEndDt, String ordering, String prdtEndYear, String prdtStartYear, String repNationCd, String[] movieTypeCdArr)
	    String movieCdResponse = service.getMovieList(true, curPage, itemPerPage, movieNm, directorNm, openStartDt, openEndDt, prdtStartYear, prdtEndYear, repNationCd, movieTypeCdArr);
		
		// Json 라이브러리를 통해 Handling
		ObjectMapper mapper = new ObjectMapper();
		
		HashMap<String,Object> result = mapper.readValue(movieCdResponse, HashMap.class);
		request.setAttribute("result", result);
	}
	
}
