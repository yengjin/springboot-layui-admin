package cn.geek51.controller;

import cn.geek51.domain.Department;
import cn.geek51.domain.Employee;
import cn.geek51.domain.PageHelper;
import cn.geek51.domain.Position;
import cn.geek51.service.IDepartmentService;
import cn.geek51.service.IEmployeeService;
import cn.geek51.service.IPositionService;
import cn.geek51.util.ResponseUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 职员控制器
 */
@RestController
public class EmployeeController {
    @Autowired
    IEmployeeService employeeService;
    @Autowired
    IDepartmentService departmentService;
    @Autowired
    IPositionService positionService;

    // 新建
    @PostMapping("/employees")
    public Object insertEmployee(String departmentId, String positionId, Employee employee) {
        //System.out.println(employee);
        Department department = departmentService.listOneById(Integer.parseInt(departmentId));
        Position position = positionService.listOneById(Integer.parseInt(positionId));
        employee.setDepartment(department);
        employee.setPosition(position);
        employeeService.save(employee);
        return ResponseUtil.general_response("success update employee!");
    }

    // 查询, query传入LAYUI查询参数
    @GetMapping("/employees")
    public Object getEmployees(PageHelper pageHelper, String query) throws Exception {
        //System.out.println(request.getParameter("abc"));
        //System.out.println(query);
        Map<Object, Object> map = pageHelper.getMap();
        HashMap queryMap = null;
        // 进行拼接, 拼接成一个MAP查询
        if (query != null) {
            queryMap = new ObjectMapper().readValue(query, HashMap.class);
            map.putAll(queryMap);
        }
        List<Employee> employeeList = employeeService.listAll(map);

        // map重用, 用于回传pagesize
        if (map == null) map = new HashMap<>();
        else map.clear();
        map.put("size", employeeService.count());
        return ResponseUtil.general_response(employeeList, map);
    }
    @GetMapping("/employees/{id}")
    public Object getEmployee(@PathVariable("id") Integer id) {
        Employee employee = employeeService.listOneById(id);
        return ResponseUtil.general_response(employee);
    }

    // 更改
    @PutMapping("/employees")
    public Object updateEmployee(@RequestBody Map<String, String> map) {
        Employee employee = new Employee();

        Department department = departmentService.listOneById(Integer.parseInt(map.get("departmentId")));
        Position position = positionService.listOneById(Integer.parseInt(map.get("positionId")));
        employee.setId(Integer.parseInt(map.get("id")));
        employee.setDepartment(department);
        employee.setPosition(position);
        employee.setName(map.get("name"));
        employee.setSex(Boolean.parseBoolean(map.get("sex")));
        employee.setAddress(map.get("address"));
        employee.setEmail(map.get("email"));
        employee.setIdcard(map.get("idcard"));
        employee.setEducation(map.get("education"));
        employee.setPhone(map.get("phone"));
        employeeService.update(employee);
        return ResponseUtil.general_response("success update employee!");
    }

    // 删除
    @DeleteMapping("/employees/{id}")
    public Object deleteEmployee(@PathVariable("id") Integer id) {
        employeeService.delete(id);
        return ResponseUtil.general_response("success delete employee!");
    }
}
