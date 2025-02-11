<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useForm } from 'vuestic-ui'
import MemoApiService from '../services/MemoApiService';

// ルート情報とルーターを取得
const route = useRoute();
const router = useRouter();

// 状態を定義
const memo = ref<Record<string, any>>({});
const editMemo = ref<Record<string, any>>({});
const isShowEditMemoModal = ref(false);
const isValid = useForm('updateFormRef');

// メモを取得
const getMemo = async (isMd2Html: boolean) => {
  try {
    const res = await MemoApiService.get(route.params.id, isMd2Html);
    if (!isMd2Html) {
      editMemo.value = res.data;
    } else {
      memo.value = res.data;
    }
  } catch (error) {
    console.error("Failed to fetch memo:", error);
  }
};

// メモを編集
const editMemoFunc = async () => {
  try {
    const body = JSON.stringify({
      title: editMemo.value.Title,
      content: editMemo.value.Content
    });
    const res = await MemoApiService.update(route.params.id, body);
    if (res.statusText === "No Content") {
      alert("Successfully edited memo");
      location.reload();
    } else {
      alert("Failed to edit memo");
    }
  } catch (error) {
    console.error("Error editing memo:", error);
  }
};

// メモを削除
const deleteMemo = async () => {
  if (confirm("Delete this memo?")) {
    try {
      const res = await MemoApiService.delete(route.params.id);
      if (res.statusText === "No Content") {
        alert("Successfully deleted memo");
        moveToMemoList();
      } else {
        alert("Failed to delete memo");
      }
    } catch (error) {
      console.error("Error deleting memo:", error);
    }
  }
};

// メモ一覧に移動
const moveToMemoList = () => {
  router.push(`/`);
};

// 編集ボタンをクリック
const clickEditButton = () => {
  getMemo(false);
  isShowEditMemoModal.value = !isShowEditMemoModal.value;
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

// コンポーネントのマウント時にメモを取得
onMounted(() => {
  getMemo(true);
  console.log(memo)
});
</script>

<template>
  <header>
    <div class="header1">
      <va-button round size="large" icon="arrow_back" @click="moveToMemoList" />
    </div>
    <div class="header2">
      <div class="va-h1">
        {{ memo.Title }}
      </div>
      <div class="buttons">
        <va-button @click="clickEditButton">Edit</va-button>
        <va-button @click="deleteMemo">Delete</va-button>
      </div>
    </div>
  </header>
  <main>
    <div v-html="unescape(memo.Content)"></div>
  </main>
  <va-modal v-model="isShowEditMemoModal" hide-default-actions>
    <va-form ref="updateFormRef">
      <div class="va-form-header">
        <va-button round icon="close" style="width: 10px;" @click="isShowEditMemoModal = !isShowEditMemoModal" />
      </div>
      <va-input v-model="editMemo.Title" label="title"
        :rules="[(value) => (value && value.length > 0) || 'title is required']" />

      <va-input v-model="editMemo.Content" type="textarea" label="content" autosize
        :rules="[(value) => (value && value.length > 0) || 'content is required']" />

      <va-button :disalbed="!isValid" @click="editMemoFunc()">
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
  flex-flow: column;
  justify-content: flex-start;

  .header1 {
    padding-bottom: 50px;
  }

  .header2 {
    display: flex;
    justify-content: space-between;

    .buttons {
      display: flex;
      align-items: center;
    }

    .buttons * {
      margin: 0 20px;
    }
  }
}

main {
  white-space: pre-wrap;
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