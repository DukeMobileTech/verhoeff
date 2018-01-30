require './participant_verhoeff'
require 'csv'

participant_types = ['C', 'G', 'T', 'H', 'V', 'W']
facility_range = 100..999
participant_ranges = {
  'C' => 1..50,
  'G' => 1..50,
  'T' => 1..20,
  'H' => 1..20,
  'V' => 1..20,
  'W' => 1..20
}

participant_types.each do |type|
  participants = []
  facility_range.each do |facility|
    participant_ranges[type].each do |participant|
      padded_facility = facility.to_s.rjust(3,'0')
      padded_participant = participant.to_s.rjust(2,'0')
      pid = "#{type}-#{padded_facility}-#{padded_participant}"
      pid_checked = ParticipantVerhoeff.generate_check(pid)
      participants << [type, padded_facility, padded_participant, pid_checked[-1,1], pid_checked]
    end
  end

  CSV.open("verhoeff_ids/#{type}.csv", 'wb') do |csv|
    csv << ['Participant Type', 'School/Center', 'ID', 'Check', 'Participant ID']
    participants.each do |participant|
      csv << participant
    end
  end
end
