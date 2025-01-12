# Slowly Changing Dimension Transformation in SSIS

The **Slowly Changing Dimension (SCD) Transformation** in SSIS is used to manage and process changes in dimension data over time. Dimension data refers to descriptive attributes or characteristics of data, such as customer or product information, which may evolve gradually.

The SCD transformation allows you to handle these changes according to the type of change:

- **Type 1**: Overwrite the old data with new data (no history maintained).
- **Type 2**: Maintain history by adding a new record for the change.
- **Type 3**: Maintain history by adding a new column to store the previous value.

---

## Key Features of Slowly Changing Dimension Transformation

- Provides a wizard-driven interface to define how changes are managed.
- Automatically identifies and categorizes rows as new, changed, or unchanged.
- Handles surrogate keys and supports the update of existing records or insertion of new records.

---

## Example Scenario for Slowly Changing Dimension

**Scenario**: A company tracks customer information in a data warehouse. Customers' addresses may change over time, and the company wants to track these changes.

1. **Type 1 Change** (Overwrite):
   - A customer updates their email address.
   - The system overwrites the old email address with the new one.

2. **Type 2 Change** (History):
   - A customer moves to a new city.
   - The system inserts a new row with the updated city and marks the old row as historical.

3. **Type 3 Change** (Add Column):
   - A customer changes their phone number.
   - The system updates the current row but stores the old phone number in a separate column.

---

# Difference Between SCD Transformation and Lookup Transformation

The **SCD Transformation** and **Lookup Transformation** serve different purposes in SSIS:

| Feature                         | Slowly Changing Dimension (SCD)      | Lookup Transformation                     |
|---------------------------------|--------------------------------------|-------------------------------------------|
| **Purpose**                     | Manage changes in dimension data     | Match and retrieve data from a reference source |
| **Handles Historical Changes**  | Yes (Type 2 and Type 3)              | No (only retrieves matching data)         |
| **Data Flow Integration**       | Inserts or updates data in dimensions| Retrieves data for enrichment or validation |
| **Configuration**               | Wizard-driven for handling SCD types | Configured to match and fetch reference data |
| **Scenarios**                   | Tracking customer or product changes | Enriching fact data with descriptive attributes |

---

## Example: SCD vs. Lookup

**Scenario**: A data warehouse for retail sales.

1. **Using SCD Transformation**:
   - The **Customer Dimension** tracks customers' addresses. When a customer moves, the SCD transformation ensures the change is recorded as a new row (Type 2) or overwrites the existing row (Type 1).

2. **Using Lookup Transformation**:
   - During sales fact processing, a **Lookup** is used to match a `CustomerID` from the transaction data to the `Customer Dimension` and retrieve the associated `Customer Name` or `Region`.

---

## Choosing Between SCD and Lookup

- **Use SCD Transformation**:
  - When you need to handle slowly changing attributes in dimension tables.
  - When tracking historical changes is essential for analytical reporting.

- **Use Lookup Transformation**:
  - When you need to enrich or validate data in a fact table with attributes from a reference dimension.
  - When historical tracking is not required.

The **Slowly Changing Dimension Transformation** ensures your dimension tables are accurately updated, while the **Lookup Transformation** is ideal for enriching and validating fact data during ETL processes.
