package com.linln.admin.system.validator;

import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotEmpty;
import java.io.Serializable;
@Data
public class UniversityValid implements Serializable {

    private String id;

    @NotEmpty(message = "排序不能为空")
    @Length(min =1,max = 12,message = "首字母格式1-12个字符")
    private String sort;
    @NotEmpty(message = "学校名称不能为空")
    @Length(min =1,max = 24,message = "学校名称格式1-24个字符")
    private String university;

}
