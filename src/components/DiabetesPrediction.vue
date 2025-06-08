<template>
  <el-row :gutter="20">
    <el-col :span="12">
      <el-form ref="formRef" :model="form" label-width="150px">
        <el-form-item label="怀孕次数">
          <el-input v-model.number="form.Pregnancies" type="number" min="0" max="17" placeholder="示例值：6"></el-input>
        </el-form-item>
        <el-form-item label="葡萄糖">
          <el-input v-model.number="form.Glucose" type="number" min="0" max="199" placeholder="示例值：148"></el-input>
        </el-form-item>
        <el-form-item label="血压(mmHg)">
          <el-input v-model.number="form.BloodPressure" type="number" min="0" max="122" placeholder="示例值：72"></el-input>
        </el-form-item>
        <el-form-item label="皮肤厚度(mm)">
          <el-input v-model.number="form.SkinThickness" type="number" min="0" max="99" placeholder="示例值：35"></el-input>
        </el-form-item>
        <el-form-item label="胰岛素(mu U/ml)">
          <el-input v-model.number="form.Insulin" type="number" min="0" max="846" placeholder="示例值：0"></el-input>
        </el-form-item>
        <el-form-item label="BMI">
          <el-input v-model.number="form.BMI" type="number" step="0.1" min="0" max="67.1" placeholder="示例值：33.6"></el-input>
        </el-form-item>
        <el-form-item label="糖尿病谱系功能">
          <el-input v-model.number="form.DiabetesPedigreeFunction" type="number" step="0.01" min="0.078" max="2.42" placeholder="示例值：0.627"></el-input>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input v-model.number="form.Age" type="number" min="21" max="81" placeholder="示例值：50"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="predict">预测</el-button>
        </el-form-item>
      </el-form>
      <el-card v-if="predictionResult" class="result-card">
        <p style="font-weight: bold; margin-bottom: 10px; font-size: 16px">多模型预测结果：</p>
        <div v-for="(model, name) in predictionResult" :key="name" class="model-result">
          <p :style="{ color: model.includes('糖尿病') ? '#f56c6c' : '#67c23a' }">{{ model }}</p>
        </div>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { ref, computed } from 'vue'
import { API_CONFIG } from '../config'

const form = ref({ 
  Pregnancies: 6,
  Glucose: 148,
  BloodPressure: 72,
  SkinThickness: 35,
  Insulin: 0,
  BMI: 33.6,
  DiabetesPedigreeFunction: 0.627,
  Age: 50
})

const predictionResult = ref(null)

const predict = async () => {
  predictionResult.value = await fetch(`${API_CONFIG.BASE_URL}/api/diabetes`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(form.value)
  }).then(res => res.json())
    .then(data => data)
}

const resultColor = computed(() => {
  if (!predictionResult.value) return ''
  return predictionResult.value.includes("糖尿病") ? '#f56c6c' : '#67c23a'
})
</script>

<style scoped>
.result-card {
  margin-top: 20px;
  padding: 15px;
  border-radius: 8px;
}
el-form {
  background: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
}
.el-form-item {
  margin-bottom: 12px;
}
.el-form-item__label {
  text-align: right;
  word-wrap: break-word;
  word-break: break-all;
}
</style>