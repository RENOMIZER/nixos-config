import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar"
import NotificationPopups from "./widget/NotificationPopups"
import Applauncher from "./widget/Applauncher"
import Shutdown from "./widget/Shutdown"
import OSD from "./widget/OSD"

App.start({
    css: style,
    instanceName: "main",
    requestHandler(request, res) {
        switch (request) {
            case "applauncher":
                if (App.get_window("launcher") === null) {
                    Applauncher()
                    console.log("open launcher")
                }
                break;
            case "shutdown":
                if (App.get_window("shutdown") === null) {
                    Shutdown()
                    console.log("open shutdown menu")
                }
                break;
        }
    },
    main: () => App.get_monitors().map(id => {Bar(id), OSD(id), NotificationPopups(id)})
})

