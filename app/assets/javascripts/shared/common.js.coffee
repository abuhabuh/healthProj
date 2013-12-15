# Calculates age from birthday date given
# TODO: Can this be optimized? Does it need to be?
window.calculateAge = (dob) ->
  
  todayDate = new Date()
  todayYear = todayDate.getFullYear()
  todayMonth = todayDate.getMonth()
  todayDay = todayDate.getDate()

  bornDate = new Date(dob)
  bornYear = bornDate.getFullYear()
  bornMonth = bornDate.getMonth()
  bornDay = bornDate.getDate()

  age = todayYear - bornYear

  if todayMonth < (bornMonth - 1)
    age -= 1
  if (bornMonth - 1) == todayMonth && (todayDay < bornDay)
    age -= 1

  return age

