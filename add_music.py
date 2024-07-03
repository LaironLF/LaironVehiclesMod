import os
import json

resultFile: str = "music/configmusic.json"
musicPath: str = "../../unpacked/music"

def main():
    fils: list[str] = os.listdir(musicPath)
    files: list[str] = list()

    for file in fils:
        musicParam = {"title": file[:-4], "path": "/music/" + file}
        files.append(musicParam)
    jsonFile = {"music": files}
    x = json.dumps(jsonFile, indent=2)
    file = open(resultFile, "w")
    # file.
    file.write(x)
    file.close()
    print(x)


if __name__ == '__main__':
    main()