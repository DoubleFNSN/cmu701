#include <vector>
#include <string>
#include <map>

#include "model.h"

class Evaluation {
    public:
        /* Type = 0 for neg, Type = 1 for pos*/
        Evaluation(Model *model, Data *testData, int type);

        int type;
        Data *testData;
        Model *model;
        double precision;

        void evalModel();
};
