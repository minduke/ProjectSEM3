//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GiveAID.Models.model
{
    using System;
    using System.Collections.Generic;
    
    public partial class post
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public post()
        {
            this.payments = new HashSet<payment>();
        }
    
        public int id { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public string content { get; set; }
        public string image { get; set; }
        public Nullable<System.DateTime> time_start { get; set; }
        public Nullable<System.DateTime> time_end { get; set; }
        public Nullable<decimal> target { get; set; }
        public Nullable<int> cate_id { get; set; }
    
        public virtual category category { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<payment> payments { get; set; }
    }
}