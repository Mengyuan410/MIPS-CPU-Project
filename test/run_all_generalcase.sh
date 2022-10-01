GENERAL_TESTCASES="test/1-hex/mem_1/general/*"
source_directory="$1";
for i in ${GENERAL_TESTCASES} ; do
    
    GENERAL_TESTCASE=$(basename ${i} .txt)
    set +e
    
    iverilog -g 2012\
    -s mips_cpu_tb \
    -o test/2-simulator/mips_cpu_tb_${GENERAL_TESTCASE} \
    -P mips_cpu_tb.MEM_1=\"./test/1-hex/mem_1/general/${GENERAL_TESTCASE}.txt\" \
    -P mips_cpu_tb.MEM_2=\"./test/1-hex/mem_2/general/${GENERAL_TESTCASE}.txt\" \
    ./${source_directory}/mips_cpu_*.v \
    ./test/src/mips_cpu_*.v \
    ./${source_directory}/mips_cpu/*.v
    set +e
    ./test/2-simulator/mips_cpu_tb_${GENERAL_TESTCASE} > ./test/3-output/mips_cpu_tb_${GENERAL_TESTCASE}.stdout   
done


GENERAL_TESTCASES="test/1-hex/mem_1/general/*"
for i in ${GENERAL_TESTCASES} ; do
    GENERAL_TESTCASE=$(basename ${i} .txt)
    set +e
    iverilog -g 2012\
    -s mips_cpu_pipeline_tb \
    -o test/2-simulator/mips_cpu_pipeline_tb_${GENERAL_TESTCASE} \
    -P mips_cpu_pipeline_tb.MEM_1=\"./test/1-hex/mem_1/general/${GENERAL_TESTCASE}.txt\" \
    -P mips_cpu_pipeline_tb.MEM_2=\"./test/1-hex/mem_2/general/${GENERAL_TESTCASE}.txt\" \
    ./${source_directory}/mips_cpu_*.v \
    ./test/src/mips_cpu_*.v \
    ./${source_directory}/mips_cpu_pipeline/*.v
    set +e
    ./test/2-simulator/mips_cpu_pipeline_tb_${GENERAL_TESTCASE} > ./test/3-output/mips_cpu_pipeline_tb_${GENERAL_TESTCASE}.stdout  
done
