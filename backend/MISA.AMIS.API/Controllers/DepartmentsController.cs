using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using MISA.Core.Entities;
using MISA.Core.Interfaces.Service;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace MISA.AMIS.API.Controllers
{
    [ApiController]
    public class DepartmentsController : BaseEntityController<Department>
    {
        #region Fields

        /// <summary>
        /// service cho phòng ban
        /// </summary>
        private IDepartmentService departmentService;

        #endregion Fields

        #region Constructor

        /// <summary>
        /// khởi tạo
        /// </summary>
        /// Author: CpNam 17.08.2021
        public DepartmentsController(IDepartmentService departmentService) : base(departmentService) {
            this.departmentService = departmentService;
        }

        #endregion Constructor
    }
}