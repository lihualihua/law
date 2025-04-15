package com.linln.admin.system.util;


import lombok.Data;

import java.sql.Date;

@Data
public class DeptRoleUtil {


        private String id;
        private String username;
        private String nickname;
        private String dept_title;
        private String sex;
        private String phone;
        private String email;
        private Date createDate;
        private String status;

}
