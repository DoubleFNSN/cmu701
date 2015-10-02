#include <vector>
#include <string>
#include <map>
#include <set>

using namespace std;

/* Data class is used to preprocess file data*/
class Data {
    public:
        Data(string fileFolder, string sentWords);

        /* store words from files */
        string sentWordsPath;
        string fileFolderPath;
        vector<string> fileNames;
        vector<set<int>> fileWords;
        map<string, int> sentWord2IndexMap;
        map<int,string> sentIndex2WordMap;

        /* related functions */
        // load sentiment words
        void loadSent();
        // load file words, type: 0 keep only sentiwords; 1 all words
        void loadFile(int type);

    private:
        void tokenizeLine(string line, vector<string> &result);

};


