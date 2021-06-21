using System.Linq;
using System.Web.Mvc;

namespace EmergencyHoundWeb.HtmlHelpers
{
    public static class HtmlHelperExtensions
    {
        public static string ActivePage(this HtmlHelper helper, string controller, string action)
        {
            string classValue = "";

            string currentController = helper.ViewContext.Controller.ValueProvider.GetValue("controller").RawValue.ToString();
            string currentAction = helper.ViewContext.Controller.ValueProvider.GetValue("action").RawValue.ToString();
            if (currentController == controller && currentAction == action)
                classValue = "active";
            else
                classValue = "";

            return classValue;
        }

        public static string NewActivePage(this HtmlHelper helper, string controller, string actions)
        {
            string currentController = helper.ViewContext.RouteData.Values["Controller"].ToString();
            string currentAction = helper.ViewContext.RouteData.Values["Action"].ToString();
            string[] acceptedActions = actions.Trim().Split(',').Distinct().ToArray();
            if (currentController == controller && acceptedActions.Contains(currentAction))
                return "active open";
            else
                return "";
        }

        public static string ActivePageGroup(this HtmlHelper helper, string controller)
        {
            string classValue = "";
            string currentController = helper.ViewContext.RouteData.Values["Controller"].ToString();
            if (currentController == "Certification") currentController = "Resource";
            else if (currentController == "Jurisdiction") currentController = "Admin";
            else if (currentController == "Shared") currentController = "Admin";

            if (currentController == controller)
                classValue = "active";

            return classValue;
        }

    }

}
