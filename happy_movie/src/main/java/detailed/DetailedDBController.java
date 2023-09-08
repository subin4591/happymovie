package detailed;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.CrewDTO;
import dto.ImageDTO;
import dto.ReviewDTO;
import dto.UserDTO;

@Controller
public class DetailedDBController {
	@Autowired
	DetailedService service;
	
	@RequestMapping("/detaileddbtest")
	public ModelAndView detailedDBTest() {
		List<UserDTO> list = service.userList();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("userlist", list);
		mv.addObject("usercount", list.size());
		mv.setViewName("detailed/detailed_db_test");
		return mv;
	}
	
	@RequestMapping("/detailedapitest")
	public String detailedMovieTest() {
		return "detailed/detailed_api_test";
	}
	
	@GetMapping("/detaileddbmanagement")
	public String detailedDBManagementGet() {
		return "detailed/detailed_db_management";
	}
	
	@RequestMapping("/detaileddbinsert")
	public String detailedDBInsert() {
		return "detailed/detailed_db_insert";
	}
	
	@RequestMapping("/detaileddbinsertimage")
	public ModelAndView detailedDBInsertImage(ImageDTO dto) {
		ModelAndView mv = new ModelAndView();
		
		if (dto != null && dto.getImg_url() != null) {
			service.insertImageTable(dto);
			mv.addObject("insertresult", "image_table insert 성공");			
		}
		
		mv.setViewName("detailed/detailed_db_insert");
		return mv;
	}
	
	@RequestMapping("/detaileddbinsertcrew")
	public ModelAndView detailedDBInsertCrew(CrewDTO dto) {
		ModelAndView mv = new ModelAndView();
		
		if (dto != null && dto.getProfile_url() != null) {
			service.insertCrewTable(dto);
			mv.addObject("insertresult", "crew_table insert 성공");			
		}
		
		mv.setViewName("detailed/detailed_db_insert");
		return mv;
	}
	
	@RequestMapping("/detaileddbinsertreview")
	public ModelAndView detailedDBInsertReview(ReviewDTO dto) {
		ModelAndView mv = new ModelAndView();
		String user_id[] = {"gwon", "hwang", "moon", "member1", "member2", "member3", "member4", "member5", "member6", "member7", "member8", "member9"};
		String contents[] = {
				"인생이 아주 재미없을 때 보면 재밌을수도",
				"배우들 연기는 좋으나 연출은 별로, 스토리는 재미있었음",
				"소소하게 재미있었어요!",
				"꿀잼",
				"이런 영화를 기다려왔어요.",
				"스토리, 연기, 연출 등 모든 것이 완벽한 영화"};
		String date[] = {
				"2023-05-28 15:38:00",
				"2023-05-29 21:57:00",
				"2023-05-30 09:15:00",
				"2023-05-31 21:15:00",
				"2023-06-01 18:34:00",
				"2023-06-01 16:27:00",
				"2023-06-02 01:05:00",
				"2023-06-02 20:12:00",
				"2023-06-03 17:24:00",
				"2023-06-04 03:51:00"};
		int cnt = service.reviewCount(dto.getMovie_id());
		if (cnt == 0 && dto.getMovie_id() != null) {
			for (String u : user_id) {
				int randC = (int)(Math.random() * 6);
				int randD = (int)(Math.random() * 10);
				
				dto.setUser_id(u);
				dto.setContents(contents[randC]);
				dto.setRating_star(randC + 5);
				dto.setWriting_time(date[randD]);
				
				service.insertReviewTable(dto);
				mv.addObject("insertresult", "review_table insert 성공");	
			}			
		}
		else {
			mv.addObject("insertresult", "review_table insert 실패");				
		}
			
		mv.setViewName("detailed/detailed_db_insert");
		return mv;
	}
}
