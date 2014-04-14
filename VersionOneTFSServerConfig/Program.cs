using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace VersionOneTFSServerConfig
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main(string[] args)
        {
            Dictionary<string, string[]> supportedDlls = new Dictionary<string, string[]>();
            supportedDlls.Add(
                "Microsoft.TeamFoundation.Client",
                new string[]{ 
                                    "Microsoft.TeamFoundation.Client, Version=12.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", 
                                    "Microsoft.TeamFoundation.Client, Version=11.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", 
                                    "Microsoft.TeamFoundation.Client, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"}
            );
            OpenAgile.ReferenceLoader.ResolveDlls(AppDomain.CurrentDomain, supportedDlls);
            foreach (string arg in args)
            {
                if (arg == "/unsubscribe")
                {
                    try
                    {
                        ConfigForm.TFSUnsubscribe();
                    }
                    catch (Exception e)
                    {
                        MessageBox.Show(e.Message, "Error unsubscribing from TFS events, you should manually unsubscribe");
                    }
                    return;
                }

                if (arg == "/install")
                {
                    try
                    {
                        ConfigForm.Install();
                    }
                    catch (Exception e)
                    {
                        MessageBox.Show(e.Message, "Error setting .net version");
                    }
                }
            }

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new ConfigForm());
        }
    }
}