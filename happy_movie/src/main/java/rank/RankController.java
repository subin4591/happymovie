package rank;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import dao.ApiDAO;
import dto.ApiDTO;
import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import kr.or.kobis.kobisopenapi.consumer.rest.exception.OpenAPIFault;

@Controller
public class RankController {
	
	@Autowired
	ApiService service;
	
	@RequestMapping("/rank")
	public ModelAndView rank() throws OpenAPIFault, Exception {
		Date currentDate = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		String target = String.valueOf((Integer.parseInt(formatter.format(currentDate))-1));
		
		String targetDt = target;		//조회일자
		String itemPerPage = "10";		//결과row수
		String multiMovieYn = "";		//“Y” : 다양성 영화 “N” : 상업영화 (default : 전체)
		String repNationCd = "";			//“K: : 한국영화 “F” : 외국영화 (default : 전체)
		String wideAreaCd = "";				//“0105000000” 로서 조회된 지역코드
		String curPage = "1";					//현재페이지
		String movieNm = "";						//영화명
		String directorNm = "";				//감독명
		String openStartDt = "";			//개봉연도 시작조건 ( YYYY )
		String openEndDt = "";				//개봉연도 끝조건 ( YYYY )	
		String prdtStartYear ="";	//제작연도 시작조건 ( YYYY )
		String prdtEndYear = "";			//제작연도 끝조건    ( YYYY )
		String[] movieTypeCdArr = null;	//영화형태코드 배열 (공통코드서비스에서 '2201'로 조회된 영화형태코드)
		
		// 발급키 3000회 제한
		String key = "b3a0415f8ef2c7923070066015819d92";
		/* String key = "bf2271f675c761c477ce7afc3b47bee1"; */
		/* String key = "478bf317e87507fd04843638f4a1ea4a"; */
		// KOBIS 오픈 API Rest Client를 통해 호출
	    KobisOpenAPIRestService service2 = new KobisOpenAPIRestService(key);
		
	 	// 영화코드조회 서비스 호출 (boolean isJson, String curPage, String itemPerPage,String directorNm, String movieCd, String movieNm, String openStartDt,String openEndDt, String ordering, String prdtEndYear, String prdtStartYear, String repNationCd, String[] movieTypeCdArr)
	    String movieCdResponse = service2.getMovieList(true, curPage, itemPerPage, movieNm, directorNm, openStartDt, openEndDt, prdtStartYear, prdtEndYear, repNationCd, movieTypeCdArr);
		
	 	// 일일 박스오피스 서비스 호출 (boolean isJson, String targetDt, String itemPerPage,String multiMovieYn, String repNationCd, String wideAreaCd)
	    String dailyResponse = service2.getDailyBoxOffice(true,targetDt,itemPerPage,multiMovieYn,repNationCd,wideAreaCd);
		
		// Json 라이브러리를 통해 Handling
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String,Object> dailyResult = mapper.readValue(dailyResponse, HashMap.class);
		
		HashMap<String,Object> result = mapper.readValue(movieCdResponse, HashMap.class);
	    /* System.out.println(result); */
		// KOBIS 오픈 API Rest Client를 통해 코드 서비스 호출 (boolean isJson, String comCode )
	
		movieList movielist = new movieList();
		ArrayList<ApiDTO> dtolist = new ArrayList();
		ArrayList dailymovielist =  (ArrayList)((HashMap)dailyResult.get("boxOfficeResult")).get("dailyBoxOfficeList");
		ArrayList ratelist = new ArrayList();
		for(Object dailymovie : dailymovielist) {
			HashMap dailymap = (HashMap)dailymovie;
			int movieCd = Integer.parseInt(dailymap.get("movieCd").toString());
			ApiDTO dto = service.selectMovie(movieCd);
			dtolist.add(dto);
			ratelist.add(dailymap.get("salesShare"));
		}

		ModelAndView mv = new ModelAndView();
		mv.addObject("ratelist",ratelist);
		mv.addObject("dtolist",dtolist);
		mv.setViewName("rank/rank");
		return mv;
	}
	@RequestMapping("/grade")
	public ModelAndView grade() {
		List<ApiDTO> dtolist = service.selectGrade();
		ModelAndView mv = new ModelAndView();
		mv.addObject("dtolist",dtolist);
		mv.setViewName("rank/grade");
		return mv;
	}
	
	@RequestMapping("genrelist")
	public ModelAndView genrelist(@RequestParam(value="page", required=false, defaultValue="1") int page,String genre) {
		
		//전체 게시물 갯수 (9) 가져와서 몇페이지까지 (1페이지당 4개 게시물) -  1 2 3
		int totalGenre = 0;
				
		
		//page번호 해당 게시물 4개 리스트 조회 
		int limitcount = 10;
		int limitindex = (page-1)*limitcount;
		int limit [] = new int[2];
		limit[0] = limitindex;
		limit[1] = limitcount;
		
		/*  1.  List<BoardDTO> -- 서비스 메소드 (limitindex,  limitcount);
		 *  2.  board-mapping.xml
		 * select * from board order by writingtime desc limit 배열[0],배열[1]
		 *  3. 1번 결과를 모델로 추가 저장
		 *  4. 뷰 3번 모델 저장 테이블 태그 출력
		 * */
		List<ApiDTO> list = null;
		switch (genre) {
		case "action":
			totalGenre = service.getTotalGenre("액션");
			list = service.actionList(limit);
			break;
		case "comedy":
			totalGenre = service.getTotalGenre("코미디");
			list = service.comedyList(limit);
			break;
		case "thriller":
			totalGenre = service.getTotalGenre("스릴러");
			list = service.thrillerList(limit);
			break;
		case "romance":
			totalGenre = service.getTotalGenre("로맨스");
			list = service.romanceList(limit);
			break;
		case "fantasy":
			totalGenre = service.getTotalGenre("판타지");
			list = service.fantasyList(limit);
			break;
		}
				
		ModelAndView mv = new ModelAndView();
		mv.addObject("page",page);
		mv.addObject("genre",genre);
		mv.addObject("totalGenre", totalGenre);
		mv.addObject("genreList", list);
		mv.setViewName("rank/genre");
		return mv;
	}
	
}
