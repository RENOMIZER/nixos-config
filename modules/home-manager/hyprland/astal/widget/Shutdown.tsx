import { App, Astal, Gdk } from "astal/gtk3"
import { exec } from "astal/process"
import { Variable } from "astal"

const MAX_ITEMS = 8

function hide() {
    App.get_window("shutdown")!.close()
}

function shutdown() {
    exec("shutdown now")
}

function reboot() {
    exec("reboot")
}

export default function Shutdown() {
    const width = Variable(1000)

    const text = Variable("")

    return <window
        name="shutdown"
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
        exclusivity={Astal.Exclusivity.IGNORE}
        keymode={Astal.Keymode.ON_DEMAND}
        application={App}
        onShow={(self) => {
            text.set("")
            width.set(self.get_current_monitor().workarea.width)
        }}
        onKeyPressEvent={function (self, event: Gdk.Event) {
            if (event.get_keyval()[1] === Gdk.KEY_Escape)
                hide()
        }}>
        <box>
            <eventbox widthRequest={width(w => w / 2)} expand onClick={hide} />
            <box hexpand={false} vertical>
                <eventbox expand onClick={hide} />
                <box className="Shutdown">
                    <button tooltipText={"Выключение"} onClick={shutdown} css={"margin-right: .8rem"}>
                        <icon icon="system-shutdown"/>
                    </button>
                    <button tooltipText={"Перезагрузка"} onClick={reboot}>
                        <icon icon="system-reboot"/>
                    </button>
                </box>
                <eventbox expand onClick={hide} />
            </box>
            <eventbox widthRequest={width(w => w / 2)} expand onClick={hide} />
        </box>
    </window>
}