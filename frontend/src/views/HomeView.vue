<script setup lang="ts">
import { ref } from 'vue';
import { useForm } from 'vuestic-ui';
import MemoApiService from '../services/MemoApiService';
import MemoList from '../components/MemoList.vue';

// フォームバリデーションのための関数
const isValid = useForm('insertFormRef');

// 状態の定義
const showPostMemoModal = ref(false);
const memoTitle = ref('');
const memoContent = ref('');

// メモを投稿する関数
const postMemo = async () => {
  try {
    const body = JSON.stringify({
      title: memoTitle.value,
      content: memoContent.value
    });

    const res = await MemoApiService.insert(body);
    const alertMessage = (res.statusText === "Created" ? "Successfully inserted memo." : "Failed to insert memo.");

    alert(alertMessage);
    location.reload();
  } catch (error) {
    console.error("Error inserting memo:", error);
    alert("An error occurred while inserting the memo.");
  }
};
</script>

<template>
  <header>
    <va-button @click="showPostMemoModal = !showPostMemoModal">Add</va-button>
  </header>
  <main>
    <MemoList />
  </main>
  <va-modal v-model="showPostMemoModal" hide-default-actions>
    <va-form ref="insertFormRef">
      <div class="va-form-header">
        <va-button round icon="close" style="width: 10px;" @click="showPostMemoModal = !showPostMemoModal" />
      </div>
      <va-input v-model="memoTitle" label="title"
        :rules="[(value) => (value && value.length > 0) || 'title is required']" />

      <va-input v-model="memoContent" type="textarea" label="content" autosize
        :rules="[(value) => (value && value.length > 0) || 'content is required']" />

      <va-button :disalbed="!isValid" @click="postMemo()">
        Submit
      </va-button>
    </va-form>
  </va-modal>
</template>

<style scoped>
header {
  width: 100%;
  padding: 50px 0;
  display: flex;
  flex-flow: row wrap;
  justify-content: flex-end;
}

.va-form {
  display: flex;
  flex-flow: column;

  .va-form-header {
    display: flex;
    flex-flow: row;
    justify-content: flex-end;
    margin: 0;
  }

  * {
    margin: 10px 0;
  }
}
</style>