# ADDITIONAL_COST_PORTION = 0.015 + 0.005 + 0.05 + 0.02975
# ADDITIONAL_COST_PORTION = 0.09975
ADDITIONAL_COST_PORTION = 0
def mortgate_calculator(price:, down_payment:, interest_rate:, monthly_payment:, yearly_additional_payment:)
  loan = price * (1 + ADDITIONAL_COST_PORTION) - down_payment
  puts "Original loan: #{loan}"
  month = 1
  total_payment = 0
  accumulated_paid_interest = 0
  while loan > 0 do
    if month % 12 == 1
      puts "#{month/12 + 1} year:"
    end
    interest_portion = (loan * interest_rate /12).round(0)
    repayment = (monthly_payment - interest_portion).round(0)
    if repayment > loan
      repayment = loan.round(0)
      loan = 0
      monthly_payment = repayment + interest_portion
    else
      loan -= repayment
    end
    if month % 12 == 0
      month_in_year = 12
    else
      month_in_year = month % 12
    end
    total_payment += monthly_payment
    accumulated_paid_interest += interest_portion

    puts "#{month_in_year}. month: Monthly Payment: #{monthly_payment}, Interest Portion: #{interest_portion}, Repayment: #{repayment}, Remaining Loan: #{loan}, Accumulated Payment: #{total_payment}, Accumulated Interest Paid: #{accumulated_paid_interest}"

    if month % 12 == 0 && yearly_additional_payment > 0
      if loan <= yearly_additional_payment
        yearly_additional_payment = loan
        loan = 0
      else
        loan -= yearly_additional_payment
      end
      total_payment += yearly_additional_payment

      puts "Additional payment: #{yearly_additional_payment}, Remaining Loan: #{loan}, Accumulated Payment: #{total_payment}"
    end

    month += 1
  end
end

mortgate_calculator(
  price: 3_000_000_000,
  down_payment: 1_000_000_000,
  interest_rate: 0.1,
  monthly_payment: 20_000_000,
  yearly_additional_payment: 100_000
)