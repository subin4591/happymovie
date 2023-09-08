package search;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.MovieDTO;

@Controller
public class SearchController {
	
	@Autowired
	SearchService service;
	
	@RequestMapping("/search")
	public ModelAndView search(HttpServletRequest request) throws UnsupportedEncodingException {
		ModelAndView mv = new ModelAndView();
		List<MovieDTO> list = new ArrayList();
		int cnt;
		
		String query = request.getParameter("query");
		
		query = URLDecoder.decode(query, "utf-8");
		System.out.println(query);
		
		list = service.searchMovie(query);
		cnt = service.searchCnt(query);
		
		MovieDTO dto = new MovieDTO();
		dto.setKor_title("������ �����ϴ�.");
		dto.setImg_url("resources/images/noimg.jpg");
		if (cnt == 0) {
			list.add(0, dto);
		}
		
		List<String> list1 = new ArrayList();
		List<String> list2 = new ArrayList();
		List<String> list3 = new ArrayList();
		List<String> list4 = new ArrayList();
		List<String> list5 = new ArrayList();
		List<String> list6 = new ArrayList();
		List<String> list7 = new ArrayList();
		
		for (int i = 0; i < cnt; i++) {
			list1.add(list.get(i).getMovie_id());
			list2.add(list.get(i).getKor_title());
			list3.add(list.get(i).getEng_title());
			list4.add(list.get(i).getImg_url());
			list5.add(list.get(i).getGenre());
			list6.add(list.get(i).getRelease_date());
			list7.add(list.get(i).getRating_age());
		}
		
		mv.addObject("list", list);
		mv.addObject("list1", list1);
		mv.addObject("list2", list2);
		mv.addObject("list3", list3);
		mv.addObject("list4", list4);
		mv.addObject("list5", list5);
		mv.addObject("list6", list6);
		mv.addObject("list7", list7);
		mv.addObject("cnt", cnt);
		mv.setViewName("/search/search");
		return mv;
	}
	

}
