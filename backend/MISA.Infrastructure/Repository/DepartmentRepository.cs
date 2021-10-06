using Microsoft.Extensions.Configuration;
using MISA.Core.Entities;
using MISA.Core.Interfaces.Infrastructure;
using System;
using System.Collections.Generic;
using System.Text;

namespace MISA.Infrastructure.Repository
{
    public class DepartmentRepository : BaseRepository<Department>, IDepartmentRepository
    {
        #region Constructor

        /// <summary>
        /// khởi tạo
        /// </summary>
        /// Author: CpNam 17.08.2021
        public DepartmentRepository(IConfiguration _configuration) : base(_configuration) {
        }

        #endregion Constructor
    }
}