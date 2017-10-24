Feature: Lost and found feature
  As an operator of STRS's customer service
  Such that I can help a customer find his/her lost belongings
  I want to get access to the customer's taxi ride history

  Scenario: Identifying taxi ride among multiple rides on a precise date
    Given STRS's ride history includes the following trips
        | date       | pickup_time | pickup_address | dropoff_address | taxi_id |
        | 2017-10-15 | 16:20:10    | Puusepa 8      | Jaama 42        | 3       |
        | 2017-10-16 | 10:30:30    | Raatuse 22     | Kreutzwaldi 1   | 3       |
        | 2017-10-16 | 10:42:17    | Aleksandri 7   | Puusepa 8       | 2       |
        | 2017-10-16 | 11:32:11    | Puusepa 8      | Kastani 1       | 1       |
        | 2017-10-16 | 12:11:20    | Puusepa 8      | Võru 51         | 4       |
        | 2017-10-16 | 15:12:20    | Liivi 2        | Turu 2          | 3       |
        | 2017-10-16 | 18:30:44    | Riia 14        | Narva mnt 89    | 1       |
    And "John Smith" lodges a customer service request for lost object
    And the lost object is a "smart phone"
    And the date of the loss is "2017-10-16"
    When the operator enters the date of loss
    Then the operator should see 6 rows
    When the operator enters "Puusepa 8" as pickup address
    Then the operator should see 2 rows
