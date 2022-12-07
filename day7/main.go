package main

import (
	"bufio"
	"fmt"
	"os"
)

type File struct {
	name string
	size int
}

type Directory struct {
	name        string
	files       []File
	directories []Directory
	parent      *Directory
}

func main() {
	readFile, err := os.Open("data")
	if err != nil {
		panic(err)
	}

	fileSystem := Directory{
		name:        "/",
		files:       []File{},
		directories: []Directory{},
	}
	currentWorkingDirectory := &fileSystem

	fileScanner := bufio.NewScanner(readFile)
	for fileScanner.Scan() {
		fmt.Printf("cwd: %s\n", currentWorkingDirectory.name)
		row := fileScanner.Text()

		if row[0] == '$' {

			if row[2:4] == "cd" {

				if row[5] == '/' {
					currentWorkingDirectory = &fileSystem
					continue
				} else if row[5:] == ".." {
					currentWorkingDirectory = currentWorkingDirectory.parent
				} else {
					for _, directory := range fileSystem.directories {
						if directory.name == row[5:] {
							currentWorkingDirectory = &directory
							break
						}
					}
				}
			}
		} else {
			if row[0:3] == "dir" {
				newDir := Directory{
					name:        "a",
					files:       nil,
					directories: nil,
					parent:      currentWorkingDirectory,
				}
				currentWorkingDirectory.directories = append(
					currentWorkingDirectory.directories,
					newDir,
				)
			}
		}
	}

}
