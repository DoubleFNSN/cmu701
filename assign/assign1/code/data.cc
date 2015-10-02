#include <fstream>
#include <iostream>
#include <string>
#include <dirent.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <boost/algorithm/string/split.hpp>
#include <boost/algorithm/string/classification.hpp>

#include "data.h"

using namespace std;
using namespace boost::algorithm;

const static string fileRoot = "/Users/toothacher17/Documents/cmu/15fall/10701/cmu701/assign/assign1/code/data/files/";
const static string sentRoot = "/Users/toothacher17/Documents/cmu/15fall/10701/cmu701/assign/assign1/code/data/sent/";


/* Initilization, read file holder path and sentiment word path*/
Data::Data(string fileFolder, string sentWords) {
    Data::sentWordsPath = sentRoot + sentWords;
    Data::fileFolderPath = fileRoot + fileFolder;

    DIR *dir;
    struct dirent *ent;
    const char *fileFolderPathTemp = Data::fileFolderPath.c_str();

    if ((dir = opendir(fileFolderPathTemp)) != NULL) {
        while ((ent = readdir(dir)) != NULL) {
            string tempFileName(ent->d_name);
            if (tempFileName.length() > 2) {
                Data::fileNames.push_back(fileFolderPath + tempFileName);
            }
        }
        closedir(dir);
    } else {
        cout << "could not open folder" << endl;
    }

}

/* Read sentiment words and store in sent words related map*/
void Data::loadSent() {
    string readline;
    int index = 0;
    ifstream myfile (Data::sentWordsPath);
    if (myfile.is_open()) {
        while (getline(myfile, readline)) {
            if (!Data::sentWord2IndexMap.count(readline)) {
                Data::sentWord2IndexMap[readline] = index;
                Data::sentIndex2WordMap[index] = readline;
                index++;
            }

        }
    }
    myfile.close();
}

/* Read trainning files from folder */
/* Type 0, only keeps sentiwords, Type 1, keeps all words*/
void Data::loadFile(int type) {
    string readline;

    for (string filename : Data::fileNames) {
        ifstream myfile (filename);
        set<int> tempFileIndex;
        vector<string> tempWords;
        if (myfile.is_open()) {
            // store all the sentiwords for each doc
            if (type == 0) {
                while (getline(myfile, readline)) {
                    Data::tokenizeLine(readline, tempWords);
                    for (string word : tempWords) {
                        if (Data::sentWord2IndexMap.count(word)) {
                            tempFileIndex.insert(Data::sentWord2IndexMap[word]);
                        }
                    }
                }
            }
        } else {
            cout << "open file error! " << endl;
        }
        myfile.close();
        Data::fileWords.push_back(tempFileIndex);
    }
}


/* Parse doc, tokenize doc to vector string*/
void Data::tokenizeLine(string line, vector<string> &result) {
    split(result, line, is_any_of(" "));
}

