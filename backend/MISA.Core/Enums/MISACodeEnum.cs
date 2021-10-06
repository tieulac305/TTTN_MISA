using System;
using System.Collections.Generic;
using System.Text;

namespace MISA.Core.Enums
{
    /// <summary>
    /// enum trạng thái request
    /// </summary>
    public enum MISACode
    {
        /// <summary>
        /// thành công
        /// </summary>
        Success = 0,

        /// <summary>
        /// bad request
        /// </summary>
        Invalid = 1,

        /// <summary>
        /// thất bại
        /// </summary>
        Fail = 2
    }
}