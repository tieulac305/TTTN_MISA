using MISA.Core.Enums;
using System;
using System.Collections.Generic;
using System.Text;

namespace MISA.Core.Entities
{
    /// <summary>
    /// kết quả request trả ra
    /// </summary>
    public class ServiceResult
    {
        /// <summary>
        /// Object chứa dữ liệu data
        /// </summary>
        public object Data { get; set; }

        /// <summary>
        /// Message thông báo trạng thái
        /// </summary>
        public string Messenger { get; set; }

        /// <summary>
        /// MISA code
        /// </summary>
        public MISACode MISACode { get; set; }
    }
}