package  main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.BookmarkDTO;
import dto.MovieDTO;
import dto.VideoDTO;

@Controller
public class MainController {
	@Autowired
	MainService service;
	
	
	public String testStar (double star){

    	String result = "star50.svg";
    	if (9.0 <= star && star < 10.0) result = "star45.svg";
    	else if (8.0 <= star && star < 9.0) result = "star40.svg";	
    	else if (7.0 <= star && star < 8.0) result = "star35.svg";	
    	else if (6.0 <= star && star < 7.0) result = "star30.svg";	
    	else if (5.0 <= star && star < 6.0) result = "star25.svg";	
    	else if (4.0 <= star && star < 5.0) result = "star20.svg";	
    	else if (3.0 <= star && star < 4.0) result = "star15.svg";
    	else if (2.0 <= star && star < 3.0) result = "star10.svg";	
    	else if (1.0 <= star && star < 2.0) result = "star05.svg";	
    	else result = "star00.svg";
    return result;
	}
	
	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		
		List<VideoDTO> list = new ArrayList();
		List<MovieDTO> list2 = new ArrayList();
		List<BookmarkDTO> list3 = new ArrayList();
		int cnt;
		
		
		list = service.videoList();	
		mv.addObject("videoList", list);
	
		cnt = service.videoCnt();
		mv.addObject("videoCnt", cnt);
		
		int mIndex = (int)((Math.random()*10000)%cnt);	//0~5 ���� ����
        mv.addObject("mIndex", mIndex);
        int mIndex2 = (mIndex+1)%cnt;
        int mIndex3 = (mIndex+2)%cnt;
        mv.addObject("mIndex2", mIndex2);
        mv.addObject("mIndex3", mIndex3);
        
		list2 = service.ranking5List();
		mv.addObject("ranking5List", list2);
		
		String star0 = testStar(service.ranking5List().get(0).getRating_star());
		String star1 = testStar(service.ranking5List().get(1).getRating_star());
		String star2 = testStar(service.ranking5List().get(2).getRating_star());
		String star3 = testStar(service.ranking5List().get(3).getRating_star());
		String star4 = testStar(service.ranking5List().get(4).getRating_star());
		mv.addObject("ranking5star0", star0);
		mv.addObject("ranking5star1", star1);
		mv.addObject("ranking5star2", star2);
		mv.addObject("ranking5star3", star3);
		mv.addObject("ranking5star4", star4);
		
		
		list2 = service.bookmarkList((String)session.getAttribute("session_id"));
		cnt = service.bookmarkCnt((String)session.getAttribute("session_id"));
		
		List<String> bi = new ArrayList();
		List<String> bt = new ArrayList();
		List<String> bm = new ArrayList();
		
		for (int i = 0; i < cnt; i++) {
			bi.add(list2.get(i).getImg_url());
			bt.add(list2.get(i).getKor_title());
			bm.add(list2.get(i).getMovie_id());
		}

		mv.addObject("bookmarkListi",bi);
		mv.addObject("bookmarkListt",bt);
		mv.addObject("bookmarkListm",bm);
		mv.addObject("bookmarkCnt", cnt);
		mv.setViewName("/main/main");
		
		return mv;
	}
	
	@RequestMapping("/mainbookmarkdelete")
	public ModelAndView bookmarkDelete2(String user_id, String movie_id) {
		BookmarkDTO dto = new BookmarkDTO();
		dto.setUser_id(user_id);
		dto.setMovie_id(movie_id);
		
		service.bookmarkDelete(dto);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/main");
		return mv;
	}
}
