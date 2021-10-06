using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using MISA.Core.Entities;
using MISA.Core.Enums;
using MISA.Core.Interfaces.Service;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace MISA.AMIS.API.Controllers
{
    [Route("v1/[controller]")]
    [ApiController]
    public class BaseEntityController<MISAEntity> : ControllerBase
    {
        #region Fields

        /// <summary>
        /// service chung
        /// </summary>
        protected IBaseService<MISAEntity> baseService;

        #endregion Fields

        #region Constructor

        /// <summary>
        /// khởi tạo service
        /// </summary>
        /// <param name="baseService"></param>
        /// Author: CpNam 17.08.2021
        public BaseEntityController(IBaseService<MISAEntity> baseService) {
            this.baseService = baseService;
        }

        #endregion Constructor

        #region Methods

        /// <summary>
        /// Lấy toàn bộ dữ liệu
        /// </summary>
        /// <returns>danh sách dữ liệu</returns>
        /// Author: CpNam 06.08.2021
        [HttpGet]
        public IActionResult Get() {
            try {
                ServiceResult serviceResult = baseService.GetAllEntities();
                return Ok(serviceResult);
            }
            catch (Exception) {
                return ExceptionResult();
            }
        }

        /// <summary>
        /// Lấy một bản ghi theo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>nhân viên có cùng id hoặc no content</returns>
        /// Author: CpNam 05.08.2021
        [HttpGet("{id}")]
        public IActionResult Get(Guid id) {
            try {
                ServiceResult serviceResult = baseService.GetById(id);
                return Ok(serviceResult);
            }
            catch (Exception) {
                return ExceptionResult();
            }
        }

        /// <summary>
        /// Thêm mới một bản ghi
        /// </summary>
        /// Author: CpNam 05.08.2021
        [HttpPost]
        public IActionResult Post([FromBody] MISAEntity entity) {
            try {
                ServiceResult serviceResult = baseService.AddEntity(entity);
                if (serviceResult.MISACode == MISACode.Invalid) {
                    return Ok(serviceResult);
                }
                else {
                    return StatusCode(201, serviceResult);
                }
            }
            catch (Exception) {
                return ExceptionResult();
            }
        }

        /// <summary>
        /// Sửa thông tin bản ghi
        /// </summary>
        /// <param name="id">mã định danh</param>
        /// <param name="entity">nhân viên</param>
        /// Author: CpNam 05.08.2021
        [HttpPut("{id}")]
        public IActionResult Put(Guid id, [FromBody] MISAEntity entity) {
            try {
                ServiceResult serviceResult = baseService.EditEntity(id, entity);
                if (serviceResult.MISACode == MISACode.Invalid) {
                    return Ok(serviceResult);
                }
                else {
                    return StatusCode(201, serviceResult);
                }
            }
            catch (Exception) {
                return ExceptionResult();
            }
        }

        /// <summary>
        /// Xóa một bản ghi theo id
        /// </summary>
        /// <param name="id">mã định danh</param>
        /// Author: CpNam 06.08.2021
        [HttpDelete("{id}")]
        public IActionResult Delete(Guid id) {
            try {
                ServiceResult serviceResult = baseService.DeleteById(id);
                return Ok(serviceResult);
            }
            catch (Exception) {
                return ExceptionResult();
            }
        }

        /// <summary>
        /// nhập khẩu nhiều bản ghi
        /// </summary>
        /// <param name="list">danh sách bản ghi</param>
        /// Author: CpNam 06.10.2021
        [HttpPost("import")]
        public IActionResult Import([FromBody] List<MISAEntity> list) {
            try {
                ServiceResult serviceResult = baseService.Import(list);
                if (serviceResult.MISACode == MISACode.Invalid) {
                    return Ok(serviceResult);
                }
                else {
                    return StatusCode(201, serviceResult);
                }
            }
            catch (Exception) {
                return ExceptionResult();
            }
        }

        /// <summary>
        /// Service result cho các action bị lỗi
        /// </summary>
        /// Author: CpNam 06.08.2021
        protected IActionResult ExceptionResult() {
            ServiceResult serviceResult;
            serviceResult = new ServiceResult();
            serviceResult.MISACode = MISACode.Fail;
            serviceResult.Messenger = Core.Resources.Common.ResponseError_Exception;
            return StatusCode(500, serviceResult);
        }

        #endregion Methods
    }
}