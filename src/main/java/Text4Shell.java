import java.io.IOException;
import java.io.Reader;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.stream.Stream;

import org.apache.commons.io.IOUtils;
import com.opencsv.CSVParser;
import com.opencsv.CSVParserBuilder;
import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;

public class Text4Shell {

    public static final String SLSA_CSV = "slsa.csv";

    public static void main(String[] args) {
        try {
            //readSlsaCsv();
            try(
                Reader reader = Files.newBufferedReader(Paths.get(SLSA_CSV));
                CSVReader csvReader = new CSVReader(reader);
            ){
                // Reading All Records at once into a List<String[]>
                List<String[]> records = csvReader.readAll();
                for (String[] strings : records) {
                    System.out.println(Arrays.toString(strings));
                }
            }
     
        } catch (Exception e) {
            throw new RuntimeException("Error during csv processing", e);
        }
    }
}