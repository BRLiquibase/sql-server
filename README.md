# Liquibase POC Starter Kit

This kit gets Liquibase running against your SQL Server database, either locally or through GitHub Actions using flow files.

## What's inside

```
liquibase.properties               Connection config for local runs (fill in your values)
changelog/
  db.changelog-main.xml            Main changelog, includes everything below
  changes/
    001-create-sample-table.sql    Creates poc_sample table (with rollback)
    002-add-status-column.sql      Adds a status column (with rollback)
flows/
  deploy.flowfile.yaml             Deploy flow: snapshot -> policy checks -> update -> history
  rollback.flowfile.yaml           Rollback flow: snapshot -> rollback-one-update (forced) -> status -> history
.github/workflows/
  1-deploy.yml                     Runs the deploy flow
  2-rollback.yml                   Runs the rollback flow
```

## Local setup (fastest way to see it work)

1. Install Liquibase: https://docs.liquibase.com/start/install/
2. Download the SQL Server JDBC driver and place it in a `drivers/` folder:
   https://learn.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server
3. Edit `liquibase.properties`: set `url`, `username`, `password`.
4. Run:
   ```
   liquibase status
   liquibase update
   ```
5. Check your database. You should see a `poc_sample` table with a `status` column, plus Liquibase's own `DATABASECHANGELOG` and `DATABASECHANGELOGLOCK` tracking tables.
6. Test rollback:
   ```
   liquibase rollback-count 1
   liquibase rollback-count 2
   ```

## GitHub Actions setup

1. Push this repo to GitHub.
2. In repo Settings > Secrets and variables > Actions, add:
   - `LB_LICENSE_KEY` (Liquibase Secure license, needed for policy checks)
   - `LB_URL` (full JDBC URL to the target database)
   - `LB_USERNAME`
   - `LB_PASSWORD`
3. Run the **1 - Deploy** workflow from the Actions tab. Inputs:
   - `run_snapshot` (true/false): capture a snapshot before deploying
   - `run_policies` (true/false): run policy checks before deploying
4. To roll back, run the **2 - Rollback** workflow. Inputs:
   - `deployment_id`: the deployment to roll back, find it by running `liquibase history` (or via the flow's own history step)
   - `run_snapshot` (true/false): capture a snapshot before rolling back

The rollback flow uses `rollback-one-update` with `force: true`, so it rolls back a single deployment regardless of Liquibase's usual safety checks. Confirm the deployment ID before running it.

Both workflows call a Liquibase flow file under `flows/`, so the actual pipeline logic (which steps run, in what order) lives in the flow file, not the workflow YAML. The workflow just installs Liquibase, pulls the JDBC driver, and runs `liquibase flow --flow-file=...`.

## Next steps for the POC

- Swap in your real schema by adding more `.sql` changesets under `changelog/changes/`. The main changelog uses `includeAll`, so anything dropped in that folder is picked up automatically, in filename order.
- Add a second environment (e.g. staging) to show environment promotion, and a second set of secrets to target it.
- Deploy, make a manual change to the DB, then run the deploy flow again with `run_snapshot=true` to show what a snapshot captures before and after drift, next to Flyway's gap here.
