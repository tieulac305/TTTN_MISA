import Constant from "../common/Constant";
import axios from 'axios';

/**
 * class api cho phòng ban
 * Author: CpNam 17.08.2021
 */
class DepartmentAPI{
    constructor(){
        this.url = Constant.UrlPrefix + Constant.UrlDepartment;
    }

    /**
     * lấy tất cả các phòng ban
     * @returns promise get all
     * Author: CpNam 17.08.2021
     */
    getDepartments(){
        return axios({
            method: 'get',
            url: this.url,
        });
    }
}

export default new DepartmentAPI();