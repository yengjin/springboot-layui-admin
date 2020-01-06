package cn.geek51.controller;

import cn.geek51.domain.PageHelper;
import cn.geek51.domain.Position;
import cn.geek51.service.IPositionService;
import cn.geek51.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class PositionController {
    @Autowired
    IPositionService service;

    // 查询
    @GetMapping("/positions")
    public Object getPositions(PageHelper pageHelper) {
        Map<Object, Object> map = pageHelper.getMap();
        List<Position> positionList = service.listAll(map);
        if (map == null) map = new HashMap<>();
        else map.clear();
        map.put("size", service.count());
        return ResponseUtil.general_response(positionList, map);
    }
    @GetMapping("/positions/{id}")
    public Object getPosition(@PathVariable("id") Integer id) {
        Position position = service.listOneById(id);
        return ResponseUtil.general_response(position);
    }

    // 更改
    @PutMapping("/positions")
    public Object updatePosition(@RequestBody Position position) {
        service.update(position);
        return ResponseUtil.general_response("success update position!");
    }

    // 新建
    @PostMapping("/positions")
    public Object insertPosition(Position position) {
        System.out.println(position);
        Integer newId = service.save(position);
        return ResponseUtil.general_response(newId);
    }

    // 删除
    @DeleteMapping("/positions/{id}")
    public Object deletePosition(@PathVariable("id") Integer id) {
        service.delete(id);
        return ResponseUtil.general_response("position delete success!");
    }
}
