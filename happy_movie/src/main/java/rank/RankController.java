package rank;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RankController {
	@RequestMapping("/sample1")
	public String sample1() {
		return "rank/sample1";
	}
	@RequestMapping("/rank")
	public String rank() {
		return "rank/rank";
	}
	
}
