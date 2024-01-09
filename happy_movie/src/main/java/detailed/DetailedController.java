package detailed;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dto.BookmarkDTO;
import dto.CrewDTO;
import dto.ImageDTO;
import dto.MovieDTO;
import dto.ReviewDTO;
import dto.ReviewPagingDTO;
import dto.UserDTO;

@Controller
public class DetailedController {
	@Autowired
	DetailedService service;
	
	@RequestMapping("/detailed")
	public ModelAndView detailedInfo(@RequestParam(value="movie_id", required=false, defaultValue="20226411") String movie_id,
			HttpSession session) {
		// MovieDTO 생성
		MovieDTO movie_dto = service.oneMovie(movie_id);
		
		// BookmarkDTO 생성
		BookmarkDTO book_dto = new BookmarkDTO();
		book_dto.setMovie_id(movie_id);
		book_dto.setUser_id((String)session.getAttribute("session_id"));
		int book_cnt = service.bookmarkUserCount(book_dto);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("detailed_type", "info");
		mv.addObject("movie_dto", movie_dto);
		mv.addObject("book_cnt", book_cnt);
		mv.setViewName("detailed/detailed");
		return mv;
	}
	
	@RequestMapping("/detailedperson")
	public ModelAndView detailedPerson(@RequestParam(value="movie_id", required=false, defaultValue="20226411") String movie_id,
			HttpSession session) {
		// MovieDTO 생성
		MovieDTO movie_dto = service.oneMovie(movie_id);
		
		// BookmarkDTO 생성
		BookmarkDTO book_dto = new BookmarkDTO();
		book_dto.setMovie_id(movie_id);
		book_dto.setUser_id((String)session.getAttribute("session_id"));
		int book_cnt = service.bookmarkUserCount(book_dto);
		
		// crew_list 생성
		List<CrewDTO> crew_list = service.crewProfile(movie_id);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("detailed_type", "person");
		mv.addObject("movie_dto", movie_dto);
		mv.addObject("crew_list", crew_list);
		mv.addObject("book_cnt", book_cnt);
		mv.setViewName("detailed/detailed");
		return mv;
	}
	
	@RequestMapping("/detailedphoto")
	public ModelAndView detailedPhoto(@RequestParam(value="movie_id", required=false, defaultValue="20226411") String movie_id,
			HttpSession session) {
		// MovieDTO 생성
		MovieDTO movie_dto = service.oneMovie(movie_id);
		
		// BookmarkDTO 생성
		BookmarkDTO book_dto = new BookmarkDTO();
		book_dto.setMovie_id(movie_id);
		book_dto.setUser_id((String)session.getAttribute("session_id"));
		int book_cnt = service.bookmarkUserCount(book_dto);
		
		// poster_list 생성
		ImageDTO posterdto = new ImageDTO();
		posterdto.setMovie_id(movie_id);
		posterdto.setImg_type('p');		
		List<String> poster_list = service.imagePS(posterdto);
		
		// still_list 생성
		ImageDTO stilldto = new ImageDTO();
		stilldto.setMovie_id(movie_id);
		stilldto.setImg_type('s');
		List<String> still_list = service.imagePS(stilldto);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("detailed_type", "photo");
		mv.addObject("movie_dto", movie_dto);
		mv.addObject("book_cnt", book_cnt);
		mv.addObject("poster_list", poster_list);
		mv.addObject("still_list", still_list);
		mv.setViewName("detailed/detailed");
		return mv;
	}
	
