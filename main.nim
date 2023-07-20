import std/tables
import strformat
import strutils

var exchange = {"USD": 1.0, "JPY": 113.5, "EUR": 0.89, "RUB": 74.36,
        "GBP": 0.75}.newTable

proc printExchangeInformation() =
    for denomination in exchange.keys:
        let value = exchange[denomination]
        echo fmt"1 USD = {value} {denomination}"

proc printHelloMessage() =
    echo "Welcome to Currency Converter!"

proc calculateTargetCurrencyValue(amount: float64, originalCurrency: string,
        targetCurrency: string): float64 =
    return amount * exchange[targetCurrency] / exchange[originalCurrency]


proc promptForConvertRequest() =
    echo "What do you want to convert?"
    stdout.write "From: "
    let originalCurrency = strutils.toUpper(readLine(stdin))


    if exchange.hasKey(originalCurrency) == false:
        echo "Unkown currency"
        return

    stdout.write "To: "
    let targetCurrency = strutils.toUpper(readLine(stdin))

    stdout.write "Amount: "
    let originalCurrencyAmount =
        try: strutils.parseFloat (readLine(stdin))
        except ValueError:
            echo "Invalid amount, must be number"
            return
    if originalCurrencyAmount < 1:
        echo "The amount can not be less than 1."
        return

    let targetCurrencyValue = calculateTargetCurrencyValue(
            originalCurrencyAmount, originalCurrency, targetCurrency)

    echo fmt"Result: {originalCurrencyAmount} ${originalCurrency} equals {targetCurrencyValue} {targetCurrency}"
    return


proc loop() =
    while true:
        echo "What do you want to do?"
        echo "1-Convert currencies 2-Exit program"
        let input = readLine(stdin)
        case input:
            of "1":
                promptForConvertRequest()
            of "2":
                return
            else:
                echo "Unknown input"

proc main() =
    printHelloMessage()
    printExchangeInformation()
    loop()

main()
