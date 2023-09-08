package com.team4.happymovie;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestController {
	@RequestMapping("/test")
	public ModelAndView test() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("model", "모델 테스트");
		mv.setViewName("test");
		return mv;
	}
}