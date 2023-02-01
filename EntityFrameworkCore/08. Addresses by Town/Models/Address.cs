﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SoftUni.Models
{
    public partial class Address
    {
        public Address()
        {
            Employees = new HashSet<Employee>();
        }

        [Key]
        [Column("AddressID")]
        public int AddressId { get; set; }
        [Required]
        [StringLength(100)]
        public string AddressText { get; set; }
        [Column("TownID")]
        public int? TownId { get; set; }

        [ForeignKey(nameof(TownId))]
        [InverseProperty(nameof(Models.Town.Addresses))]
        public virtual Town Town { get; set; }
        [InverseProperty("Address")]
        public virtual ICollection<Employee> Employees { get; set; }
    }
}
