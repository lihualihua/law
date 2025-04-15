package com.linln.admin.system.controller;

import com.linln.admin.system.validator.DeptValid;
import com.linln.common.constant.AdminConst;
import com.linln.common.enums.ResultEnum;
import com.linln.common.enums.StatusEnum;
import com.linln.common.exception.ResultException;
import com.linln.common.utils.EntityBeanUtil;
import com.linln.common.utils.HttpServletUtil;
import com.linln.common.utils.ResultVoUtil;
import com.linln.common.utils.StatusUtil;
import com.linln.common.vo.ResultVo;
import com.linln.component.actionLog.action.SaveAction;
import com.linln.component.actionLog.action.StatusAction;
import com.linln.component.actionLog.action.UserAction;
import com.linln.component.actionLog.annotation.ActionLog;
import com.linln.component.actionLog.annotation.EntityParam;
import com.linln.component.shiro.ShiroUtil;
import com.linln.modules.system.domain.Dept;
import com.linln.modules.system.domain.Role;
import com.linln.modules.system.domain.User;
import com.linln.modules.system.service.DeptService;
import com.linln.modules.system.service.RoleService;
import com.linln.modules.system.service.UserService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * @author 小懒虫
 * @date 2018/12/02
 */
@Controller
@RequestMapping("/system/dept")
public class DeptController {

    @Autowired
    private DeptService deptService;

    /**
     * 跳转到列表页面
     */
    @GetMapping("/index")
    @RequiresPermissions("system:dept:index")
    public String index(Model model, Dept dept) {
        String search = HttpServletUtil.getRequest().getQueryString();
        model.addAttribute("search", search);
        return "/system/dept/index";
    }


    /**
     * 部门数据列表
     */
    @GetMapping("/list")
    @RequiresPermissions(value = {"system:dept:index", "system:user:index"}, logical = Logical.OR)
    @ResponseBody
    public ResultVo list(Dept dept) {
        List<Dept> list;
        User admin = ShiroUtil.getSubject();
        if(AdminConst.ADMIN_ID == admin.getId()){
            // 创建匹配器，进行动态查询匹配
            ExampleMatcher matcher = ExampleMatcher.matching().withMatcher("title", match -> match.contains());
//         获取部门列表
            Example<Dept> example = Example.of(dept, matcher);
            Sort sort = new Sort(Sort.Direction.ASC, "sort");
            list = deptService.getListByExample(example, sort);
        }else{
//////        //查询自己所在部门之下的部门
            list =deptService.getListByPidLikeOk(admin.getDept().getId());
        }
        return ResultVoUtil.success(list);
    }

    /**
     * 部门数据列表
     */
    @GetMapping("/list1")
    @RequiresPermissions(value = {"system:dept:index", "system:user:index"}, logical = Logical.OR)
    @ResponseBody
    public ResultVo list1(Dept dept) {
        List<Dept> list;
        User admin = ShiroUtil.getSubject();
        if(AdminConst.ADMIN_ID == admin.getId()){
            // 创建匹配器，进行动态查询匹配
            ExampleMatcher matcher = ExampleMatcher.matching().withMatcher("title", match -> match.contains());
//         获取部门列表
            Example<Dept> example = Example.of(dept, matcher);
            Sort sort = new Sort(Sort.Direction.ASC, "sort");
            list = deptService.getListByExample(example, sort);
        }else{
//////        //查询自己所在部门之下的部门 （包括自己）
            list =deptService.getListByPidLikeOkAdmin(admin.getDept().getId());
        }
        return ResultVoUtil.success(list);
    }

    /**
     * 获取排序菜单列表
     */
    @GetMapping("/sortList/{pid}/{notId}")
    @RequiresPermissions({"system:dept:add", "system:dept:edit"})
    @ResponseBody
    public Map<Integer, String> sortList(
            @PathVariable(value = "pid", required = false) Long pid,
            @PathVariable(value = "notId", required = false) Long notId){
        // 本级排序菜单列表
        notId = notId != null ? notId : (long) 0;
        List<Dept> levelDept = deptService.getListByPid(pid, notId);
        Map<Integer, String> sortMap = new TreeMap<>();
        for (int i = 1; i <= levelDept.size(); i++) {
            sortMap.put(i, levelDept.get(i - 1).getTitle());
        }
        return sortMap;
    }

    /**
     * 跳转到添加页面
     */
    @GetMapping({"/add", "/add/{pid}"})
    @RequiresPermissions("system:dept:add")
    public String toAdd(@PathVariable(value = "pid", required = false) Dept pDept, Model model) {
        model.addAttribute("pDept", pDept);
        return "/system/dept/add";
    }

    /**
     * 跳转到编辑页面
     */
    @GetMapping("/edit/{id}")
    @RequiresPermissions("system:dept:edit")
    public String toEdit(@PathVariable("id") Dept dept, Model model) {
        Dept pDept = deptService.getById(dept.getPid());
        if (pDept == null) {
            pDept = new Dept();
            pDept.setId((long) 0);
            pDept.setTitle("顶级");
        }

        model.addAttribute("dept", dept);
        model.addAttribute("pDept", pDept);
        return "/system/dept/add";
    }

