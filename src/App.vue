<template>
  <el-container style="height: 92vh;">
    <el-header class="custom-header">
      <h1 class="title">
        <i class="el-icon-data-analysis"></i>
        数据分析平台
      </h1>
    </el-header>
    <el-main>
      <el-tabs v-model="activeTab" type="card">
        <el-tab-pane label="心脏病预测" name="heart"></el-tab-pane>
        <el-tab-pane label="糖尿病预测" name="diabetes"></el-tab-pane>
        <el-tab-pane label="肺癌预测" name="cancer"></el-tab-pane>
      </el-tabs>
      <div class="module-container">
        <!-- 功能模块展示区 -->
        <HeartDiseasePrediction v-show="activeTab === 'heart'" />
        <DiabetesPrediction v-show="activeTab === 'diabetes'" />
        <CancerPrediction v-show="activeTab === 'cancer'" />
      </div>
    </el-main>
  </el-container>
</template>

<script setup>
import { ref } from 'vue'
import HeartDiseasePrediction from './components/HeartDiseasePrediction.vue'
import DiabetesPrediction from './components/DiabetesPrediction.vue'
import CancerPrediction from './components/LungCancerPrediction.vue'
const activeTab = ref('heart')
</script>

<style scoped>
.el-container {
  min-height: 92vh;
  overflow-y: visible;
}

/* 清理重复样式 */
.module-container {
  padding: 20px;
}

el-header h1 {
  margin: 0;
  line-height: 60px;
  font-family: 'Segoe UI', sans-serif;
}

el-tabs {
  margin-bottom: 20px;
}

.title {
  font-size: 2.5rem;
  font-weight: bold;
  letter-spacing: 4px;
  color: #409EFF;
  text-shadow: 1px 2px 8px rgba(64,158,255,0.15);
  margin: 0;
  padding: 10px 0;
  display: flex;
  align-items: center;
}

.title .el-icon-data-analysis {
  margin-right: 12px;
  font-size: 2.2rem;
  vertical-align: middle;
}
</style>