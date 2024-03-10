#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "structs.h"

void get_operations(void **operations);

void print(int nr, sensor *sensors, int idx)
{
	if (idx < 0 || idx >= nr) {  // verificare range index senzor
		printf("Index not in range!\n");
		return;
	}
	if (sensors[idx].sensor_type == TIRE) {  // afisare date senzor TIRE
		tire_sensor *tire;
		tire = (tire_sensor *)(sensors[idx].sensor_data);
		printf("Tire Sensor\n");
		printf("Pressure: %.2f\n", tire->pressure);
		printf("Temperature: %.2f\n", tire->temperature);
		printf("Wear Level: %d%%\n", tire->wear_level);
		if (tire->performace_score != 0)
			printf("Performance Score: %d\n", tire->performace_score);
		else
			printf("Performance Score: Not Calculated\n");
	}
	if (sensors[idx].sensor_type == PMU) {  // afisare date senzor PMU
		power_management_unit *pmu;
		pmu = (power_management_unit *)(sensors[idx].sensor_data);
		printf("Power Management Unit\n");
		printf("Voltage: %.2f\n", pmu->voltage);
		printf("Current: %.2f\n", pmu->current);
		printf("Power Consumption: %.2f\n", pmu->power_consumption);
		printf("Energy Regen: %d%%\n", pmu->energy_regen);
		printf("Energy Storage: %d%%\n", pmu->energy_storage);
	}
}

void analyze(int nr, sensor *sensors, int idx, void ((*operations[8])(void *)))
{
	if (idx < 0 || idx >= nr) {  // verificare range index senzor
		printf("Index not in range!\n");
		return;
	}
	for (int i = 0; i < sensors[idx].nr_operations; i++) {
		// apel functie
		operations[sensors[idx].operations_idxs[i]](sensors[idx].sensor_data);
	}
}

void clear(int *nr, sensor **sensors)
{
	for (int i = 0; i < (*nr); i++) {
		int ok = 1;
		// verificare valori senzor TIRE
		if ((*sensors)[i].sensor_type == TIRE) {
			tire_sensor *tire;
			tire = (tire_sensor *)((*sensors)[i].sensor_data);
			if (tire->pressure < 19 || tire->pressure > 28)
				ok = 0;
			if (tire->temperature < 0 || tire->temperature > 120)
				ok = 0;
			if (tire->wear_level < 0 || tire->wear_level > 100)
				ok = 0;
		}
		// verificare valori senzor PMU
		if ((*sensors)[i].sensor_type == PMU) {
			power_management_unit *pmu;
			pmu = (power_management_unit *)((*sensors)[i].sensor_data);
			if (pmu->voltage < 10 || pmu->voltage > 20)
				ok = 0;
			if (pmu->current < -100 || pmu->current > 100)
				ok = 0;
			if (pmu->power_consumption < 0 || pmu->power_consumption > 1000)
				ok = 0;
			if (pmu->energy_regen < 0 || pmu->energy_regen > 100)
				ok = 0;
			if (pmu->energy_storage < 0 || pmu->energy_storage > 100)
				ok = 0;
		}
		if (!ok) {  // senzorul curent trebuie exclus din vector
			sensor aux = (*sensors)[i];
			for (int j = i + 1; j < (*nr); j++)
				(*sensors)[j - 1] = (*sensors)[j];
			(*sensors)[(*nr) - 1] = aux;  // mutare exclus pe ultima pozitie
			free((*sensors)[(*nr) - 1].sensor_data);
			free((*sensors)[(*nr) - 1].operations_idxs);
			(*nr)--;
			// eliminare senzor exclus
			*sensors = (sensor *)realloc(*sensors, (*nr) * sizeof(sensor));
			i--;
		}
	}
}

void free_sensors(int *nr, sensor **sensors)
{
	for (int i = 0; i < (*nr); i++) {
		free((*sensors)[i].sensor_data);
		free((*sensors)[i].operations_idxs);
	}
	free(*sensors);
	*sensors = NULL;
	*nr = 0;
}

