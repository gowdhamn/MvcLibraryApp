using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MvcLibraryApp.Models
{
    public class LibraryModel
    {
    }

    public class AddBookModel
    {
        [Required(ErrorMessage = "Book Name Required")]
        public string BookName { get; set; }

        [Required(ErrorMessage = "Release Date Required")]
        [Display(Name = "Release Date")]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:dd/MMM/yyyy}")]
        public DateTime ReleaseDate { get; set; }

        [Required(ErrorMessage = "Author Required")]
        public string Author { get; set; }

        [Required(ErrorMessage = "Genre Required")]
        public string Genre { get; set; }

        [Required(ErrorMessage = "Price Required")]
        public decimal Price { get; set; }

    }

    public class BookList
    {
        public int Id { get; set; }

        public string BookName { get; set; }

        public DateTime ReleaseDate { get; set; }

        public string Author { get; set; }

        public string Genre { get; set; }

        public decimal Price { get; set; }

    }

    public class EditBookModel
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Book Name Required")]
        public string BookName { get; set; }

        [Required(ErrorMessage = "Release Date Required")]
        public DateTime ReleaseDate { get; set; }

        [Required(ErrorMessage = "Author Required")]
        public string Author { get; set; }

        [Required(ErrorMessage = "Genre Required")]
        public string Genre { get; set; }

        [Required(ErrorMessage = "Price Required")]
        public decimal Price { get; set; }

    }

    public class BookListModel
    {
        public int Id { get; set; }

        public string BookName { get; set; }

        public DateTime ReleaseDate { get; set; }

        public string Author { get; set; }

        public string Genre { get; set; }

        public decimal Price { get; set; }

    }

}