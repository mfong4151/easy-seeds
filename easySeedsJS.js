class EasySeeds {

    static singleSeeder(table, className, tableString) {

        className.destroyAll();
        ApplicationRecord.connection.resetPkSequence(tableString);
        console.log(`Creating ${tableString}...`);   
        
        table.forEach((tableRow) => className.create(tableRow));
            
        console.log(`DONE WITH ${tableString.toUpperCase()}, ${tableString.toUpperCase()} SEEDING SUCCESSFUL`);
        
    } 


    static createEasySeedData(classNames) {

      const tables = EasySeeds.tablesFromCsvs();
  
      for (let i = 0; i < tables.length; i++) {
  
          const className = classNames[i];
          EasySeeds.singleSeeder(tables[i], className, tableStrings[i]);
      }
    }

  static attachImages(classImageNames) {
    const seedFolder = '../seed_image_files';
    process.chdir(seedFolder);

    fs.readdirSync("*").forEach((seedFile, i) => {
      const [headers, data] = EasySeeds.unpackCsvs(seedFile);
      const classImageName = classImageNames[i];
      console.log(`Attaching to ${classImageName}...`);

      data.forEach((row, i) => {
          const [objectId, url, filename] = row;
          const classInstance = classImageName.findBy({id: objectId});
          console.log(classInstance, url, filename);
          classInstance.image.attach({io: URI.open(url), filename: filename});
          console.log(`attached to ${filename}`);
      });
    });
  }

  
  static destroyTable(className, tableString) {
    console.log(`Destroying the ${tableString} table`);
    className.destroyAll();
    ApplicationRecord.connection.resetPkSequence(tableString);
  }


  static destroyTables(classNames, tableStrings) {
    for (let i = classNames.length - 1; i >= 0; i--) {
      EasySeeds.destroyTable(classNames[i], tableStrings[i]);
    }
  }


    static unpackCsvs(seedFile) {
      const data = [];
      const csv = require('csv');
      csv.parse(seedFile, function(err, data) {
        if (err) throw err;
        return data;
      });
      const headers = data.shift();
      headers.map((header) => header.toLowerCase());
    
      return [headers, data];
    }
    
    static typeConversion(datum, dataType = 'string') {
        if (['text', 'string', 's'].includes(dataType)) {
          return datum.toString();
        
        } else if (['int', 'integer', 'i'].includes(dataType)) {
          return parseInt(datum);
        
        } else if (['float', 'f'].includes(dataType)) {
        
          return parseFloat(datum);
  
        } else if (["bool", "boolean"].includes(dataType)) {
          return (datum.toLowerCase() === "true");
  
        } else if (["date"].includes(dataType)) {
          return new Date(datum).toString();
  
        } else {
          return datum;
        }
      }
      
      static tablesFromCsvs() {
          
          const allSeedData = [];
          const tableStrings = [];
          const seedFolder = './db/seed_files';
          
          process.chdir(seedFolder);
          fs.readdirSync("*").forEach((seedFile) => {
          
              const seedRes = [];
              const [headers, data] = unpackCsvs(seedFile);
              
              data.forEach((row, j) => {
                  
                  const datum = {};
              
                  row.forEach((col, i) => {
                      
                    const key = EasySeeds.cleanHeaders(headers[i]);
                    datum[key[0]] = typeConversion(row[i], key[1]);
                  
                  });
              
                  seedRes.push(datum);
              });
              
              
              tableStrings.push(seedFile.slice(seedFile.indexOf('_') + 1, -11));
              allSeedData.push(seedRes);
          });
          
          return [allSeedData, tableStrings];
  
      }
  
  
      static cleanHeaders(header) {
          if (header.includes(":")) {
            const [first, second] = header.split(":");
            const headerAndType = [first.toLowerCase(), second];
          } else {
            const headerAndType = [header.toLowerCase(), 'string'];
          }
          return headerAndType;
      }
  }
