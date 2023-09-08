package login;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.UserDTO;

@Controller
public class LoginController {
	@Autowired
	LoginService service;
	
	@RequestMapping("/login")
	public String loginGet() {
		return "login/login_login";
	}
	
	@RequestMapping("/loginresult")
	public ModelAndView loginPost(String user_id, String pw, HttpSession session) {
		// UserDTO 생성
		UserDTO dto = service.userOne(user_id);
		
		// result 생성
		String result = "ID 미존재";
		if (dto != null) {
			if (dto.getPw().equals(pw)) {
				session.setAttribute("session_id", user_id);
				session.setAttribute("session_pw", pw);
				result = "로그인 성공";
			}
			else {
				result = "PW 불일치";
			}
		}
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("result", result);
		mv.setViewName("login/login_result");
		return mv;
	}
	
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		if (session.getAttribute("session_id") != null) {
			session.removeAttribute("session_id");
			session.removeAttribute("session_pw");
		}
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/main");
		return mv;
	}
	
	@RequestMapping("/loginjoin")
	public ModelAndView loginJoin() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login/login_join");
		return mv;
	}
	
	@RequestMapping("/loginjoincheckid")
	@ResponseBody
	public HashMap<String, Integer> loginJoinCheckId(String id) {
		UserDTO user = service.userOne(id);
		int cnt = 0;
		
		if (user != null) {
			cnt = 1;
		}
		
		HashMap<String, Integer> map = new HashMap<>();
		map.put("cnt", cnt);
		
		return map;
	}
	
	@RequestMapping("/loginjoinsub")
	public ModelAndView loginJoinSub(UserDTO dto) {
		service.insertUser(dto);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/main");
		return mv;
	}
	
	@RequestMapping("/logindeleteuser")
	public ModelAndView loginDeleteUser(HttpSession session) {
		String user_id = (String)session.getAttribute("session_id");
		UserDTO dto = service.userOne(user_id);
		String pw = dto.getPw();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("id", user_id);
		mv.addObject("pw", pw);
		mv.setViewName("login/login_deleteuser");
		return mv;
	}
	
	@RequestMapping("/logindeleteusersub")
	public ModelAndView loginDeleteUserSub(HttpSession session) {
		String user_id = (String)session.getAttribute("session_id");
		service.deleteUser(user_id);
		
		if (session.getAttribute("session_id") != null) {
			session.removeAttribute("session_id");
		}
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/main");
		return mv;
	}
	
	@RequestMapping("/loginuserinfo")
	public ModelAndView loginUserInfo(HttpSession session) {
		String user_id = (String)session.getAttribute("session_id");
		
		// UserDTO 생성
		UserDTO dto = service.userOne(user_id);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto", dto);
		mv.setViewName("login/login_userinfo");
		return mv;
	}
	
	@RequestMapping("/loginuserinfosub")
	public ModelAndView loginUserInfoSub(UserDTO dto) {
		service.updateUser(dto);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/main");
		return mv;
	}
}
