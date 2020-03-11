#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_map>

using namespace std;


 class Solution {
 public:
  /** block comment **/
  vector<vector<int>> threeSum(vector<int>& nums) {
    vector<vector<int>> result;
    std::unordered_map<int,int> posMap;
    unordered_map<int,int> negMap;
    int zeroCount = 0;
    int x = 0 + zeroCount;

    // Segregate positive and negative in separate maps
    for (auto &n : nums) {
      if (n == 0) {
        zeroCount++;
      } else if (n > 0) {
        posMap[n]++;
      } else
        negMap[n]++;
    }
    if (zeroCount >= 3)
      result.push_back({0,0,0});

    for (auto &n: posMap) {
      // If zero found in the array then just search for mirror
      // negative element
      if (zeroCount) {
        if (negMap.count(-n.first))
          result.push_back({-n.first,0,n.first});
      }
      for (auto &m : negMap) {
        // If number has frequency of more than 2
        if (m.second >= 2) {
          int sum = n.first + 2*(m.first);
          if (sum == 0)
            result.push_back({m.first,m.first,n.first});
        }

        // If number has frequency of more than 2
        if (n.second >= 2) {
          int sum = 2*n.first + m.first;
          if (sum == 0) {
            cout << "dup result added" << endl;
            result.push_back({m.first,n.first,n.first});
          }
        }

        // In order to avoid duplicates follow one consistent approach
        // we will cross search only if remaining part of sum if is greater
        // the current sum. This simply helps to avoid the duplicates
        int remSum = 0 - (n.first + m.first);
        if (remSum > n.first) {
          if (posMap.count(remSum)) {
            result.push_back({m.first,n.first,remSum});
          }
        }
        if (remSum > m.first) {
          if (negMap.count(remSum)) {
            result.push_back({m.first,remSum,n.first});
          }
        }
      }
    }

    return result;
  }
};

Solution a();

a.threeSum();


int main() {
  // Create and open a text file
  ofstream MyFile("filename.txt");

  // Write to the file
  MyFile << "Files can be tricky, but it is fun enough!";

  // Close the file
  MyFile.close();
}

