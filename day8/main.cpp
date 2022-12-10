#include <iostream>
#include <fstream>
#include <cstring>

template<int SIZE>
class Trees {
    int data[SIZE][SIZE];
public:
    Trees() {

        {  // Read file data into class.
            int rowIndex = 0;
            std::string row;
            std::ifstream file("data");

            while (getline(file, row)) {
                for (int i = 0; i < SIZE; ++i)
                    this->data[i][rowIndex] = row[i] - 48;

                rowIndex++;
            }
        }
    }

    void display() {
        for (int y = 0; y < SIZE; ++y) {
            for (int x = 0; x < SIZE; ++x) {
                printf("%d  ", data[x][y]);
            }
            printf("\n");
        }
    }

    bool isVisible(int x, int y) {
        return isVisibleLeft(x, y)
               || isVisibleRight(x, y)
               || isVisibleTop(x, y)
               || isVisibleBottom(x, y);
    }

    bool isVisibleLeft(int x, int y) {
        int treeSize = this->data[x][y];

        for (int x2 = x - 1; x2 >= 0; --x2) {
            int otherTreeSize = this->data[x2][y];

            if (otherTreeSize >= treeSize) {
                return false;
            }
        }

        return true;
    }

    bool isVisibleRight(int x, int y) {
        int treeSize = this->data[x][y];

        for (int x2 = x + 1; x2 < SIZE; ++x2) {
            int otherTreeSize = this->data[x2][y];
            if (otherTreeSize >= treeSize) {
                return false;
            }
        }

        return true;
    }

    bool isVisibleTop(int x, int y) {
        int treeSize = this->data[x][y];

        for (int y2 = y - 1; y2 >= 0; --y2) {
            int otherTreeSize = this->data[x][y2];
            if (otherTreeSize >= treeSize) {
                return false;
            }
        }

        return true;
    }

    bool isVisibleBottom(int x, int y) {
        int treeSize = this->data[x][y];

        for (int y2 = y + 1; y2 < SIZE; ++y2) {
            int otherTreeSize = this->data[x][y2];
            if (otherTreeSize >= treeSize) {
                return false;
            }
        }

        return true;
    }


    int getAmountVisible() {
        int total = (SIZE * 4) - 4; // all edges are visible.

        // Iter all non-edge trees and get if visible.
        for (int x = 1; x < SIZE - 1; ++x) {
            for (int y = 1; y < SIZE - 1; ++y) {
                if (this->isVisible(x, y)) {
                    total++;
                }
            }
        }

        return total;
    }

    void displayVisible() {
        auto reset = "\x1B[0m";
        auto green = "\x1B[32m";
        auto red = "\x1B[31m";

        for (int y = 0; y < SIZE; ++y) {
            for (int x = 0; x < SIZE; ++x) {
                if (this->isVisible(x, y)) {
                    std::cout << green << data[x][y] << " ";
                } else {
                    std::cout << red << data[x][y] << " ";
                }
            }
            std::cout << reset << std::endl;
        }
    }
};

int main() {
    auto trees = new Trees<99>();

    trees->displayVisible();
    printf("Part one: %d\n", trees->getAmountVisible());

    return 0;
}