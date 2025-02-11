<script setup lang="ts">
import { useRouter } from 'vue-router';

// Propsの定義
const props = defineProps<{
  memoId: string;
  memoTitle: string;
  memoContent: string;
}>();

// ルーターを使用するためのインスタンス
const router = useRouter();

// メモ詳細画面に移動する関数
const moveToMemoDetail = () => {
  router.push(`/memo/${props.memoId}`);
};

// エスケープ文字列->HTML文字列
const unescape = (str: string) => {
  if (typeof str !== 'string') return str;

  const patterns: { [key: string]: string } = {
    '&lt;': '<',
    '&gt;': '>',
    '&amp;': '&',
    '&quot;': '"',
    '&#x27;': "'",
    '&#x60;': '`'
  };

  return str.replace(/&(lt|gt|amp|quot|#x27|#x60);/g, function (match: string): string {
    return patterns[match];
  });
};
</script>

<template>
  <va-card class="memo-item">
    <va-card-title class="memo-title">
      {{ memoTitle }}
    </va-card-title>
    <va-card-content class="memo-content" v-html="unescape(memoContent)" />
    <va-card-actions class="flex memo-action">
      <va-button @click="moveToMemoDetail">Detail</va-button>
    </va-card-actions>
  </va-card>
</template>

<style scoped>
.memo-item {
  width: 200px;
  height: 250px;
  white-space: pre-wrap;
  word-wrap: break-word;
}

.memo-content {
  height: 120px;
  overflow: auto;
}

.memo-action {
  width: 100%;
  display: flex;
  position: absolute;
  bottom: 0;
}
</style>