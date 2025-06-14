# Read the requirements.txt file
print("importing libraries from requirements.txt")
requirements <- readLines("requirements.txt")

# Load each library listed in requirements.txt
for (lib in requirements) {
  library(lib, character.only = TRUE)
}
