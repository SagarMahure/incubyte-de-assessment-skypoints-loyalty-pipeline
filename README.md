# SkyPoints loyalty pipeline

My submission for the Incubyte Data Engineer assessment.

The problem: an airline loyalty program sends two files every day, a member profile file and a JSON file of mile redemptions. The members have to be split into one table per country, and if a member moves country, only their latest record should stay. The JSON has to be flattened into a table, and bad data has to be caught on the way in.

## How I'm building it

I'm using PySpark with Delta tables on Azure Databricks. Azure Data Factory copies the files in and runs the notebooks in order.

Three layers:

- bronze: the files exactly as they arrive, every column as a string, nothing rejected
- silver: dates parsed, Age and Stale_Member added, bad rows flagged
- gold: one table per country, a small table that remembers which country each member is in now, and the redemptions table

## Progress

- [ ] bronze: members
- [ ] silver: Age, Stale_Member, validation rules
- [ ] gold: country split, latest record wins
- [ ] redemptions: JSON flatten and join to members
- [ ] validations and tests
- [ ] Data Factory pipeline

## Notes

I'll add my assumptions and the questions I would ask the team here as I go.

I'm using Claude as an AI assistant while building this, and I'll write down what I used it for and what I checked myself in a section at the end.

Test files for redemptions come in two shapes on purpose: one JSON object spread over several lines (20240115) and one object per line (20240116). The pipeline should read both.

## Data

- `data/incubyte_sample_source`: the input files as received from Incubyte (AUS, USA, IND).
- `data/my_data`: files I wrote myself, based on the sample in the PDF, to try tricky cases (a member changing country, bad dates, duplicate rows, a redemption changing status).