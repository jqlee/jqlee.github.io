using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace ClassLibrary1{

	/// <summary>
	/// IMember 介面
	/// </summary>
	internal interface IMember{
		/// <summary>
		/// 名字
		/// </summary>
		UserName Name { get; set; }


		IList<PhoneNumber> Numbers { get; }


	}

	/// <summary>
	/// 客戶
	/// </summary>
	public class Customer : Member {
		/// <summary>
		/// 客戶編號
		/// </summary>
		public int CustomerNumber { get;set; }
	}
	/// <summary>
	/// 網站會員
	/// </summary>
	public class SiteMember : Member {
		/// <summary>
		/// 註冊帳號
		/// </summary>
		public string WebId { get; set; }

		public DateTime LastLogin { get;set; }
	}


	/// <summary>
	/// 會員基底類別
	/// </summary>
	public abstract class Member : IMember{
		/// <summary>
		/// 姓名
		/// </summary>
		public UserName Name{ get; set; }
		/// <summary>
		/// 公司電話號碼
		/// </summary>
		public PhoneNumber OfficeNumber { get; set; }
		/// <summary>
		/// 私人電話號碼
		/// </summary>
		public PhoneNumber PersonalNumber { get; set; }

		private readonly List<PhoneNumber> _numbers;
		/// <summary>
		/// 電話號碼
		/// </summary>
		public IList<PhoneNumber> Numbers {
			get { return _numbers; }
		}

		/// <summary>
		/// Member的建構式
		/// </summary>
		protected Member(){
			_numbers = new List<PhoneNumber>();
			
		}
	}

	/// <summary>
	/// 電話號碼
	/// </summary>
	public class PhoneNumber {
		/// <summary>
		/// 國碼
		/// </summary>
		public int CountryCode { get; set; }
		/// <summary>
		/// 號碼
		/// </summary>
		public int Number { get; set; }
		/// <summary>
		/// 分機
		/// </summary>
		public int Extention { get; set; }
	}
	/// <summary>
	/// 住址
	/// </summary>
	interface IAddress {
		int PostCode { get; set; }
		string Road { get; set; }
		string Street { get; set; }
		string Stat { get; set; }
		string Country { get; set; }
		int CountryCode { get; set; }
		int Number { get; set; }
		int Dash { get; set; }
	}
	/// <summary>
	/// 使用者姓名
	/// </summary>
	public class UserName{
		/// <summary>
		/// 名字
		/// </summary>
		public string FirstName { get; set; }
		/// <summary>
		/// 中間名
		/// </summary>
		public string MiddleName { get; set; }
		/// <summary>
		/// 姓
		/// </summary>
		public string LastName { get; set; }
		/// <summary>
		/// 暱稱
		/// </summary>
		public string NickName { get; set; }

		/// <summary>
		/// 顯示方式
		/// </summary>
		public UserNamePattern Display { get; set; }

		public enum UserNamePattern{
			/// <summary>
			/// 名字 姓氏
			/// </summary>
			FirstLast, 
			/// <summary>
			/// 姓名
			/// </summary>
			LastFirst, 
			/// <summary>
			/// 名字 中間名 姓氏
			/// </summary>
			FirstMiddleLast, 
			/// <summary>
			/// 暱稱 姓氏
			/// </summary>
			NickLast, 
			/// <summary>
			/// 暱稱
			/// </summary>
			Nick
		}

		public override string ToString(){
			var pattern = "";
			switch (Display){
				case UserNamePattern.FirstLast: pattern = "{0} {1}"; break;
				case UserNamePattern.FirstMiddleLast: pattern = "{0} {1} {2}"; break;
				case UserNamePattern.LastFirst: pattern = "{2}{0}"; break;
				case UserNamePattern.NickLast: pattern = "{3} {2}"; break;
				case UserNamePattern.Nick: pattern = "{3}"; break;
				default: pattern = "{0}"; break;
			}
			return string.Format(pattern, FirstName, MiddleName, LastName, NickName);
		}
	}
}
