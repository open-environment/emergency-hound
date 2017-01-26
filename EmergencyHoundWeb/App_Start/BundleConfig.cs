using System.Web;
using System.Web.Optimization;

namespace EmergencyHoundWeb
{
    public class BundleConfig
    {
        public static void RegisterBundles(BundleCollection bundles)
        {
            //****************** JAVASCRIPT ***********************************
            //****************** JAVASCRIPT ***********************************
            //default MSFT starter template
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include("~/Scripts/jquery-{version}.js"));
            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include("~/Scripts/jquery.validate*"));
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include("~/Scripts/modernizr-*"));
            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                "~/Scripts/bootstrap.js",
                "~/Scripts/respond.js"));

            //added by notebook UI template
            bundles.Add(new ScriptBundle("~/bundles/app").Include(
                "~/Scripts/app.js",
                "~/Scripts/app.plugin.js"));
            bundles.Add(new ScriptBundle("~/bundles/landing").Include("~/Scripts/landing.js"));
            bundles.Add(new ScriptBundle("~/bundles/appear").Include("~/Scripts/appear/jquery.appear.js"));
            bundles.Add(new ScriptBundle("~/bundles/smoothscroll").Include("~/Scripts/smoothscroll/smoothscroll.js"));

            //my further custom
            bundles.Add(new ScriptBundle("~/bundles/areyousure").Include("~/Scripts/areyousure/jquery.are-you-sure.js"));
            bundles.Add(new ScriptBundle("~/bundles/confirmdelete").Include("~/Scripts/confirm_delete.js"));
            bundles.Add(new ScriptBundle("~/bundles/croppic").Include("~/Scripts/croppic/croppic.js"));
            bundles.Add(new ScriptBundle("~/bundles/datepicker").Include("~/Scripts/bootstrap-datepicker/bootstrap-datepicker.js"));
            bundles.Add(new ScriptBundle("~/bundles/datetimepicker").Include("~/Scripts/datetimepicker/jquery.datetimepicker.js"));
            bundles.Add(new ScriptBundle("~/bundles/team").Include(
                "~/Scripts/team.js",
                "~/Scripts/jquery.layout.js"));


            //****************** CSS ***********************************
            //****************** CSS ***********************************
            bundles.Add(new StyleBundle("~/Content/css").Include(
                //MSFT default
                "~/Content/bootstrap.css",
                //notebook UI template
                "~/Scripts/bootstrap-datepicker/datepicker.css",
                "~/Scripts/datetimepicker/jquery.datetimepicker.css",
                "~/Content/animate.css",
                "~/Content/font-awesome.css",
                "~/Content/landing.css",
                "~/Content/app.css",
                //my custom
                "~/Content/app_custom.css"
                ));

            bundles.Add(new StyleBundle("~/Content/cssTeam").Include(
                "~/Content/team.css"
                ));

            bundles.Add(new StyleBundle("~/Content/cssCroppic").Include(
                "~/Scripts/croppic/croppic.css"
                ));

        }

    }
}
