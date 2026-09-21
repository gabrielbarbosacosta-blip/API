FROM ghcr.io/home-assistant/home-assistant:stable

ARG MAP_EXTRACTOR_VERSION=v3.0.0-alpha-24

RUN python3 - <<'PY'
import io
import os
import urllib.request
import zipfile

version = os.environ.get("MAP_EXTRACTOR_VERSION", "v3.0.0-alpha-24")
url = f"https://github.com/PiotrMachowski/Home-Assistant-custom-components-Xiaomi-Cloud-Map-Extractor/releases/download/{version}/xiaomi_cloud_map_extractor.zip"
target = "/opt/xiaomi_cloud_map_extractor"
os.makedirs(target, exist_ok=True)
with urllib.request.urlopen(url, timeout=60) as response:
    data = response.read()
with zipfile.ZipFile(io.BytesIO(data)) as archive:
    archive.extractall(target)
PY

COPY entrypoint.sh /entrypoint-controls.sh
COPY scripts.yaml /tmp/scripts.yaml
COPY alexa_robot.yaml /tmp/alexa_robot.yaml
COPY h50_dashboard.yaml /tmp/h50_dashboard.yaml
RUN chmod +x /entrypoint-controls.sh
ENTRYPOINT ["/entrypoint-controls.sh"]
