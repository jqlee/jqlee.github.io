using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary1.Core {
	/// <summary>
	/// 產品
	/// </summary>
	public class Product {
		/// <summary>
		/// 識別碼
		/// </summary>
		public Guid Identity { get; set; }
		/// <summary>
		/// 名稱
		/// </summary>
		public string Name { get; set; }
		/// <summary>
		/// 類別
		/// </summary>
		public Category ProductCategory { get; set; }
		/// <summary>
		/// 描述
		/// </summary>
		public string Description { get; set; }
	}
}
