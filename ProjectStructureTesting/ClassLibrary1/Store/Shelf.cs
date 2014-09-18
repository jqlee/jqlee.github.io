using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClassLibrary1.Core;

namespace ClassLibrary1.Store {
	/// <summary>
	/// 貨架
	/// </summary>
	public class Shelf{
		private int _lastColumnIndex = -1;
		public ShelfColumn[] Columns;

		public Shelf(int columnCount){
			Columns = new ShelfColumn[columnCount];
		}

		/// <summary>
		/// 商品上架
		/// </summary>
		/// <param name="o">商品</param>
		/// <param name="price">價格</param>
		public void AddProduct(Product o , decimal price){
			Columns[_lastColumnIndex + 1].Product = o;
			Columns[_lastColumnIndex + 1].Price = price;
		}
	}

	/// <summary>
	/// 貨架欄位
	/// </summary>
	public class ShelfColumn {
		public int Index { get; set;}

		public Product Product { get; set; }

		public decimal Price { get; set; }
	}
}
