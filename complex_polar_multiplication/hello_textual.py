from textual.app import App, ComposeResult
from textual.widgets import Button, Footer, Log
from textual.theme import Theme
from textual import work
from textual.containers import Container, Horizontal, Vertical, VerticalScroll

import asyncio

flexoki_light_theme = Theme(
    name="flexoki_light",
    primary="#100F0F",
    secondary="#D14D41",
    foreground="#100F0F",
    background="#FFFCF0",
    surface="#FFFCF0",
    success="#879A39",
    accent="#4385BE",
    warning="#D14D41",
)


class ScratchApp(App):
    def on_mount(self) -> None:
        self.register_theme(flexoki_light_theme)
        self.theme = "flexoki_light"

    def compose(self) -> ComposeResult:
        yield Horizontal(
            Vertical(Button("Launch Processing Sketch", id="launch")),
            Vertical(Log(id="output")),
        )
        yield Footer()

    def on_button_pressed(self, event: Button.Pressed) -> None:
        if event.button.id == "launch":
            self.launch_processing()

    def launch_processing(self) -> None:
        self.monitor_processing()

    @work()
    async def monitor_processing(self) -> None:
        output_widget = self.query_one("#output", Log)

        process = await asyncio.create_subprocess_exec(
            "processing-java",
            "--sketch=/home/scossar/sketchbook/complex_polar_multiplication/",
            "--run",
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )

        while True:
            line = await process.stdout.readline()
            if not line:
                break
            output_widget.write_line(line.decode().strip())

        await process.wait()


if __name__ == "__main__":
    app = ScratchApp()
    reply = app.run()
