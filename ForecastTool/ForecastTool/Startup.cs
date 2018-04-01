using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ForecastTool.Startup))]
namespace ForecastTool
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
