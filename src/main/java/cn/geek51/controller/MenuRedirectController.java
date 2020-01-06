package cn.geek51.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 负责页面转发
 */
@Controller
public class MenuRedirectController {
    @RequestMapping("/index")
    public String toIndex(Model model) {
        String name = "BruceYan";
        model.addAttribute("name", name);
        return "index_view";
    }
}
