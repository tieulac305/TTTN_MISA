using MISA.Core.Entities;
using MISA.Core.Interfaces.Infrastructure;
using MISA.Core.Interfaces.Service;
using System;
using System.Collections.Generic;
using System.Text;

namespace MISA.Core.Services
{
    public class DepartmentService : BaseService<Department>, IDepartmentService
    {
        #region Fields

        /// <summary>
        /// repo thao tác với csdl
        /// </summary>
        private IDepartmentRepository departmentRepository;

        #endregion Fields

        #region Constructor

        /// <summary>
        /// khởi tạo
        /// </summary>
        /// Author: CpNam 17.08.2021
        public DepartmentService(IDepartmentRepository _baseRepository) : base(_baseRepository) {
            departmentRepository = _baseRepository;
        }

        #endregion Constructor
    }
}