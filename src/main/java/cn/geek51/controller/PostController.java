package cn.geek51.controller;

import cn.geek51.domain.Employee;
import cn.geek51.domain.PageHelper;
import cn.geek51.domain.Post;
import cn.geek51.service.IEmployeeService;
import cn.geek51.service.IPostService;
import cn.geek51.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.xml.ws.Response;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Post公告控制器
 * 实现IRestfulController, 遵循RestFul设计规范
 */
@RestController
public class PostController {
    @Autowired
    IPostService postService;

    // 查询
    @GetMapping("/posts")
    public Object getPosts(PageHelper pageHelper) {
        Map<Object, Object> map = pageHelper.getMap();
        List<Post> postList = postService.listAll(map);
        if (map == null) map = new HashMap<>();
        else map.clear();
        map.put("size", postService.count());
        return ResponseUtil.general_response(postList, map);
    }
    @GetMapping("/posts/{id}")
    public Object getPost(@PathVariable("id") Integer id) {
        Post post = postService.listOneById(id);
        return ResponseUtil.general_response(post);
    }

    // 更改
    @PutMapping("/posts")
    public Object updatePost(@RequestBody Post post) {
        System.out.println(post);
        if (postService.update(post) > 0) {
            return ResponseUtil.general_response("success updated!");
        } else {
            return ResponseUtil.general_response("fail update!", ResponseUtil.CODE_ERROR);
        }
    }

    // 新建
    @PostMapping("/posts")
    public Object insertPost(Post post, String username) {
        System.out.println(post);
        post.setUsername(username);
        postService.save(post);
        return ResponseUtil.general_response("success insert post!");
    }

    // 删除
    @DeleteMapping("/posts/{id}")
    public Object deleteUserAuth(@PathVariable("id") Integer id) {
        postService.delete(id);
        return ResponseUtil.general_response("post delete success!");
    }
}
