/*
Covid 19 Data Exploration (19/12/2021) 
By Nicolas Silva

Skills used: 
	CTE's, 
	Temp Tables, 
	Creating Views, 
	Converting Data Types

Database Name: CovidProject
Tables Names:[dbo].[Covid_Deaths],
			 [dbo].[Covid_Vacinnations]

*/


-- Using CTE to perform Calculation on Partition By
-- We need to Execute both queries (CTE and the Select Statement bellow)
With PopvsVac (
	Continent, 
	Location, 
	Date, 
	Population, 
	New_Vaccinations, 
	RollingPeopleVaccinated
)
as
(
Select 
	dea.continent, 
	dea.location, 
	dea.date, 
	dea.population, 
	vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) 
		OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100 (we need the CTE here)
From CovidDeaths as dea
Join Covid_Vaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
)
go
-- To use this select statement, make sure to run the CTE above as well
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac
go

-- Using Temp Table to perform Calculation on Partition By in previous query
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
	Continent nvarchar(255),
	Location nvarchar(255),
	Date datetime,
	Population numeric,
	New_vaccinations numeric,
	RollingPeopleVaccinated numeric
)
go

Insert into #PercentPopulationVaccinated
Select 
	dea.continent, 
	dea.location, 
	dea.date, 
	dea.population, 
	vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) 
		OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..Covid_Vaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
go

--- Using the temp table, we need to run both queries
Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated
go


-- Creating View to store data
Create View PercentPopulationVaccinated as
Select 
	dea.continent, 
	dea.location,
	dea.date, 
	dea.population, 
	vac.new_vaccinations, 
	SUM(CONVERT(int,vac.new_vaccinations)) 
		OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths as dea
Join PortfolioProject..CovidVaccinations as vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
go