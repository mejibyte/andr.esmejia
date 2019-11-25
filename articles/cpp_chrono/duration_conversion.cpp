#include <iostream>
#include <limits>
#include <chrono>

void convert(long long millis) {
  std::chrono::milliseconds ms(millis);

  // Convert milliseconds to microseconds.
  // No cast necessary because there's no risk of data loss -- we are just multiplying
  // ms by 1000 to get μs, and multiplication doesn't lose data.
  // (There could be data loss in case of multiplication overflow, though).
  std::chrono::microseconds us = ms;

  // Convert milliseconds to seconds.
  // Since std::chrono uses integer types internally by default, there is risk of data
  // loss here: 123999 milliseconds is 123.999 seconds, but we have to convert that to
  // an integer.

  // 123999 milliseconds -> 123 milliseconds
  std::chrono::seconds s_floor = std::chrono::floor<std::chrono::seconds>(ms);

  // 123999 milliseconds -> 124 milliseconds
  std::chrono::seconds s_ceil = std::chrono::ceil<std::chrono::seconds>(ms);

  // Rounds to closest. In case of ties, rounds to closest even number.
  // 123999 milliseconds -> 124 milliseconds
  // 123001 milliseconds -> 123 milliseconds
  // 123500 milliseconds -> 124 milliseconds
  // 124500 milliseconds -> 124 milliseconds
  std::chrono::seconds s_round = std::chrono::round<std::chrono::seconds>(ms);

  // Not very clear how it behaves, but it seems to have the same behavior as
  // doing a static_cast<int>(double). That is: behaves like floor for positive values
  // and like ceil for negative values.
  // My advice is to NEVER use this, and use floor, ceil or round explicitly. It
  // is a lot clearer and makes you think better about your code!
  std::chrono::seconds s_cast = std::chrono::duration_cast<std::chrono::seconds>(ms);

  std::cout << "milliseconds: " << ms.count() << std::endl;
  std::cout << "microseconds: " << us.count() << std::endl;
  std::cout << "seconds duration_cast: " << s_cast.count() << std::endl;
  std::cout << "seconds floor: " << s_floor.count() << std::endl;
  std::cout << "seconds ceil: " << s_ceil.count() << std::endl;
  std::cout << "seconds round: " << s_round.count() << std::endl;
  std::cout << std::endl;
}

int main() {
  convert(123001);
  convert(-123001);

  convert(123500);
  convert(-123500);

  convert(234500);
  convert(-234500);

  // Will overflow when converting to microseconds.
  convert(std::numeric_limits<long long>::max());

  return 0;
}
