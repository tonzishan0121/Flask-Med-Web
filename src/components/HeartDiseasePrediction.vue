<template>
  <el-row :gutter="20">
    <el-col :span="12">
      <el-form ref="formRef" :model="form" label-width="150px">
        <el-form-item label="年龄">
          <el-input v-model.number="form.age" type="number" min="18" max="100" placeholder="示例值：45"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-radio-group v-model="form.sex">
            <el-radio :value="0">女</el-radio>
            <el-radio :value="1">男</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="胸痛类型">
          <el-input v-model.number="form.cp" type="number" min="0" max="3" placeholder="示例值：0"></el-input>
        </el-form-item>
        <el-form-item label="静息血压(mmHg)">
          <el-input v-model.number="form.trestbps" type="number" min="90" max="200" placeholder="示例值：120"></el-input>
        </el-form-item>
        <el-form-item label="血清胆固醇(mg/dl)">
          <el-input v-model.number="form.chol" type="number" min="126" max="564" placeholder="示例值：180"></el-input>
        </el-form-item>
        <el-form-item label="空腹血糖">
          <el-radio-group v-model="form.fbs">
            <el-radio :value="0">≤120mg/dl</el-radio>
            <el-radio :value="1">＞120mg/dl</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="静息心电图结果">
          <el-input v-model.number="form.restecg" type="number" min="0" max="2" placeholder="示例值：0"></el-input>
        </el-form-item>
        <el-form-item label="最大心率">
          <el-input v-model.number="form.thalach" type="number" min="71" max="202" placeholder="示例值：160"></el-input>
        </el-form-item>
        <el-form-item label="运动诱发心绞痛">
          <el-radio-group v-model="form.exang">
            <el-radio :value="0">无</el-radio>
            <el-radio :value="1">有</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="ST段压低">
          <el-input v-model.number="form.oldpeak" type="number" step="0.1" min="0" max="6.2" placeholder="示例值：0.8"></el-input>
        </el-form-item>
        <el-form-item label="ST段斜率">
          <el-input v-model.number="form.slope" type="number" min="0" max="2" placeholder="示例值：2"></el-input>
        </el-form-item>
        <el-form-item label="主要血管数">
          <el-input v-model.number="form.ca" type="number" min="0" max="4" placeholder="示例值：0"></el-input>
        </el-form-item>
        <el-form-item label="地中海贫血">
          <el-input v-model.number="form.thal" type="number" min="0" max="3" placeholder="示例值：1"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="predict">预测</el-button>
        </el-form-item>
      </el-form>
      <el-card v-if="predictionResult" class="result-card">
        <p style="font-weight: bold; margin-bottom: 10px; font-size: 16px">多模型预测结果：</p>
        <div v-for="(model, name) in predictionResult" :key="name" class="model-result">
          <p :style="{ color: model.includes('心脏病') ? '#f56c6c' : '#67c23a' }">{{ model }}</p>
        </div>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { ref, computed } from 'vue'

// 初始化13个字段的默认示例值
const form = ref({
  age: 45,
  sex: 0,
  cp: 0,
  trestbps: 120,
  chol: 180,
  fbs: 0,
  restecg: 0,
  thalach: 160,
  exang: 0,
  oldpeak: 0.8,
  slope: 2,
  ca: 0,
  thal: 1
})

const predictionResult = ref(null)

// 实际调用后端接口的预测逻辑
const predict = async () => {
  predictionResult.value = await fetch('http://127.0.0.1:5000/api/heart', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(form.value)
  }).then(res =>res.json())
    .then(data => data)
}

// 计算结果背景色（保持原有逻辑）
const resultColor = computed(() => {
  if (!predictionResult.value) return ''
  return predictionResult.value.includes("心脏病") ? '#f56c6c':'#67c23a'
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

/* 新增标签样式控制 */
.el-form-item__label {
  text-align: right;  /* 文字右对齐 */
  word-wrap: break-word;  /* 允许长文字换行 */
  word-break: break-all;  /* 强制换行 */
}
</style>