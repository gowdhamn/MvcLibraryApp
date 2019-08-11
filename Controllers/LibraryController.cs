using MvcLibraryApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcLibraryApp.Services;
using System.Data;
using System.Net;

namespace MvcLibraryApp.Controllers
{
    public class LibraryController : Controller
    {
        LibraryService libraryService;
        public LibraryController()
        {
            libraryService = new LibraryService();
        }

        // GET: Library
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AddBook()
        {
            return View();
        }

        [HttpPost]
        public ActionResult SaveBook(AddBookModel addBookModel)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    DataTable dt = libraryService.AddBook(addBookModel);
                    if (dt.Rows[0][0].ToString() == "Y")
                    {
                        TempData["Status"] = "Y";
                        return RedirectToAction("AddBook");
                    }
                    else
                    {
                        TempData["Status"] = "N";
                        return View("AddBook");
                    }
                }
                catch (Exception ex)
                {
                    Response.StatusCode = (int)HttpStatusCode.BadRequest;
                    ModelState.AddModelError("", ex.Message);
                    TempData["Fail"] = "Fail";
                    return View("AddBook");
                }
            }
            else
            {
                TempData["ModelsError"] = "Error";
                return RedirectToAction("AddBook");
            }
        }//.End SaveBook

        public ActionResult BookList()
        {
            DataTable dt = libraryService.BookList(null);
            List<BookListModel> bookListModels = CommonService.ConvertToList<BookListModel>(dt);
            return View(bookListModels);
        }//.BookList


        public ActionResult RemoveBook(int BookId)
        {
            DataTable dt = libraryService.RemoveBook(BookId);
            return RedirectToAction("BookList");
        }

        [HttpGet]
        public ActionResult EditBook(int Id)
        {
            DataTable dt = libraryService.BookList(Id);
            List<EditBookModel> _editBookModel = CommonService.ConvertToList<EditBookModel>(dt);
            EditBookModel editBookModel = _editBookModel.Find(uid => uid.Id == Id);
            return View(editBookModel);
        }

        [HttpPost]
        public ActionResult UpdateBook(EditBookModel editBookModel)
        {
            if (ModelState.IsValid)
            {
                DataTable dt = libraryService.UpdateBook(editBookModel);
                if (dt.Rows[0][0].ToString() == "Y")
                {
                    TempData["Status"] = "Y";
                    return RedirectToAction("BookList");
                }
                else
                {
                    TempData["Status"] = "N";
                    return RedirectToAction("BookList");
                }
            }
            else
            {
                TempData["ModelsError"] = "Error";
                return RedirectToAction("BookList");
            }
        }//.End Update Book

    }
}