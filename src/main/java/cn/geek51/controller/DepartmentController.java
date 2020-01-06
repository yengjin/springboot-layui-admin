package cn.geek51.controller;

import cn.geek51.domain.Department;
import cn.geek51.domain.PageHelper;
import cn.geek51.service.IDepartmentService;
import cn.geek51.util.ResponseUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class DepartmentController {

    @Autowired
    IDepartmentService service;

    // 查询
    @GetMapping("/depts")
    public Object getDepartments(PageHelper pageHelper) {
        Map<Object, Object> map = pageHelper.getMap();
        List<Department> departmentList = service.listAll(map);
        if (map == null) map = new HashMap<>();
        else map.clear();
        map.put("size", service.count());
        return ResponseUtil.general_response(departmentList, map);
    }
    @GetMapping("/depts/{id}")
    public Object getDerpartments(@PathVariable("id") Integer id) {
        Department department = service.listOneById(id);
        return ResponseUtil.general_response(department);
    }

    // 更改
    @PutMapping("/depts")
    public Object updateDepartment(@RequestBody Department department) {
        System.out.println(department);
        service.update(department);
        return ResponseUtil.general_response("success update department!");
    }

    // 新建
    @PostMapping("/depts")
    public Object insertDepartment(Department department) {
        System.out.println(department);
        Integer newId = service.save(department);
        return ResponseUtil.general_response(newId);
    }

    // 删除
    @DeleteMapping("/depts/{id}")
    public Object deleteDepartment(@PathVariable("id") Integer id) {
        service.delete(id);
        return ResponseUtil.general_response("success delete department!");
    }

}
