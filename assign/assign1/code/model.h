#include <vector>
#include <map>
#include <set>

#include "data.h"

using namespace std;

/* Model class is used to train and test data */
class Model {
    public:
        Model(Data *posData, Data *negData);

        /* Parameters*/
        int type;
        Data *posData, *negData;
        map<int, int> posIndex2CountMap;
        map<int, int> negIndex2CountMap;
        map<int, double> posIndex2ScoreMap;
        map<int, double> negIndex2ScoreMap;


        /* Train model */
        void trainModel();

    private:
        /* Transfer data to Index2Count map */
        /* type = 0 neg, type = 1 pos*/
        void countData(int type);

};


