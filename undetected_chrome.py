import undetected_chromedriver
from RPA.core.webdriver import DRIVER_ROOT


class Chrome(undetected_chromedriver.Chrome):

    def __init__(self, *args, **kwargs):
        kwargs["driver_executable_path"] = kwargs.pop("executable_path", None)
        super().__init__(*args, **kwargs)


undetected_chromedriver.Patcher.data_path = str(
    DRIVER_ROOT / "undetected_chromedriver"
)