int main(int argc, char const *argv[])
{
	FILE *fin = fopen(argv[1], "rb");
	if (!fin)
		exit(-1);
	int nr_sensors;
	fread(&nr_sensors, sizeof(int), 1, fin);  // citire nr de senzori
	// alocare vector de senzori
	sensor *sensors = (sensor *)malloc(nr_sensors * sizeof(sensor));
	if (!sensors)
		exit(-1);
	for (int i = 0; i < nr_sensors; i++) {
		// citire tipul senzorului
		fread(&sensors[i].sensor_type, sizeof(int), 1, fin);
		if (sensors[i].sensor_type == PMU) {
			// alocare spatiu pentru date PMU
			sensors[i].sensor_data = malloc(sizeof(power_management_unit));
			if (!sensors[i].sensor_data)
				exit(-1);
			power_management_unit *pmu;  // variabila pentru a face cast la PMU
			pmu = (power_management_unit *)(sensors[i].sensor_data);
			// citire date senzor PMU
			fread(&pmu->voltage, sizeof(float), 1, fin);
			fread(&pmu->current, sizeof(float), 1, fin);
			fread(&pmu->power_consumption, sizeof(float), 1, fin);
			fread(&pmu->energy_regen, sizeof(int), 1, fin);
			fread(&pmu->energy_storage, sizeof(int), 1, fin);
		}
		if (sensors[i].sensor_type == TIRE) {
			// alocare spatiu pentru date TIRE
			sensors[i].sensor_data = (tire_sensor *)malloc(sizeof(tire_sensor));
			if (!sensors[i].sensor_data)
				exit(-1);
			tire_sensor *tire;  // variabila pentru a face cast la TIRE
			tire = (tire_sensor *)(sensors[i].sensor_data);
			// citire date senzor TIRE
			fread(&tire->pressure, sizeof(float), 1, fin);
			fread(&tire->temperature, sizeof(float), 1, fin);
			fread(&tire->wear_level, sizeof(int), 1, fin);
			fread(&tire->performace_score, sizeof(int), 1, fin);
		}
		// citire nr de operatii aplicate senzorului
		fread(&sensors[i].nr_operations, sizeof(int), 1, fin);
		int nr_operations = sensors[i].nr_operations;
		sensors[i].operations_idxs = (int *)malloc(nr_operations * sizeof(int));
		if (!sensors[i].operations_idxs)
			exit(-1);
		for (int j = 0; j < nr_operations; j++) {
			// citire index operatie
			fread(&sensors[i].operations_idxs[j], sizeof(int), 1, fin);
		}
	}
	fclose(fin);
	// sortare dupa prioritate a vectorului de senzori
	for (int i = 0; i < nr_sensors; i++)
		if (sensors[i].sensor_type == PMU)
			while ((i - 1 >= 0) && (sensors[i - 1].sensor_type == TIRE)) {
				sensor aux = sensors[i - 1];
				sensors[i - 1] = sensors[i];
				sensors[i] = aux;
				i--;
			}
	char command[101]; int idx = 0;
	void ((*operations[8])(void *));  // vector de pointer la functii
	get_operations((void **)operations); // umplere vector pointeri la functii
	while (scanf("%s", command)) {
		if (!strcmp(command, "exit")) {  // command EXIT
			free_sensors(&nr_sensors, &sensors);
			break;
		} else if (!strcmp(command, "print")) {  // command PRINT
			scanf("%d", &idx);
			print(nr_sensors, sensors, idx);
		} else if (!strcmp(command, "analyze")) {  // command ANALYZE
			scanf("%d", &idx);
			analyze(nr_sensors, sensors, idx, operations);
		} else if (!strcmp(command, "clear"))  // command CLEAR
			clear(&nr_sensors, &sensors);
	}
	return 0;
}
