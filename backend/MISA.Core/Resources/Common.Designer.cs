//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MISA.Core.Resources {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "16.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    public class Common {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal Common() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("MISA.Core.Resources.Common", typeof(Common).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        public static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Không tìm thấy bản ghi..
        /// </summary>
        public static string Response_NotFound {
            get {
                return ResourceManager.GetString("Response_NotFound", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Có lỗi xảy ra, vui lòng liên hệ chăm sóc khách hàng..
        /// </summary>
        public static string ResponseError_Exception {
            get {
                return ResourceManager.GetString("ResponseError_Exception", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Dữ liệu không đúng định dạng..
        /// </summary>
        public static string ResponseError_FormatError {
            get {
                return ResourceManager.GetString("ResponseError_FormatError", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Dữ liệu quá dài so với cho phép..
        /// </summary>
        public static string ResponseError_MaxLengthError {
            get {
                return ResourceManager.GetString("ResponseError_MaxLengthError", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Không được bỏ trống trường này..
        /// </summary>
        public static string ResponseError_RequiredError {
            get {
                return ResourceManager.GetString("ResponseError_RequiredError", resourceCulture);
            }
        }
    }
}
