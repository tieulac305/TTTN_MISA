import Constant from "../common/Constant";
import axios from 'axios';

/**
 * class api cho nhân viên
 * Author: CpNam 17.08.2021
 */
class EmployeeAPI{
    constructor(){
        this.url = Constant.UrlPrefix + Constant.UrlEmployees;
    }

    /**
     * lấy toàn bộ nhân viên để xuất excel
     * Author: CpNam 05.10.2021
     */
    getEmployees(){
        return axios({
            method: 'get',
            url: this.url
        });
    }

    /**
     * lấy theo filter và phân trang
     * @param {Number} pageIndex trang cần lấy
     * @param {Number} pageSize kích thước trang
     * @param {String} employeeFilter
     * @returns promise
     * Author: CpNam 17.08.2021
     */
     getEmployeeFilterPaging(pageIndex, pageSize, employeeFilter = null){
        let params = {
            pageIndex: pageIndex,
            pageSize: pageSize,
        };
        if(employeeFilter){
            params['employeeFilter'] = employeeFilter;
        }
        return axios({
            method: 'get',
            params: params,
            url: this.url + '/employeeFilterPaging'
        });
    }

    /**
     * lấy mã nhân viên mới
     * Author: CpNam 18.08.2021
     */
    getNewCode(){
        return axios({
            method: 'get',
            url: this.url + '/newCode'
        });
    }

    /**
     * lấy ra một bản ghi
     * @param {String} id mã định danh
     * @returns promise
     * Author: CpNam 17.08.2021
     */
     getEmployee(id){
        return axios({
            method: 'get',
            url: this.url + '/' + id,
        });
    }

    /**
     * thêm mới 1 bản ghi
     * @param {Object} employee nhân viên
     * @returns promise
     * Author: CpNam 17.08.2021
     */
    addEmployee(employee){
        return axios({
            method: 'post',
            url: this.url,
            data: employee
        });
    }

    /**
     * sửa một bản ghi
     * @param {String} id mã định danh
     * @param {Object} item nhân viên
     * @returns promise
     * Author: CpNam 17.08.2021
     */
    editEmployee(id,item){
        return axios({
            method: 'put',
            url: this.url + '/' +id,
            data: item
        });
    }

    /**
     * xóa bản ghi
     * @param {String} id id cần xóa
     * @returns promise
     * Author: CpNam 17.08.2021
     */
    deleteEmployee(id){
        return axios({
            method: 'delete',
            url: this.url + '/' + id,
        });
    }

    /**
     * xóa nhiều bản ghi
     * @param {List} listId 
     * @returns promise
     */
    deleteMultiple(listId){
        return axios({
            method: 'delete',
            url: this.url,
            data: listId
        })
    }

    /**
     * thêm nhiều bản ghi
     * @param {Array} empList 
     * @returns promise
     */
    insertMultiple(empList){
        return axios({
            method: 'post',
            url: this.url + '/import',
            data: empList
        });
    }
}

export default new EmployeeAPI();