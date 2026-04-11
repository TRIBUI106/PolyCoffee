package chez1s.assignment.service;

import chez1s.assignment.entity.CoffeeTable;
import chez1s.assignment.repository.TableRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * TC-055 to TC-062: Table management tests
 */
@ExtendWith(MockitoExtension.class)
class TableServiceTest {

    @Mock
    private TableRepository tableRepo;

    @InjectMocks
    private TableService tableService;

    private CoffeeTable existingTable;

    @BeforeEach
    void setUp() {
        existingTable = new CoffeeTable();
        existingTable.setId(1);
        existingTable.setTableNumber("Table 1");
        existingTable.setCode("T1");
        existingTable.setActive(true);
    }

    // TC-055
    @Test
    @DisplayName("TC-055: List all tables")
    void getAllTables() {
        when(tableRepo.findAll()).thenReturn(Arrays.asList(existingTable));
        List<CoffeeTable> result = tableService.getAllTables();
        assertEquals(1, result.size());
    }

    // TC-056
    @Test
    @DisplayName("TC-056: Create table with valid data, code uppercased")
    void createTable_validData() {
        tableService.createTable("Table 2", "t2");
        verify(tableRepo).save(argThat(t ->
                t.getTableNumber().equals("Table 2") &&
                t.getCode().equals("T2") &&
                t.isActive()));
    }

    // TC-058
    @Test
    @DisplayName("TC-058: Update table name and code")
    void updateTable() {
        when(tableRepo.findById(1)).thenReturn(existingTable);
        tableService.updateTable(1, "New Table", "nt1");
        assertEquals("New Table", existingTable.getTableNumber());
        assertEquals("NT1", existingTable.getCode());
        verify(tableRepo).save(existingTable);
    }

    // TC-059
    @Test
    @DisplayName("TC-059: Delete table")
    void deleteTable() {
        tableService.deleteTable(1);
        verify(tableRepo).delete(1);
    }

    // TC-060
    @Test
    @DisplayName("TC-060: Table code always uppercased")
    void createTable_codeUppercased() {
        tableService.createTable("name", "abc");
        verify(tableRepo).save(argThat(t -> t.getCode().equals("ABC")));
    }

    // TC-061
    @Test
    @DisplayName("TC-061: Get table by code")
    void getTableByCode() {
        when(tableRepo.findByCode("T1")).thenReturn(existingTable);
        CoffeeTable result = tableService.getTableByCode("T1");
        assertNotNull(result);
        assertEquals("T1", result.getCode());
    }

    @Test
    @DisplayName("Update non-existent table does nothing")
    void updateTable_notExists() {
        when(tableRepo.findById(999)).thenReturn(null);
        tableService.updateTable(999, "x", "y");
        verify(tableRepo, never()).save(any());
    }
}
