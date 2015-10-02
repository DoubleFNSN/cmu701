#include <vector>
#include <set>
#include <map>
#include <string>
#include <math.h>
#include <iostream>

#include "evaluation.h"

using namespace std;

/* Type = 0 for neg, Type = 1 for pos*/
Evaluation::Evaluation(Model *model, Data *testData, int type) {
    Evaluation::type = type;
    Evaluation::testData = testData;
    Evaluation::model = model;
}

void Evaluation::evalModel() {
    int right = 0;
    int debug = 0;
    for (set<int> tempSet : Evaluation::testData->fileWords) {
        debug++;
        double posTotalScore = 0.0;
        double negTotalScore = 0.0;
        for (map<string, int>::iterator it =  Evaluation::model->posData->sentWord2IndexMap.begin();
                it != Evaluation::model->posData->sentWord2IndexMap.end(); it++) {
            int trainKey = it->second;
            string trainWord = it->first;
            if (Evaluation::testData->sentWord2IndexMap.count(trainWord)) {
                int testkey = Evaluation::testData->sentWord2IndexMap[trainWord];
                if (tempSet.find(testkey) != tempSet.end()) {
                    posTotalScore += log2(Evaluation::model->posIndex2ScoreMap[trainKey]);
                } else {
                    posTotalScore += log2((double)1 - Evaluation::model->posIndex2ScoreMap[trainKey]);
                }
            } else {
                posTotalScore += log2((double)1 - Evaluation::model->posIndex2ScoreMap[trainKey]);
            }
        }
        for (map<string, int>::iterator it =  Evaluation::model->negData->sentWord2IndexMap.begin();
                it != Evaluation::model->negData->sentWord2IndexMap.end(); it++) {
            int trainKey = it->second;
            string trainWord = it->first;
            if (Evaluation::testData->sentWord2IndexMap.count(trainWord)) {
                int testkey = Evaluation::testData->sentWord2IndexMap[trainWord];
                if (tempSet.find(testkey) != tempSet.end()) {
                    negTotalScore += log2(Evaluation::model->negIndex2ScoreMap[trainKey]);
                } else {
                    negTotalScore += log2((double)1 - Evaluation::model->negIndex2ScoreMap[trainKey]);
                }
            } else {
                negTotalScore += log2((double)1 - Evaluation::model->negIndex2ScoreMap[trainKey]);
            }
        }
        if (type == 0) {
            if (negTotalScore - posTotalScore >= 0) {
                right++;
            }
        } else {
            if (posTotalScore - negTotalScore >= 0) {
                right++;
            }
        }
    }
    Evaluation::precision = (double)right / Evaluation::testData->fileWords.size();

}
