import 'models/models.dart';

final Quiz technicalAnalysisQuiz = Quiz(
  id: '1',
  title: 'Technical Analysis Quiz',
  questions: [
    Question(
      id: '1',
      questionText: 'What kind of chart is this??',
      imageUrl: 'assets/images/line-780x545.png',
      answers: [
        Answer(text: 'Line Chart', isCorrect: true),
        Answer(text: ' Bar Chart', isCorrect: false),
        Answer(text: ' Candlestick Chart', isCorrect: false),
      ],
      correctAnswer: 'Line Chart',
      explanation:
          '📊 This is a Line Chart, which shows data points connected by straight line segments.',
    ),
    Question(
      id: '2',
      questionText: 'What indicator do you see on the chart?',
      imageUrl: 'assets/images/ma-780x545.png',
      answers: [
        Answer(text: 'Trendline', isCorrect: false),
        Answer(text: 'Stochastic', isCorrect: false),
        Answer(text: 'Moving Average', isCorrect: true),
      ],
      correctAnswer: 'Moving Average',
      explanation:
          '📈 This is a Moving Average, which is a trend-following indicator that shows the average price of a security over a set period of time. It helps smooth out price fluctuations! 🚀',
    ),
    Question(
      id: '3',
      questionText:
          'There is a 100 SMA and 100 EMA on the chart. Which one is the EMA?',
      imageUrl: 'assets/images/ema-vs-sma-780x545.png',
      answers: [
        Answer(text: 'Red Moving Average', isCorrect: true),
        Answer(text: 'Blue Moving Average', isCorrect: false),
        Answer(text: 'Green Moving Average', isCorrect: false),
      ],
      correctAnswer: 'Red Moving Average',
      explanation:
          '🔴🔵 The exponential moving average (EMA) is more "sensitive" than the simple moving average (SMA), so its line will be less smooth. Notice how the blue line is smoother than the red line. The blue line is the 100 SMA, while the red line is the 100 EMA. EMA reacts faster to recent price changes! ⚡',
    ),
    Question(
      id: '4',
      questionText: 'Which line would you consider as a support level?',
      imageUrl: 'assets/images/support-and-resistance-example-780x545.png',
      answers: [
        Answer(text: 'Red Line', isCorrect: false),
        Answer(text: 'Black Line', isCorrect: false),
        Answer(text: 'Green Line', isCorrect: true),
      ],
      correctAnswer: 'Green Line',
      explanation:
          '🟢 This is a support level, which is a price level where the asset tends to stop falling and bounce back up. It acts like a floor for the price! 💪',
    ),
    Question(
      id: '5',
      questionText: ' What tool is being used on the chart?',
      imageUrl: 'assets/images/fib-retracement-780x545.png',
      answers: [
        Answer(text: 'Fibonacci Retracement', isCorrect: true),
        Answer(text: 'Fibonacci Extension', isCorrect: false),
        Answer(text: 'Fibonacci Fan', isCorrect: false),
      ],
      correctAnswer: 'Fibonacci Retracement',
      explanation:
          '🔢 This is a Fibonacci Retracement, a tool used to identify potential support and resistance levels in a security\'s price movement. It\'s based on the golden ratio and can help predict where prices might reverse! 🧮✨',
    ),
    Question(
      id: '6',
      questionText:
          '''The pattern shown below is called a 'horn bottom', best found on a weekly chart. Where does it signal for us to enter a trade?''',
      imageUrl: 'assets/images/horn.jpg',
      answers: [
        Answer(text: 'C', isCorrect: false),
        Answer(text: 'A', isCorrect: true),
        Answer(text: 'B', isCorrect: false),
      ],
      correctAnswer: 'A',
      explanation:
          '📊 A horn bottom is recognized by two longer than usual downward wicks, separated by a smaller weekly candlestick. It signals a reversal, with entry when the price breaks above the top of the two larger candles. This pattern suggests a potential bullish turn in the market! 🐂',
    ),
    Question(
      id: '7',
      questionText:
          ' Which entry point is the best one for trading this double bottom pattern?',
      imageUrl: 'assets/images/doublebottom.gif',
      answers: [
        Answer(text: 'a', isCorrect: false),
        Answer(text: 'b', isCorrect: true),
        Answer(text: 'c', isCorrect: false),
      ],
      correctAnswer: 'b',
      explanation:
          '🎯 Enter the trade on the breakout above the neckline. This is typically the most reliable entry point for a double bottom pattern, as it confirms the reversal and suggests potential upward momentum! 📈',
    ),
    Question(
      id: '8',
      questionText:
          ' In a head and shoulders pattern, the distance the price moves after a breakout is usually equal to ...',
      imageUrl: 'assets/images/headshoulder1.gif',
      answers: [
        Answer(
            text:
                ' the distance from the high point of the head to the neckline',
            isCorrect: true),
        Answer(
            text:
                'the difference between the head height and the shoulder height',
            isCorrect: false),
        Answer(
            text: 'the head height added to the shoulder height',
            isCorrect: false),
      ],
      correctAnswer:
          'the distance from the high point of the head to the neckline',
      explanation:
          '📏 This technique suggests that after a breakout, the price is expected to fall by approximately the same distance as that between the head\'s peak and the neckline. Traders use this to set price targets or estimate the potential magnitude of the move following the pattern completion. It\'s like measuring the "height" of the pattern to predict the depth of the fall! 📉',
    ),
    Question(
      id: '9',
      questionText: ' Is this a valid double top pattern?',
      imageUrl: 'assets/images/isthisadoubletop.gif',
      answers: [
        Answer(text: 'Yes', isCorrect: false),
        Answer(text: 'No', isCorrect: true),
      ],
      correctAnswer: 'No',
      explanation:
          '✅ The double top pattern isn\'t complete until the neckline has been broken (i.e., the price has dropped below the valley between the two tops). This confirmation is crucial for validating the reversal pattern! 🔍',
    ),
  ],
);
