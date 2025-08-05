/*
  Warnings:

  - Changed the type of `question_type` on the `Question` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "Question" DROP COLUMN "question_type",
ADD COLUMN     "question_type" "QuestionType" NOT NULL;
