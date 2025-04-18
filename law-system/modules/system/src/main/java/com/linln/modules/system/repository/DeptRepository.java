package com.linln.modules.system.repository;

import com.linln.common.constant.StatusConst;
import com.linln.modules.system.domain.Dept;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * @author 小懒虫
 * @date 2018/12/02
 */
public interface DeptRepository extends BaseRepository<Dept, Long> {

    /**
     * 查找多个部门
     * @param ids id列表
     */
    public List<Dept> findByIdIn(List<Long> ids);

    /**
     * 获取排序最大值
     * @param pid 父部门ID
     */
    @Query("select max(sort) from Menu m where m.pid = ?1 and m.status <> " + StatusConst.DELETE)
    public Integer findSortMax(long pid);

    /**
     * 根据父ID查找子孙部门
     * @param pids pid列表
     */
    public List<Dept> findByPidsLikeAndStatus(String pids, Byte status);
    public List<Dept> findByPidsLikeAndStatusOrId(String pids, Byte status,Long id);


    /**
     * 根据父级部门ID获取本级全部部门
     * @param sort 排序对象
     * @param pid 父部门ID
     * @param notId 需要排除的部门ID
     */
    public List<Dept> findByPidAndIdNot(Sort sort, long pid, long notId);


    //根据父级部门id查找子一级所有部门
    List<Dept> findAllByPid(Long id);
}

