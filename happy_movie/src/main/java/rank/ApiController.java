package rank;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

import dto.ApiDTO;
import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import kr.or.kobis.kobisopenapi.consumer.rest.exception.OpenAPIFault;

@Controller
public class ApiController {

	@Autowired
	ApiService apiService;

	@RequestMapping("/insertapi")
	public void inserApi() throws OpenAPIFault, Exception {
		/*for(int cur = 1; cur < 620; cur++) {
		
		String curPage = String.valueOf(cur);		//현재페이지
		String itemPerPage = "10";	//결과row수
		String movieNm = "";						//영화명
		String movieNmEn = "";       //영화영문명
		String directorNm = "";				//감독명
		String openStartDt = "";			//개봉연도 시작조건 ( YYYY )
		String openEndDt = "";				//개봉연도 끝조건 ( YYYY )	
		String prdtStartYear = "";	//제작연도 시작조건 ( YYYY )
		String genreAlt = ""; //장르
		String prdtEndYear = "";			//제작연도 끝조건    ( YYYY )
		String repNationCd = "";			//대표국적코드 (공통코드서비스에서 '2204'로 조회된 국가코드)
		String[] movieTypeCdArr = null;	//영화형태코드 배열 (공통코드서비스에서 '2201'로 조회된 영화형태코드)
		ArrayList<HashMap> directorlist = null;
		ArrayList<HashMap> companylist = null;
		String openDt = ""; //개봉일
		String repNationNm = ""; // 국가명
		String companyNm = "";
		String movieCd = "";
		String release_date = "";
		int running_time = 0;
		int audiences = 0;
		Double rating_star = 0.0;
		String img_url = "";
		String synopsis = "";
		String rating_age = "";
		ArrayList ratinglist = null;
		
		// 발급키
		String key = "b3a0415f8ef2c7923070066015819d92";
		String key = "bf2271f675c761c477ce7afc3b47bee1";
		String key = "478bf317e87507fd04843638f4a1ea4a";
		// KOBIS 오픈 API Rest Client를 통해 호출
		KobisOpenAPIRestService service = new KobisOpenAPIRestService(key);
		
		// 영화코드조회 서비스 호출 (boolean isJson, String curPage, String itemPerPage,String directorNm, String movieCd, String movieNm, String openStartDt,String openEndDt, String ordering, String prdtEndYear, String prdtStartYear, String repNationCd, String[] movieTypeCdArr)
		String movieCdResponse = service.getMovieList(true, curPage, itemPerPage, movieNm, directorNm, openStartDt, openEndDt, prdtStartYear, prdtEndYear, repNationCd, movieTypeCdArr);
		
		// Json 라이브러리를 통해 Handling
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String,Object> result = mapper.readValue(movieCdResponse, HashMap.class);
		LinkedHashMap movieInfoMap = null;
		
		ArrayList list = (ArrayList)((LinkedHashMap)result.get("movieListResult")).get("movieList");
		ArrayList list2 = null;
		ApiSearch api = new ApiSearch();
		for(Object movie : list) {
			LinkedHashMap movie1 = (LinkedHashMap)movie;
			movieCd = movie1.get("movieCd").toString();
			movieNm = movie1.get("movieNm").toString();
			movieNmEn = movie1.get("movieNmEn").toString();
			if(movieNmEn.length()>50) {
				movieNmEn = movieNmEn.substring(0,50);
			}
			directorNm = "";
			directorlist = (ArrayList<HashMap>) movie1.get("directors");
			for(HashMap director : directorlist) {
				directorNm += director.get("peopleNm");
			}
			if(directorNm.length() !=0 && directorNm.charAt(directorNm.length() - 1) == ',') {
				directorNm = directorNm.substring(0, directorNm.length() - 1);
			}
			release_date = movie1.get("openDt").toString();
			genreAlt = movie1.get("genreAlt").toString();
			repNationNm = movie1.get("repNationNm").toString();
			companylist = (ArrayList<HashMap>) movie1.get("companys");
			companyNm = "";
			if(companylist.size() != 0) {
				companyNm = companylist.get(0).get("companyNm").toString();
			}
			// 영화코드조회 서비스 호출 (boolean isJson, String curPage, String itemPerPage,String directorNm, String movieCd, String movieNm, String openStartDt,String openEndDt, String ordering, String prdtEndYear, String prdtStartYear, String repNationCd, String[] movieTypeCdArr)
		    movieCdResponse = service.getMovieInfo(true, movieCd);
			
			result = mapper.readValue(movieCdResponse, HashMap.class);
			movieInfoMap = ((LinkedHashMap)((LinkedHashMap)result.get("movieInfoResult")).get("movieInfo"));
			running_time = Integer.parseInt(movieInfoMap.get("showTm").toString()) ;
			rating_star = Double.parseDouble(api.searchGrade(movieNm));
			img_url = api.imgurl(movieNm);
			
			synopsis = api.searchContent(movieNm);
			
			ratinglist = (ArrayList)movieInfoMap.get("audits");
			if(ratinglist.get(0) == null) {
				rating_age = "전체관람가";
			}else {
				rating_age = ((LinkedHashMap)ratinglist.get(0)).get("watchGradeNm").toString();
			}
			
			
			ApiDTO dto = new ApiDTO(movieCd, movieNm, movieNmEn, release_date,  rating_star, audiences, running_time, companyNm, genreAlt, repNationNm,rating_age, img_url,synopsis);
			System.out.println(curPage +  " : "+ dto);
			apiService.insertApi(dto);
		}
		
		// KOBIS 오픈 API Rest Client를 통해 코드 서비스 호출 (boolean isJson, String comCode )
		String nationCdResponse = service.getComCodeList(true,"2204");
		HashMap<String,Object> nationCd = mapper.readValue(nationCdResponse, HashMap.class);
		
		String movieTypeCdResponse = service.getComCodeList(true,"2201");
		HashMap<String,Object> movieTypeCd = mapper.readValue(movieTypeCdResponse, HashMap.class);
		
		
		String movieTypeCds = "[";
		if(movieTypeCdArr!=null){
			for(int i=0;i<movieTypeCdArr.length;i++){
				movieTypeCds += "'"+movieTypeCdArr[i]+"'";
				if(i+1<movieTypeCdArr.length){
					movieTypeCds += ",";
				}
			}
			movieTypeCds += "]";
		}		
		Thread.sleep(3000);
		}*/
	}

}
