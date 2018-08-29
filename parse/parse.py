from bs4 import BeautifulSoup
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


with open("uscan_log") as fp:
    soup = BeautifulSoup(fp, "html.parser")

for dehs in soup.find_all('dehs'):
    if dehs.package:
        package = dehs.package.text
        logger.info(package)
        if dehs.warnings:
            warnings = dehs.warnings.text.strip()
            logger.warning(f"{package} failed: {warnings}")
        else:
            debian_version = dehs.find('debian-uversion').text
            upstream_version = dehs.find('upstream-version').text
            status = dehs.find('status').text.strip()
            if status == 'newer package available':
                logger.info(f"{package} new version! was {debian_version} now {upstream_version}")

    else:
        if dehs.warnings:
            warnings = dehs.warnings.text.strip()
            logger.warning(warnings)