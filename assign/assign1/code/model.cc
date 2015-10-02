#include <vector>
#include <map>
#include <string>
#include <iostream>

#include "model.h"

using namespace std;

/* Constructor */
Model::Model(Data *posData, Data *negData) {
    Model::posData = posData;
    Model::negData = negData;
}

void Model::trainModel() {
    Model::countData(0);
    Model::countData(1);
    cout << "training model" << endl;
    int debug = 0;
    for (map<int,int>::iterator posIt = Model::posIndex2CountMap.begin();
            posIt != Model::posIndex2CountMap.end(); posIt++) {
        debug++;
        int posValue = posIt->second;
        double posScore = 0.0;

        posScore = ((double)posValue + 0.1) / ((double)800 + 0.1);
        Model::posIndex2ScoreMap[posIt->first] = posScore;
    }

    for (map<int,int>::iterator negIt = Model::negIndex2CountMap.begin();
            negIt != Model::negIndex2CountMap.end(); negIt++) {
        int negValue = negIt->second;
        double negScore = 0.0;

        negScore = ((double)negValue + 0.1) / ((double)800 + 0.1);
        Model::negIndex2ScoreMap[negIt->first] = negScore;
    }
}

void Model::countData(int type) {
    // neg label
    if (type == 0)  {
        for (set<int> negSet : Model::negData->fileWords) {
            for (int negTemp : negSet) {
                if (!Model::negIndex2CountMap.count(negTemp)) Model::negIndex2CountMap[negTemp] = 0;
                else Model::negIndex2CountMap[negTemp]++;
            }
        }
    } else {
        for (set<int> posSet : Model::posData->fileWords) {
            for (int posTemp : posSet) {
                if (!Model::posIndex2CountMap.count(posTemp)) Model::posIndex2CountMap[posTemp] = 0;
                else Model::posIndex2CountMap[posTemp]++;
            }
        }
    }
}


