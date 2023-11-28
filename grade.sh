CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning...'


if [[ -f student-submission/ListExamples.java ]]
then
  echo 'ListExamples.java is found'
else
  echo 'ListExamples.java is not found'
  echo 'Score: 0'
fi

cp student-submission/ListExamples.java ./

javac -cp $CPATH *.java

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt


# The code will look like:

# FAILURES!!!
# Tests run: 4,  Failures: 2

# We check for "FAILURES!!!" and do a bit of parsing of the last line to get the count

FAIL=`grep -c FAILURES!!! junit-output.txt`

if [[ $FAIL -eq 0 ]]
then
  echo "-----------------------"
  echo "| All 4/4 tests passed |"
  echo "-----------------------"
else

  RESULT_LINE=`grep "Tests run:" junit-output.txt`
  COUNT=${RESULT_LINE:25:1}

  echo "JUnit output was:"
  cat junit-output.txt
  echo ""
  echo "-------------------"
  echo "| Score: $COUNT/4 |"
  echo "-------------------"
  echo ""
fi