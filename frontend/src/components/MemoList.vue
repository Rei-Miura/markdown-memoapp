<script setup lang="ts">
import MemoItem from './items/MemoItem.vue'
import MemoApiService from "../services/MemoApiService"
import { onMounted, ref } from 'vue'

interface Memo {
  ID: string,
  Title: string
  Content: string
}

const memoList = ref<Memo[]>([]);

// メモ一覧取得
const getMemoList = async (isMd2Html: boolean): Promise<void> => {
  try {
    const res = await MemoApiService.getAll(isMd2Html);
    memoList.value = res.data as Memo[];
  } catch (error) {
    console.error("Failed to fetch memos:", error);
  }
};

// コンポーネントのマウント時にメモ一覧を取得
onMounted(() => {
  getMemoList(true);
});
</script>

<template>
  <div class="memo-list" v-if="memoList.length > 0">
    <MemoItem v-for="memo in memoList" :memoId="memo.ID" :memoTitle="memo.Title" :memoContent="memo.Content">
    </MemoItem>
  </div>
  <div class="memo-list-empty" v-else>
    No memos found.
  </div>
</template>

<style scoped>
.memo-list {
  display: flex;
  flex-wrap: wrap;
  gap: 50px 30px;
}

.memo-list-empty {
  display: flex;
  justify-content: center;
}
</style>