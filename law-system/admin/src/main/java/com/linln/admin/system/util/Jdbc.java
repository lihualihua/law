package com.linln.admin.system.util;

import org.hibernate.transform.Transformers;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;
import java.util.Map;


public class Jdbc {

    public List jdbc(EntityManager em, String sql, Object... objects) {
        Query q = em.createNativeQuery(sql);
        for (int i = 0; i < objects.length; i++) {
            q.setParameter(i+1, objects[i]);
        }
        q.unwrap(org.hibernate.SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        return q.getResultList();
    }
    public <E> List<E> jdbc(EntityManager em, String sql, Class<E> eClass, Object... objects) {
        return BeanUtilTest.list_MapToBean(jdbc(em, sql, objects), eClass);
    }










    public static <E> void testReflect(Class<E> eClass, Map map) {
        for (Field field : eClass.getDeclaredFields()) {
            field.setAccessible(true);
            System.out.println(field.getName() + ":");
        }
    }

}

//        List<E> l=new ArrayList<>();
//        List<Map<String,Object>> mmm=new ArrayList<>();

//        for (Map<String, Object> m : lists) {
//          E e = getInstance(eClass);
//            Map map=new HashMap();
//            for (Field bean : eClass.getDeclaredFields()) {
//                bean.setAccessible(true);
//
//                Iterator it = m.keySet().iterator();
//                while (it.hasNext()) {
//                    String key = (String) it.next();
//                    if (bean.getName().equals(key)) {
//                        System.out.println(m.get(key));
////                         e = BeanTransBean.beanToBean(it, eClass);
//                        map.put(bean.getName(),m.get(key));
//
//
//                    }
//
//
//                }
//
//            }
//
//            mmm.add(map);
//            }
