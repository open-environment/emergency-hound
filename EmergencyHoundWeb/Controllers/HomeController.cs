using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EmergencyHoundWeb.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View("Index", "_LayoutPub");
        }

        public ActionResult About()
        {
            return View("About", "_LayoutPub");
        }

        public ActionResult Features()
        {
            return View("Features", "_LayoutPub");
        }

        public ActionResult MailingList()
        {
            return View("MailingList", "_LayoutPub");
        }

    }
}