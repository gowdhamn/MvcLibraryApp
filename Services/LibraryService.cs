using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MvcLibraryApp.Services;
using System.Data;
using System.Data.SqlClient;
using MvcLibraryApp.Models;

namespace MvcLibraryApp.Services
{
    public class LibraryService
    {
        DBConnection dBConnection;

        public LibraryService()
        {
            dBConnection = new DBConnection();
        }

        public DataTable AddBook(AddBookModel addBookModel)
        {
            SqlParameter[] sqlParameter = new SqlParameter[5];

            sqlParameter[0] = new SqlParameter("@BookName", SqlDbType.VarChar);
            sqlParameter[0].Value = Convert.ToString(addBookModel.BookName);

            sqlParameter[1] = new SqlParameter("@ReleaseDate", SqlDbType.DateTime);
            sqlParameter[1].Value = addBookModel.ReleaseDate;

            sqlParameter[2] = new SqlParameter("@Author", SqlDbType.VarChar);
            sqlParameter[2].Value = Convert.ToString(addBookModel.Author);


            sqlParameter[3] = new SqlParameter("@Genre", SqlDbType.VarChar);
            sqlParameter[3].Value = Convert.ToString(addBookModel.Genre);

            sqlParameter[4] = new SqlParameter("@Price", SqlDbType.Decimal);
            sqlParameter[4].Value = Convert.ToDecimal(addBookModel.Price);

            return dBConnection.executeStoredProcedure("AddBookDetail", sqlParameter);
        }

        public DataTable BookList(int? Id)
        {
            SqlParameter[] sqlParameter = new SqlParameter[1];

            sqlParameter[0] = new SqlParameter("@Id", SqlDbType.Int);
            if (Id.HasValue)
            {
                sqlParameter[0].Value = Convert.ToInt32(Id.Value.ToString());
            }
            else
            {
                sqlParameter[0].Value = DBNull.Value;
            }

            return dBConnection.executeStoredProcedure("BookList", sqlParameter);
        }

        public DataTable UpdateBook(EditBookModel editBookModel)
        {
            SqlParameter[] sqlParameter = new SqlParameter[6];

            sqlParameter[0] = new SqlParameter("@BookName", SqlDbType.VarChar);
            sqlParameter[0].Value = Convert.ToString(editBookModel.BookName);

            sqlParameter[1] = new SqlParameter("@ReleaseDate", SqlDbType.DateTime);
            sqlParameter[1].Value = editBookModel.ReleaseDate;

            sqlParameter[2] = new SqlParameter("@Author", SqlDbType.VarChar);
            sqlParameter[2].Value = Convert.ToString(editBookModel.Author);


            sqlParameter[3] = new SqlParameter("@Genre", SqlDbType.VarChar);
            sqlParameter[3].Value = Convert.ToString(editBookModel.Genre);

            sqlParameter[4] = new SqlParameter("@Price", SqlDbType.Decimal);
            sqlParameter[4].Value = Convert.ToDecimal(editBookModel.Price);

            sqlParameter[5] = new SqlParameter("@Id", SqlDbType.Int);
            sqlParameter[5].Value = Convert.ToInt32(editBookModel.Id);

            return dBConnection.executeStoredProcedure("EditBookDetail", sqlParameter);
        }

        public DataTable RemoveBook(int id)
        {
            SqlParameter[] sqlParameter = new SqlParameter[1];

            sqlParameter[0] = new SqlParameter("@Id", SqlDbType.Int);
            sqlParameter[0].Value = Convert.ToInt32(id);

            return dBConnection.executeStoredProcedure("RemoveDetail", sqlParameter);
        }

    }
}