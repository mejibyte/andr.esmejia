#include <chrono>
#include <iostream>
#include <limits>
#include <iomanip> // for std::put_time
#include <ctime> // for std::time_t


using std::cout;
using std::endl;

int main() {
  std::chrono::time_point now = std::chrono::system_clock::now();
  std::time_t now2 = std::chrono::system_clock::to_time_t(now);
  std::tm tmLocal = *std::localtime(&now2);
  std::tm tmUTC = *std::gmtime(&now2);
  cout << std::put_time(&tmLocal, "%c %Z") << endl;
  cout << std::put_time(&tmUTC, "%c %Z") << endl;

  return 0;
}
