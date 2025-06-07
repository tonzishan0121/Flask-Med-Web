<template>
  <el-row :gutter="20">
    <el-col :span="12">
      <el-form ref="formRef" :model="form" label-width="150px">
        <el-form-item label="性别">
          <el-radio-group v-model="form.GENDER">
            <el-radio :value="1">女</el-radio>
            <el-radio :value="2">男</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="年龄">
          <el-input v-model.number="form.AGE" type="number" min="18" max="100" placeholder="示例值：55"></el-input>
        </el-form-item>
        <el-form-item label="吸烟">
          <el-radio-group v-model="form.SMOKING">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="黄手指">
          <el-radio-group v-model="form.YELLOW_FINGERS">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="焦虑">
          <el-radio-group v-model="form.ANXIETY">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="同伴压力">
          <el-radio-group v-model="form.PEER_PRESSURE">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="慢性疾病">
          <el-radio-group v-model="form.CHRONIC_DISEASE">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="疲劳">
          <el-radio-group v-model="form.FATIGUE">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="过敏">
          <el-radio-group v-model="form.ALLERGY">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="喘息">
          <el-radio-group v-model="form.WHEEZING">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="饮酒">
          <el-radio-group v-model="form.ALCOHOL_CONSUMING">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="咳嗽">
          <el-radio-group v-model="form.COUGHING">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="气短">
          <el-radio-group v-model="form.SHORTNESS_OF_BREATH">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="吞咽困难">
          <el-radio-group v-model="form.SWALLOWING_DIFFICULTY">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="胸痛">
          <el-radio-group v-model="form.CHEST_PAIN">
            <el-radio :value="1">否</el-radio>
            <el-radio :value="2">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="predict">预测</el-button>
        </el-form-item>
      </el-form>
      <el-card v-if="predictionResult" class="result-card">
        <p style="font-weight: bold; margin-bottom: 10px; font-size: 16px">多模型预测结果：</p>
        <div v-for="(model, name) in predictionResult" :key="name" class="model-result">
          <p :style="{ color: model.includes('肺癌') ? '#f56c6c' : '#67c23a' }">{{ model }}</p>
        </div>
      </el-card>
    </el-col>
  </el-row>
</template>

<script setup>
import { ref, computed } from 'vue'

const form = ref({
  GENDER: 1,
  AGE: 55,
  SMOKING: 1,
  YELLOW_FINGERS: 1,
  ANXIETY: 1,
  PEER_PRESSURE: 1,
  CHRONIC_DISEASE: 1,
  FATIGUE: 1,
  ALLERGY: 1,
  WHEEZING: 1,
  ALCOHOL_CONSUMING: 1,
  COUGHING: 1,
  SHORTNESS_OF_BREATH: 1,
  SWALLOWING_DIFFICULTY: 1,
  CHEST_PAIN: 1
})

const predictionResult = ref(null)

function formatCancerFeatures(rawData) {
    return Object.keys(rawData).reduce((acc, key) => {
        acc[key.replace(/_/g, ' ')] = rawData[key];
        return acc;
    }, {});
}
const predict = async () => {
  predictionResult.value = await fetch('http://127.0.0.1:5000/api/cancer', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(formatCancerFeatures(form.value))
  }).then(res => res.json())
    .then(data => data)
}

const resultColor = computed(() => {
  if (!predictionResult.value) return ''
  return predictionResult.value.includes("肺癌") ? '#f56c6c' : '#67c23a'
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