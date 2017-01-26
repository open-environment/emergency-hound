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

        public static string ActivePageGroup(this HtmlHelper helper, string controller)
        {
            string classValue = "";

            string currentController = helper.ViewContext.Controller.ValueProvider.GetValue("controller").RawValue.ToString();
            //string currentArea = helper.ViewContext.Controller.ValueProvider.GetValue("area").RawValue.ToString();
            if (currentController == "Certification") currentController = "Resource";
            if (currentController == "Jurisdiction") currentController = "Admin";
            if (currentController == controller)
            {
                classValue = "active";
            }

            return classValue;
        }

    }

}