	@RequestMapping("/detailedgrade")
	public ModelAndView detailedGrade(@RequestParam(value="movie_id", defaultValue="20226411") String movie_id,
			@RequestParam(value="sort_type", defaultValue="date") String sort_type,
			@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(value="seq", defaultValue="0") int seq,
			@RequestParam(value="rating_star", defaultValue="0") int rating_star,
			@RequestParam(value="contents", required=false) String contents,
			HttpSession session) {
		// MovieDTO 생성
		MovieDTO movie_dto = service.oneMovie(movie_id);
		
		// BookmarkDTO 생성
		BookmarkDTO book_dto = new BookmarkDTO();
		book_dto.setMovie_id(movie_id);
		book_dto.setUser_id((String)session.getAttribute("session_id"));
		int book_cnt = service.bookmarkUserCount(book_dto);
		
		// ReviewPaginDTO 생성
		ReviewPagingDTO paging_dto = new ReviewPagingDTO();
		
		int total_cnt = service.reviewCount(movie_id);
		int cnt = service.reviewCount(movie_id);
		int divNum = 5;
		
		paging_dto.setMovie_id(movie_id);
		paging_dto.setStart((page - 1) * divNum);
		paging_dto.setEnd(divNum);
		
		if (sort_type.equals("star")) {
			paging_dto.setSort_type("rating_star");
		}
		else if (sort_type.equals("date")) {
			paging_dto.setSort_type("writing_time");
		}
		
		// ReviewDTO 생성
		if (seq != 0) {
			ReviewDTO review_dto = new ReviewDTO();
			review_dto.setSeq(seq);
			review_dto.setContents(contents);
			review_dto.setRating_star(rating_star);
			
			service.reviewUpdate(review_dto);
		}
		
		// UserDTO 생성
		String session_id = (String)session.getAttribute("session_id");
		UserDTO user_dto = service.oneUser(session_id);
		
		// review_list 생성
		List<ReviewDTO> review_list;
		
		if (sort_type.equals("user")) {
			ReviewDTO review_one = new ReviewDTO();
			review_one.setMovie_id(movie_id);
			review_one.setUser_id(session_id);
			review_list = service.reviewOne(review_one);
			cnt = 1;
		}
		else {
			review_list = service.reviewUserList(paging_dto);
		}
		
		// review_avg 생성
		double review_avg = 0.0;
		
		if (cnt != 0) {
			review_avg = service.reviewStarAvg(movie_id);
			review_avg = Math.round(review_avg * 10) / 10.0;
		}
		movie_dto.setStar(review_avg);
		service.reviewStarUpdate(movie_dto);
		
		// 리뷰 등록 중복 조회
		ReviewDTO r_dto = new ReviewDTO();
		r_dto.setMovie_id(movie_id);
		r_dto.setUser_id(session_id);
		int rv_c = service.reviewUserCount(r_dto);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("detailed_type", "grade");
		mv.addObject("movie_dto", movie_dto);
		mv.addObject("book_cnt", book_cnt);
		mv.addObject("review_list", review_list);
		mv.addObject("sort_type", sort_type);
		mv.addObject("page", page);
		mv.addObject("cnt", cnt);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("divNum", divNum);
		mv.addObject("user_dto", user_dto);
		mv.addObject("rv_c", rv_c);
		mv.setViewName("detailed/detailed");
		return mv;
	}
	
	@RequestMapping("/detailedgradeupdate")
	public ModelAndView detailedGradeUpdate(ReviewDTO review_dto) {
		service.reviewUpdate(review_dto);
	
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/detailedgrade?movie_id=" + review_dto.getMovie_id());
		return mv;
	}
	
	@RequestMapping("/detailedgradeinsert")
	public ModelAndView detailedGradeInsert(ReviewDTO review_dto) {
		service.insertOneReview(review_dto);
	
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/detailedgrade?movie_id=" + review_dto.getMovie_id());
		return mv;
	}
	
	@RequestMapping("/detailedgradedelete")
	public ModelAndView detailedGradeDelete(String seq, String movie_id) {
		int seqInt = Integer.parseInt(seq);
		service.reviewDelete(seqInt);
	
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/detailedgrade?movie_id=" + movie_id);
		return mv;
	}
	
	@RequestMapping("/detailedbookmark")
	public ModelAndView detailedBookmark(String user_id, String movie_id, String page_name, String type) {
		// BookmarkDTO 생성
		BookmarkDTO dto = new BookmarkDTO();
		dto.setMovie_id(movie_id);
		dto.setUser_id(user_id);
		
		if (type.equals("insert")) {
			service.insertBookmark(dto);
		}
		else {
			service.deleteBookmark(dto);
		}
		
		if (page_name.equals("info")) {
			page_name = "";
		}
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/detailed" + page_name + "?movie_id=" + movie_id);
		return mv;
	}
}
