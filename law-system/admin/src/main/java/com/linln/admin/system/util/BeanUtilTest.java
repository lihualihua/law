package com.linln.admin.system.util;

import org.apache.commons.beanutils.BeanUtils;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 当把Person类作为BeanUtilTest的内部类时，程序出错<br>
 * java.lang.NoSuchMethodException: Property '**' has no setter method<br>
 * 本质：内部类 和 单独文件中的类的区别 <br>
 * BeanUtils.populate方法的限制：<br>
 * The class must be public, and provide a public constructor that accepts no arguments. <br>
 * This allows tools and applications to dynamically create new instances of your bean, <br>
 * without necessarily knowing what Java class name will be used ahead of time
 */
public class BeanUtilTest {
    /**
     * Map 转换为 Bean
     * @param map
     * @param obj
     * @param <T>
     * @return
     */
    // Map --> Bean 2: 利用org.apache.commons.beanutils 工具类实现 Map --> Bean
    public static <T> T transMap2Bean2(Map<String, Object> map, Class<T>  obj) {
        T instance = getInstance(obj);
        try {
            BeanUtils.populate(instance, map);
        } catch (Exception e) {
            System.out.println("类型转换错误" + e);
        }
        return instance;
    }
    /**
     * List<Map<String, Object>> 转换为 List<T>
     * @param list
     * @param eClass
     * @param <T>
     * @return
     */
    public static <T> List<T> list_MapToBean(List<Map<String, Object>> list, Class<T> eClass) {
        List<T> l=new ArrayList<>();
        for (Map<String, Object> m : list) {
            T t = transMap2Bean2(m, eClass);
            l.add(t);
        }
        return l;
    }
    public static <T> T getInstance(Class<T> eClass){
        T instance = null;
        try {
            instance =  eClass.newInstance();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        return instance;
    }











//
//    public static void main(String[] args) {
//
//        PersonBean person = new PersonBean();
//        Map<String, Object> mp = new HashMap<String, Object>();
//        mp.put("name", "Mike");
//        mp.put("age", 25);
//        mp.put("mN", "male");
//
//        // 将map转换为bean
//        transMap2Bean2(mp, person);
//
//        System.out.println("--- transMap2Bean Map Info: ");
//        for (Map.Entry<String, Object> entry : mp.entrySet()) {
//            System.out.println(entry.getKey() + ": " + entry.getValue());
//        }
//
//        System.out.println("--- Bean Info: ");
//        System.out.println("name: " + person.getName());
//        System.out.println("age: " + person.getAge());
//        System.out.println("mN: " + person.getmN());
//
//        // 将javaBean 转换为map
//        Map<String, Object> map = transBean2Map(person);
//
//        System.out.println("--- transBean2Map Map Info: ");
//        for (Map.Entry<String, Object> entry : map.entrySet()) {
//            System.out.println(entry.getKey() + ": " + entry.getValue());
//        }
//
//    }







    // Map --> Bean 1: 利用Introspector,PropertyDescriptor实现 Map --> Bean
    public static <E> E  mapToBean(Map<String, Object> map, Class<E> obj) {
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();

            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();
                if (map.containsKey(key)) {
                    Object value = map.get(key);
                    // 得到property对应的setter方法
                    Method setter = property.getWriteMethod();
                    setter.invoke(obj, value);
                }

            }

        } catch (Exception e) {
            System.out.println("transMap2Bean Error " + e);
        }
        return (E) obj;
    }

    // Bean --> Map 1: 利用Introspector和PropertyDescriptor 将Bean --> Map
    public static Map<String, Object> transBean2Map(Object obj) {

        if(obj == null){
            return null;
        }        
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(obj.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();

                // 过滤class属性
                if (!key.equals("class")) {
                    // 得到property对应的getter方法
                    Method getter = property.getReadMethod();
                    Object value = getter.invoke(obj);

                    map.put(key, value);
                }

            }
        } catch (Exception e) {
            System.out.println("transBean2Map Error " + e);
        }

        return map;

    }


    /**
     * 将 JavaBean对象转化为 Map   此方法未测试
     * @author wyply115
     * @param bean 要转化的类型
     * @return Map对象
     * @version 2016年3月20日 11:03:01
     */
    public static Map convertBean2Map(Object bean) throws Exception {
        Class type = bean.getClass();
        Map returnMap = new HashMap();
        BeanInfo beanInfo = Introspector.getBeanInfo(type);
        PropertyDescriptor[] propertyDescriptors = beanInfo
                .getPropertyDescriptors();
        for (int i = 0, n = propertyDescriptors.length; i <n ; i++) {
            PropertyDescriptor descriptor = propertyDescriptors[i];
            String propertyName = descriptor.getName();
            if (!propertyName.equals("class")) {
                Method readMethod = descriptor.getReadMethod();
                Object result = readMethod.invoke(bean, new Object[0]);
                if (result != null) {
                    returnMap.put(propertyName, result);
                } else {
                    returnMap.put(propertyName, "");
                }
            }
        }
        return returnMap;
    }

    /**
     * 将 List<JavaBean>对象转化为List<Map>
     * @author wyply115
     * @param beanList
     * @return Object对象
     * @version 2016年3月20日 11:03:01
     */
    public static List<Map<String,Object>> convertListBean2ListMap(List<Object> beanList) throws Exception {
        List<Map<String,Object>> mapList = new ArrayList<Map<String,Object>>();
        for(int i=0, n=beanList.size(); i<n; i++){
            Object bean = beanList.get(i);
            Map map = convertBean2Map(bean);
            mapList.add(map);
        }
        return mapList;
    }


    //Map 转换 bean
    public static <T> T convertMap2Bean(Map map, Class T) throws Exception {
        if(map==null || map.size()==0){
            return null;
        }
        BeanInfo beanInfo = Introspector.getBeanInfo(T);
        T bean = (T)T.newInstance();
        PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
        for (int i = 0, n = propertyDescriptors.length; i <n ; i++) {
            PropertyDescriptor descriptor = propertyDescriptors[i];
            String propertyName = descriptor.getName();
            String upperPropertyName = propertyName.toUpperCase();
            if (map.containsKey(upperPropertyName)) {
                Object value = map.get(upperPropertyName);
                //这个方法不会报参数类型不匹配的错误。
                BeanUtils.copyProperty(bean, propertyName, value);
//用这个方法对int等类型会报参数类型不匹配错误，需要我们手动判断类型进行转换，比较麻烦。
//descriptor.getWriteMethod().invoke(bean, value);
//用这个方法对时间等类型会报参数类型不匹配错误，也需要我们手动判断类型进行转换，比较麻烦。
//BeanUtils.setProperty(bean, propertyName, value);
            }
        }
        return bean;
    }




    /**
     * List<泛型> 泛型类型转换
     * List generic conversion
     * @param sourceList
     * @param classType
     * @param <T>
     * @param <E>
     * @return List<T>
     */
    public static <T, E> List<E> listBeanToBean(List<T> sourceList, Class<E> classType) {
        if (null == sourceList) {
            return null;
        }
        List<E> returnList = new ArrayList<E>();
        for (T t : sourceList) {
            returnList.add(beanToBean(t, classType));
        }
        return returnList;
    }

    /**
     * Bean类型转换
     * List type conversion
     * @param source
     * @param classType
     * @param <T>
     * @param <E>
     * @return Bean
     */
    public static <T, E> E beanToBean(T source, Class<E> classType) {
        if (null == source) {
            return null;
        }
        E returnBean = null;
        try {
            returnBean = classType.newInstance();
            BeanUtils.populate(returnBean, BeanUtils.describe(source));
        } catch (IllegalAccessException e) {
            System.out.println("对象转换Map异常");
        } catch (InvocationTargetException e) {
            System.out.println("对象转换Map异常");
        } catch (NoSuchMethodException e) {
            System.out.println("对象转换Map异常");
        } catch (InstantiationException e) {
            System.out.println("反射创建对象异常");
        }
        return returnBean;
    }


}