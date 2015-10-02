#include <iostream>
#include <string>
#include <vector>

#include "evaluation.h"

using namespace std;

int main() {
    string sentPath = string("sent.txt");

    /* Preprocess data*/
    string negTrainPath = string("neg_train/");
    Data negTrainData(negTrainPath, sentPath);
    negTrainData.loadSent();
    negTrainData.loadFile(0);

    string posTrainPath = string("pos_train/");
    Data posTrainData(posTrainPath, sentPath);
    posTrainData.loadSent();
    posTrainData.loadFile(0);

    Data negTestData("neg_test/", sentPath);
    negTestData.loadSent();
    negTestData.loadFile(0);

    Data posTestData("pos_test/", sentPath);
    posTestData.loadSent();
    posTestData.loadFile(0);

    /* Train the model */
    Model model(&posTrainData, &negTrainData);
    model.trainModel();

    /* Evaluate the model */
    Evaluation negEval(&model, &negTestData, 0);
    Evaluation posEval(&model, &posTestData, 1);
    negEval.evalModel();
    posEval.evalModel();
    cout << "neg result !" << negEval.precision << endl;
    cout << "pos result !" << posEval.precision << endl;
}