    /**
     * 保存添加/修改的数据
     * @param valid 表单验证对象
     */
    @PostMapping("/save")
    @RequiresPermissions({"system:dept:add", "system:dept:edit"})
    @ResponseBody
    @ActionLog(name = "部门管理", message = "部门：${title}", action = SaveAction.class)
    public ResultVo save(@Validated DeptValid valid, @EntityParam Dept dept) {
        if (dept.getId() == null) {
            // 排序为空时，添加到最后
            if(dept.getSort() == null){
                Integer sortMax = deptService.getSortMax(dept.getPid());
                dept.setSort(sortMax !=null ? sortMax - 1 : 0);
            }

            // 添加全部上级序号
            if (dept.getPid() != 0) {
                Dept pDept = deptService.getById(dept.getPid());
                dept.setPids(pDept.getPids() + ",[" + dept.getPid() + "]");
            } else {
                dept.setPids("[0]");
            }
        }

            if(dept.getId()==dept.getPid()){
                return ResultVoUtil.error("参数错误");
            }

        // 将验证的数据复制给实体类
        if (dept.getId() != null) {
            Dept beDept = deptService.getById(dept.getId());
            EntityBeanUtil.copyProperties(beDept, dept, "dept", "pids");
        }

        // 排序功能
        Integer sort = dept.getSort();
        Long notId = dept.getId() != null ? dept.getId() : 0;
        List<Dept> levelDept = deptService.getListByPid(dept.getPid(), notId);
        levelDept.add(sort, dept);
        for (int i = 1; i <= levelDept.size(); i++) {
            levelDept.get(i - 1).setSort(i);
        }

        // 保存数据
        deptService.save(levelDept);

        List<Long> l=new ArrayList<>();
        l.add(Long.valueOf(0));
        List<String> l2=new ArrayList<>();
        l2.add("[0]");
        for(int i=0;i<l.size();i++){
            List<Dept> list = deptService.getListByPid(l.get(i));
            for(Dept dept1 :list){
                l.add(dept1.getId());
                    if(i==0){
                        l2.add("[0]");
                        dept1.setPids("[0]");
                    }else{
                        l2.add(l2.get(i)+",[" + dept1.getPid() + "]");
                        dept1.setPids(l2.get(i)+",[" + dept1.getPid() + "]");
                    }
                deptService.save(dept1);
            }
        }
        return ResultVoUtil.SAVE_SUCCESS;
    }

    /**
     * 跳转到详细页面
     */
    @GetMapping("/detail/{id}")
    @RequiresPermissions("system:dept:detail")
    public String toDetail(@PathVariable("id") Dept dept, Model model){
        model.addAttribute("dept", dept);
        return "/system/dept/detail";
    }

    /**
     * 设置一条或者多条数据的状态
     */
    @RequestMapping("/status/{param}")
    @RequiresPermissions("system:dept:status")
    @ResponseBody
    @ActionLog(name = "部门状态", action = StatusAction.class)
    public ResultVo status(
            @PathVariable("param") String param,
            @RequestParam(value = "ids", required = false) List<Long> ids){
        // 更新状态
        StatusEnum statusEnum = StatusUtil.getStatusEnum(param);
        if (deptService.updateStatus(statusEnum, ids)) {
            return ResultVoUtil.success(statusEnum.getMessage() + "成功");
        } else {
            return ResultVoUtil.error(statusEnum.getMessage() + "失败，请重新操作");
        }
    }





    @Autowired
    RoleService roleService;

    /**
     * 跳转到角色分配页面
     */
    @GetMapping("/role")
    @RequiresPermissions("system:dept:role")
    public String toRole(@RequestParam(value = "ids") Dept ids, Model model) {
        User user1 = ShiroUtil.getSubject();
        // 获取指定用户角色列表
        Set<Role> authRoles = ids.getRoles();
        if (0 == user1.getDept().getPid()) {
            //原版
            // 获取全部角色列表
            Sort sort = new Sort(Sort.Direction.ASC, "createDate");
            List<Role> list = roleService.getListBySortOk(sort);
            model.addAttribute("list", list);
        } else {
            Set<Role> list = roleService.findByDepts_IdAndStatus(user1.getId());
            model.addAttribute("list", list);
        }
        model.addAttribute("id", ids.getId());
        model.addAttribute("authRoles", authRoles);
        return "/system/dept/role";
    }
    @Autowired
    UserService userService;
    /**
     * 保存角色分配信息
     */
    @PostMapping("/role/save")
    @RequiresPermissions("system:dept:role")
    @ResponseBody
    public ResultVo auth(
            @RequestParam(value = "id", required = true) Dept dept,
            @RequestParam(value = "roleId", required = false) HashSet<Role> roles) {

        // 不允许操作超级管理员数据
        if (dept.getId().equals(AdminConst.ADMIN_DEPT_ID) &&
                !ShiroUtil.getSubject().getId().equals(AdminConst.ADMIN_ID)) {
            throw new ResultException(ResultEnum.NO_ADMIN_AUTH);
        }

        // 更新用户角色
        dept.setRoles(roles);

        // 保存数据
        deptService.save(dept);
        return ResultVoUtil.SAVE_SUCCESS;
    }







}
