using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary1.Store {
	public class ShoppingCart {
		public string SessionId { get; set; }

		public Customer CartOwner { get; set; }

		public ShelfColumn Item { get; set; }
	}
}
