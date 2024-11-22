String getIncorrectAnswerDescription(String answer) {
  switch (answer.toLowerCase()) {
    case 'aries':
      return 'Dismissive\nEasily Angered\nRash';
    case 'aquarius':
      return 'Impatient\nStubborn\nCaring';
    case 'cancer':
      return 'Moody\nAfraid to Blossom\nUnable to Let Go';
    case 'capricorn':
      return 'Self-Righteous\nJudgmental\nCold';
    case 'gemini':
      return 'Repetitive\nLiars\nPoor Listeners';
    case 'leo':
      return 'Egotistic\nVain\nDramatic';
    case 'libra':
      return 'Indecisive\nConflict-Avoidant\nEasily Distracted';
    case 'pisces':
      return 'Impractical\nTakes on Others Issues\nProjects Guilt';
    case 'sagittarius':
      return 'Too Energetic\nUnpredictable\nLoud';
    case 'scorpio':
      return 'Manipulative\nHostile\nVengeful';
    case 'taurus':
      return 'Cautious\nAntisocial\nLazy';
    case 'virgo':
      return 'Knit-Picky\nDetail-Oriented\nSloppy';
    default:
      return 'Impatient\nStubborn\nCaring';
  }
}